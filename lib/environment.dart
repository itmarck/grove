import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  Future<void> load() {
    return dotenv.load(fileName: 'server/.env');
  }

  static String get clientId {
    return dotenv.get('NOTION_CLIENT_ID');
  }

  static String get authorizationUrl {
    return dotenv.get('NOTION_AUTHORIZATION_URL');
  }
}
