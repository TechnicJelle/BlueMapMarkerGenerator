import "package:plugin_platform_interface/plugin_platform_interface.dart";

import "web_unload_confirmation_popup_method_channel.dart";

abstract class WebUnloadConfirmationPopupPlatform extends PlatformInterface {
  /// Constructs a WebUnloadConfirmationPopupPlatform.
  WebUnloadConfirmationPopupPlatform() : super(token: _token);

  static final Object _token = Object();

  static WebUnloadConfirmationPopupPlatform _instance =
      MethodChannelWebUnloadConfirmationPopup();

  /// The default instance of [WebUnloadConfirmationPopupPlatform] to use.
  ///
  /// Defaults to [MethodChannelWebUnloadConfirmationPopup].
  static WebUnloadConfirmationPopupPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [WebUnloadConfirmationPopupPlatform] when
  /// they register themselves.
  static set instance(WebUnloadConfirmationPopupPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  void activate() {}

  void deactivate() {}
}
