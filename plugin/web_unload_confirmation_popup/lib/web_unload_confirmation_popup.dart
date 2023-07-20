import "web_unload_confirmation_popup_platform_interface.dart";

class WebUnloadConfirmationPopup {
  static void activate() {
    WebUnloadConfirmationPopupPlatform.instance.activate();
  }

  static void deactivate() {
    WebUnloadConfirmationPopupPlatform.instance.deactivate();
  }
}
