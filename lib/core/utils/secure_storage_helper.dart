import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageHelper {
  final FlutterSecureStorage storage;

  SecureStorageHelper({required this.storage});

  final _accessToken = 'access_token';
  final _refreshToken = 'refresh_token';

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await storage.write(key: _accessToken, value: accessToken);
    await storage.write(key: _refreshToken, value: refreshToken);
  }

  Future<String?> getAccessToken() async {
    return storage.read(key: _accessToken);
  }

  Future<String?> getRefreshToken() async {
    return storage.read(key: _refreshToken);
  }

  Future<bool> hasValidToken() async {
    final token = await storage.read(key: _accessToken);

    if (token == null || token.isEmpty) {
      return false;
    }

    return true;
  }

  Future<void> clear() async {
    await storage.deleteAll();
  }
}
