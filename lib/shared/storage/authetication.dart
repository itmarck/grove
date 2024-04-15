import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const _key = 'notn_accss_tkn';

const storage = FlutterSecureStorage(
  aOptions: AndroidOptions(
    encryptedSharedPreferences: true,
  ),
);

class AuthenticationStorage {
  static Future<String?> read() async {
    return await storage.read(key: _key);
  }

  static Future<void> save(String token) async {
    await storage.write(key: _key, value: token);
  }
}
