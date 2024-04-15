import 'dart:convert';

import 'package:http/http.dart';

final tokenUrl = Uri.parse('https://grove.itmarck.com/oauth/token');

Future<String> retrievetoken(String code) async {
  final body = jsonEncode({'code': code});
  final response = await post(tokenUrl, body: body);

  if (response.statusCode != 200 || response.body.isEmpty) {
    throw Exception('Failed to retrieve token');
  }

  return jsonDecode(response.body)['access_token'];
}
