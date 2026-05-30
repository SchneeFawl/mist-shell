import os
import sys
import socket
import threading
import gi
gi.require_version("Gtk", "3.0")
from gi.repository import Gtk, GLib

from fabric import Application
from fabric.widgets.window import Window
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
            anchor="none",
            visible=False,
            all_visible=False,
        )
        self.app = app
        self.set_name("mist-dashboard-root")

        self.main_layout = Box(
            name="dashboard-main-container",
            orientation="h",
            spacing=16
        )

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

        self.media_btn = Button(label="󰎈 Media Mode")
        self.sysinfo_btn = Button(label="󰄦 System Info")
        self.theme_btn = Button(label="󰔎 Theme Manager")
        self.apps_btn = Button(label="󰀻 App Selector")

        # spacing so that settings button sits at the absolute bottom
        self.sidebar_spacer = Gtk.Box(orientation=Gtk.Orientation.VERTICAL)
        
        self.settings_btn = Button(
            name="sidebar-settings-btn",
            label="󰒓 Settings"
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
            orientation="v",
            spacing=14
        )

        # top toggles container
        self.toggle_header = Box(
            orientation="h",
            spacing=8
        )
        self.vol_toggle = Button(label="Vol")
        self.brightness_toggle = Button(label="Brightness")
        self.mic_toggle = Button(label="Mic")

        self.toggle_header.pack_start(self.vol_toggle, True, True, 0)
        self.toggle_header.pack_start(self.brightness_toggle, True, True, 0)
        self.toggle_header.pack_start(self.mic_toggle, True, True, 0)

        # shared scale component
        self.shared_scale = Scale(
            name="dashboard-shared-slider",
            orientation="horizontal",
            min=0,
            max=100,
            value=50
        )

        self.slider_pane.pack_start(self.toggle_header, False, False, 0)
        self.slider_pane.pack_end(self.shared_scale, True, False, 0)

        self.main_layout.pack_start(self.slider_pane, False, False, 0)

    def move_and_reveal(self, x, y):
        # reposition surface coordinate bounding points safely before rendering canvas
        self.move(int(x), int(y))
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
                # safely schedule geometry modifications inside the main thread loop
                GLib.idle_add(window_instance.move_and_reveal, coords[0], coords[1])
            elif message == "CLOSE":
                GLib.idle_add(window_instance.close_widget)
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

