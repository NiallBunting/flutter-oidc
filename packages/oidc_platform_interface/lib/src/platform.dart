// coverage:ignore-file
import 'package:oidc_core/oidc_core.dart';
import 'package:oidc_platform_interface/oidc_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

/// The interface that implementations of oidc must implement.
///
/// Platform implementations should extend this class
/// rather than implement it as `Oidc`.
/// Extending this class (using `extends`) ensures that the subclass will get
/// the default implementation, while platform implementations that `implements`
///  this interface will be broken by newly added [OidcPlatform] methods.
abstract class OidcPlatform extends PlatformInterface {
  /// Constructs a OidcPlatform.
  OidcPlatform() : super(token: _token);

  static final Object _token = Object();

  static OidcPlatform _instance = NoOpOidcPlatform();

  /// The default instance of [OidcPlatform] to use.
  ///
  /// Defaults to [NoOpOidcPlatform] which throws an exception on each operation.
  static OidcPlatform get instance => _instance;

  /// Platform-specific plugins should set this with their own platform-specific
  /// class that extends [OidcPlatform] when they register themselves.
  static set instance(OidcPlatform instance) {
    PlatformInterface.verify(instance, _token);
    _instance = instance;
  }

  /// Returns the authorization response.
  /// may throw an [OidcException].
  Future<OidcAuthorizeResponse?> getAuthorizationResponse(
    OidcProviderMetadata metadata,
    OidcAuthorizeRequest request,
    OidcPlatformSpecificOptions options,
  );

  /// Returns the authorization response.
  /// may throw an [OidcException].
  Future<OidcEndSessionResponse?> getEndSessionResponse(
    OidcProviderMetadata metadata,
    OidcEndSessionRequest request,
    OidcPlatformSpecificOptions options,
  );

  /// Listens to incoming front channel logout requests.
  Stream<OidcFrontChannelLogoutIncomingRequest>
      listenToFrontChannelLogoutRequests(
    Uri listenOn,
    OidcFrontChannelRequestListeningOptions options,
  );
}

/// an implementation of [OidcPlatform] that throws [UnimplementedError].
class NoOpOidcPlatform extends OidcPlatform {
  @override
  Future<OidcAuthorizeResponse?> getAuthorizationResponse(
    OidcProviderMetadata metadata,
    OidcAuthorizeRequest request,
    OidcPlatformSpecificOptions options,
  ) {
    throw UnimplementedError();
  }

  @override
  Future<OidcEndSessionResponse?> getEndSessionResponse(
    OidcProviderMetadata metadata,
    OidcEndSessionRequest request,
    OidcPlatformSpecificOptions options,
  ) {
    throw UnimplementedError();
  }

  @override
  Stream<OidcFrontChannelLogoutIncomingRequest>
      listenToFrontChannelLogoutRequests(
    Uri listenOn,
    OidcFrontChannelRequestListeningOptions options,
  ) {
    throw UnimplementedError();
  }
}
