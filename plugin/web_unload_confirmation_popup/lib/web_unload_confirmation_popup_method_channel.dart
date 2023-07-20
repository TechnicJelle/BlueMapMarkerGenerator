import "package:flutter/foundation.dart";
import "package:flutter/services.dart";

import "web_unload_confirmation_popup_platform_interface.dart";

/// An implementation of [WebUnloadConfirmationPopupPlatform] that uses method channels.
class MethodChannelWebUnloadConfirmationPopup
    extends WebUnloadConfirmationPopupPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel("web_unload_confirmation_popup");
}
