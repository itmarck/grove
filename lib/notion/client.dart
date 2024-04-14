import 'dart:convert';

import 'package:http/http.dart';

const groveToken = '';

Future<String> retrievetoken(String code) async {
  final response = await post(Uri.parse(groveToken));

  if (response.statusCode != 200 || response.body.isEmpty) {
    throw Exception('Failed to retrieve token');
  }

  return json.decode(response.body)['access_token'];
}
