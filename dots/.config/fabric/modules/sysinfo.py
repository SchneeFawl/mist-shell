import psutil
import os
import getpass
import socket
import gi
gi.require_version("Gtk", "3.0")
from gi.repository import Gtk, GLib

from fabric.widgets.box import Box
from fabric.widgets.label import Label


class SystemInfoModule(Box):
    def __init__(self):
        super().__init__(
            name="dashboard-system-info-container",
            orientation="v",
            spacing=12
        )

        username = getpass.getuser()
        hostname = socket.gethostname()
        os_release = self.fetch_distro_name()

        self.indentity_box = Box(
            orientation="v",
            spacing=2
        )
        self.indentity_box.add(Label(f" {username}", h_align="start", name="sys-text-bold"))
        self.indentity_box.add(Label(f" {hostname}", h_align="start", name="sys-text-dim"))
        self.indentity_box.add(Label(f"󰻀 {os_release}", h_align="start", name="sys-text-dim"))
        self.pack_start(self.indentity_box, False, False, 0)

        # content divider
        self.divider = Gtk.Separator(orientation=Gtk.Orientation.HORIZONTAL)
        self.divider.set_name("sys-pane-divider")
        self.pack_start(self.divider, False, False, 4)

        # resouce metrics
        self.ram_bar = Gtk.ProgressBar(name="sys-progress")
        self.ram_label = Label(" : ", h_align="start")

        self.cpu_bar = Gtk.ProgressBar(name="sys-progress")
        self.cpu_label = Label(" : ", h_align="start")
        
        self.gpu_bar = Gtk.ProgressBar(name="sys-progress")
        self.gpu_label = Label("󰇺 : ", h_align="start")

        self.disk_bar = Gtk.ProgressBar(name="sys-progress")
        self.disk_label = Label("󰋊 : ", h_align="start")

        # pack items according to layout
        self.append_metric_slot(self.ram_bar, self.ram_label)
        self.append_metric_slot(self.cpu_bar, self.cpu_label)
        self.append_metric_slot(self.gpu_bar, self.gpu_label)
        self.append_metric_slot(self.disk_bar, self.disk_label)


    def append_metric_slot(self, bar_widget, label_widget):
        container = Box(orientation="v", spacing=4)
        container.pack_start(bar_widget, False, False, 0)
        container.pack_start(label_widget, False, False, 0)
        self.pack_start(container, False, False, 4)

    def fetch_distro_name(self):
        try:
            with open("/etc/os-release", "r") as f:
                for line in f:
                    if line.startswith("PRETTY_NAME="):
                        return line.split("=")[1].strip().replace('"', '')
        except:
            return "Arch Linux"

    def poll_hardware_metrics(self):
        # RAM tracker
        ram = psutil.virtual_memory()
        ram_used_gib = ram.used / (1024 ** 3)
        ram_total_gib = ram.total / (1024 ** 3)
        self.ram_bar.set_fraction(ram.percent / 100.0)
        self.ram_label.set_text(f"󰘚  {ram_used_gib:.1f} GiB / {ram_total_gib} GiB")

        # CPU tracker
        cpu_percent = psutil.cpu_percent()
        cpu_temp = self.get_cpu_thermal()
        self.cpu_bar.set_fraction(cpu_percent / 100.0)
        self.cpu_label.set_text(f" {cpu_percent}% | 󰔏 {cpu_temp}°C")

        # GPU tracker block here:

        # disk tracker (root partition)
        disk = psutil.disk_usage('/')
        disk_used_gib = disk.used / (1024 ** 3)
        disk_total_gib = disk.total / (1024 ** 3)
        self.disk_bar.set_fraction(disk.percent / 100.0)
        self.disk_label.set_text(f"󰋊 : {disk_used_gib:.1f} GiB / {disk_total_gib} GiB")

        return True     # retains timeout activation cycle


    def get_cpu_thermal(self):
        for path in ["/sys/class/thermal/thermal_zone0/temp", "/sys/class/hwmon/hwmon0/temp1_input"]:
            if os.path.exists(path):
                with open(path, "r") as f:
                    return int(f.read().strip()) // 1000
        return 0
    

    def get_gpu_states(self):
        try:
            # check AMDGPU sysfs
            if os.path.exists("/sys/class/drm/card0/device/gpu_busy_percent"):
                with open("/sys/class/drm/card0/device/gpu_busy_percent", "r") as f:
                    usage = int(f.read().strip())
                
                with open("/sys/class/drm/card0/device/hwmon/hwmon1/temp1_input", "r") as t:
                    temp = int(t.read().strip()) // 1000
                return usage, temp
        except:
            pass

        return 0, 0

