import os
import socket
import threading
import gi
gi.require_version("Gtk", "3.0")
gi.require_version("GtkLayerShell", "0.1")
from gi.repository import Gtk, GLib, Gdk, GtkLayerShell

from fabric import Application
from fabric.widgets.wayland import WaylandWindow as Window
from fabric.widgets.box import Box
from fabric.widgets.label import Label
from fabric.widgets.button import Button
from fabric.widgets.scale import Scale

from modules.sysinfo import SystemInfoModule

SOCKET_PATH = "/tmp/mist_dashboard.sock"

class MistDashboard(Window):
    def __init__(self, app):
        super().__init__(
            layer="top",
            anchor="top left",
            visible=False,
            all_visible=False,
        )
        GtkLayerShell.set_exclusive_zone(self, -1)
        self.app = app
        self.set_name("mist-dashboard-root")

        # critical: strip all os borders
        # self.set_decorated(False)

        # tracker to see if mouse has successfully entered the widget boundaries
        self.mouse_is_inside = False

        self.main_layout = Box(
            name="dashboard-main-container",
            orientation="h",
            spacing=18
        )

        # connect native hardware signal bridges to track direct pointer interaction
        self.connect("enter-notify-event", self.on_window_hover_enter)
        self.connect("leave-notify-event", self.on_window_hover_leave)

        # 5 separate columns
        self.init_sidebar_column()
        self.init_widget_column()
        self.init_notification_column()
        self.init_calendar_column()
        self.init_slider_column()

        self.add(self.main_layout)
        self.show_all()
        self.set_visible(False)

    def init_sidebar_column(self):
        # stacking items vertically
        self.sidebar = Box(
            name="dashboard-sidebar",
            orientation="v",
            spacing=12
        )

        self.media_btn = Button(label="󰎈 ", tooltip_text="Media Mode")
        self.sysinfo_btn = Button(label="󰄦 ", tooltip_text="System Information")
        self.theme_btn = Button(label="󰔎 ", tooltip_text="Theme Manager")
        self.apps_btn = Button(label="󰀻 ", tooltip_text="App Selector")

        # spacing so that settings button sits at the absolute bottom
        self.sidebar_spacer = Gtk.Box(orientation=Gtk.Orientation.VERTICAL)
        
        self.settings_btn = Button(
            name="sidebar-settings-btn",
            label="󰒓 ",
            tooltip_text="Settings"
        )

        self.sidebar.pack_start(self.media_btn, False, False, 0)
        self.sidebar.pack_start(self.sysinfo_btn, False, False, 0)
        self.sidebar.pack_start(self.theme_btn, False, False, 0)
        self.sidebar.pack_start(self.apps_btn, False, False, 0)
        self.sidebar.pack_start(self.sidebar_spacer, True, True, 0)     # grab all trailing space
        self.sidebar.pack_end(self.settings_btn, False, False, 0)

        self.main_layout.pack_start(self.sidebar, False, False, 0)

    def init_widget_column(self):
        self.widget_pane = Box(
            name="dashboard-widget-pane",
            orientation="v",
            spacing=10
        )

        self.sys_info_module = SystemInfoModule()
        self.main_layout.pack_start(self.sys_info_module, True, True, 0)

        self.main_layout.pack_start(self.widget_pane, True, True, 0)
        
    def init_notification_column(self):
        self.notification_pane = Box(
            name="dashboard-notification-pane",
            orientation="v",
            spacing=8
        )
        self.notification_pane.pack_start(Label("󰂚 Notifications", name="pane-header"), False, False, 0)

        # placeholder for now
        self.notification_pane.set_size_request(280, -1)
        self.main_layout.pack_start(self.notification_pane, True, True, 0)

    def init_calendar_column(self):
        self.calendar_pane = Box(
            name="dashboard-calendar-pane",
            orientation="v",
            spacing=8
        )
        
        self.gtk_calendar = Gtk.Calendar()
        self.calendar_pane.pack_start(self.gtk_calendar, True, True, 0)

        self.main_layout.pack_start(self.calendar_pane, False, False, 0)

    def init_slider_column(self):
        self.slider_pane = Box(
            name="dashboard-slider-pane",
            orientation="h",
            spacing=16
        )

        # top toggles container
        self.toggle_header = Box(
            orientation="v",
            spacing=12
        )
        self.vol_toggle = Button(label=" ", tooltip_text="Volume")
        self.brightness_toggle = Button(label="󰃟 ", tooltip_text="Brightness")
        self.mic_toggle = Button(label=" ", tooltip_text="Microphone Volume")

        self.toggle_header.pack_start(self.vol_toggle, True, True, 0)
        self.toggle_header.pack_start(self.brightness_toggle, True, True, 0)
        self.toggle_header.pack_start(self.mic_toggle, True, True, 0)

        # shared scale component
        self.shared_scale = Scale(
            name="dashboard-shared-slider",
            orientation="vertical",
            min=0,
            max=100,
            value=65,
            inverted=True
        )

        self.slider_pane.pack_start(self.toggle_header, False, False, 0)
        self.slider_pane.pack_start(self.shared_scale, True, True, 0)

        self.main_layout.pack_start(self.slider_pane, False, False, 0)

    
    # signal triggers tracking mouse pointer coords directly
    def on_window_hover_enter(self, widget, event):
        self.mouse_is_inside = True

    def on_window_hover_leave(self, widget, event):
        if event.detail == Gdk.NotifyType.INFERIOR:
            return
        
        """
        crossing event representing a real leave must occur at the window's boundary
        if the coordinates are far from any edge, it means the leave was triggered
        by an overlapping window (like a tooltip) grabbing the pointer
        """
        alloc = self.get_allocation()
        tolerance = 10
        on_edge = (
            event.x <= tolerance or 
            event.x >= (alloc.width - tolerance) or 
            event.y <= tolerance or 
            event.y >= (alloc.height - tolerance)
        )
        
        if not on_edge:
            return  # ignore the leave event since it didnt happen at the window boundaries
            
        self.mouse_is_inside = False
        self.set_visible(False)

    def handle_external_close_signal(self):
        # only accept the qml close req if mouse hasnt made it inside yet
        if not self.mouse_is_inside:
            self.set_visible(False)

    def move_and_reveal(self, x, y, pill_width=0.0):
        # reposition surface coordinate bounding points safely before rendering canvas
        if pill_width > 0:
            _, natural_size = self.get_preferred_size()
            widget_width = natural_size.width
            if widget_width > 1:
                x = x + (pill_width / 2) - (widget_width / 2)
        
        self.margin = (int(max(0, y)), 0, 0, int(max(0, x)))
        self.set_visible(True)

    def close_widget(self):
        self.set_visible(False)

# socket server loop running in an isolated execution thread
def start_ipc_listener(window_instance):
    if os.path.exists(SOCKET_PATH):
        os.remove(SOCKET_PATH)

    server = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
    server.bind(SOCKET_PATH)
    server.listen(1)

    while True:
        conn, _ = server.accept()

        while True:
            data = conn.recv(1024)
            if not data:
                break
            message = data.decode("utf-8").strip()

            if message.startswith("OPEN"):
                coords = message.split(":")[1].split(",")
                x = float(coords[0])
                y = float(coords[1])
                pill_width = float(coords[2]) if len(coords) > 2 else 0.0
                # safely schedule geometry modifications inside the main thread loop
                GLib.idle_add(window_instance.move_and_reveal, x, y, pill_width)
            elif message == "CLOSE":
                GLib.idle_add(window_instance.handle_external_close_signal)
        conn.close()

if __name__ == "__main__":
    app = Application("mist-dashboard")
    window = MistDashboard(app)

    ipc_thread = threading.Thread(
        target=start_ipc_listener,
        args=(window,),
        daemon=True
    )
    ipc_thread.start()

    app.run()

