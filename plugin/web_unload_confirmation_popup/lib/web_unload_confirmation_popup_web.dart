import "dart:async";
import "dart:html" as html show window, Event, BeforeUnloadEvent;

import "package:flutter_web_plugins/flutter_web_plugins.dart";

import "web_unload_confirmation_popup_platform_interface.dart";

/// A web implementation of the WebUnloadConfirmationPopupPlatform of the WebUnloadConfirmationPopup plugin.
class WebUnloadConfirmationPopupWeb extends WebUnloadConfirmationPopupPlatform {
  /// Constructs a WebUnloadConfirmationPopupWeb
  WebUnloadConfirmationPopupWeb();

  static void registerWith(Registrar registrar) {
    WebUnloadConfirmationPopupPlatform.instance =
        WebUnloadConfirmationPopupWeb();
  }

  StreamSubscription<html.Event>? subscription;

  @override
  void activate() {
    subscription ??= html.window.onBeforeUnload.listen((event) {
      if (event is html.BeforeUnloadEvent) {
        event.returnValue = "activated";
      }
    });
  }

  @override
  void deactivate() {
    if (subscription == null) return;

    subscription!.cancel();
    subscription = null;
  }
}
