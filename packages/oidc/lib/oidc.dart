import 'package:oidc_platform_interface/oidc_platform_interface.dart';

OidcPlatform get _platform => OidcPlatform.instance;

/// Returns the name of the current platform.
Future<String> getPlatformName() async {
  final platformName = await _platform.getPlatformName();
  if (platformName == null) throw Exception('Unable to get platform name.');
  return platformName;
}
