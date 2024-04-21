import 'dart:convert';

import 'package:grove/shared/storage/authetication.dart';
import 'package:http/http.dart';

final tokenUrl = Uri.parse('https://grove.itmarck.com/v1/oauth/token');

Future<void> retrievetoken(String code, Function? callback) async {
  final body = jsonEncode({'code': code});
  final response = await post(tokenUrl, body: body);

  if (response.statusCode != 200 || response.body.isEmpty) {
    throw Exception('Failed to retrieve token');
  }

  final bodyJson = jsonDecode(response.body);
  final accessToken = bodyJson['access_token'];

  if (accessToken != null) {
    await AuthenticationStorage.save(accessToken);
  }

  if (callback != null) {
    callback();
  }
}
