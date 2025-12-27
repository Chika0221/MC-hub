//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <bitsdojo_window_windows/bitsdojo_window_plugin.h>
#include <hid4flutter/hid4flutter_plugin_c_api.h>
#include <keyboard_event/keyboard_event_plugin.h>
#include <rive_native/rive_native_plugin.h>
#include <tray_manager/tray_manager_plugin.h>
#include <windows_notification/windows_notification_plugin_c_api.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
  BitsdojoWindowPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("BitsdojoWindowPlugin"));
  Hid4flutterPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("Hid4flutterPluginCApi"));
  KeyboardEventPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("KeyboardEventPlugin"));
  RiveNativePluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("RiveNativePlugin"));
  TrayManagerPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("TrayManagerPlugin"));
  WindowsNotificationPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("WindowsNotificationPluginCApi"));
}
