import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grove/router.dart';
import 'package:grove/shared/storage/authetication.dart';
import 'package:http/http.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? token;

  @override
  void initState() {
    super.initState();

    AuthenticationStorage.read().then((token) {
      if (token == null) {
        router.push('/login');
      } else {
        this.token = token;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (token == null) {
      return const Scaffold();
    }

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: FutureBuilder(
            future: getAuthenticatedUser(token!),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const CircularProgressIndicator();
                case ConnectionState.done:
                  if (snapshot.data == null) {
                    return const Text('Error');
                  }

                  final data = snapshot.data!['bot']['owner']['user'];

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(data['id']),
                      const SizedBox(height: 4.0),
                      Text(data['name']),
                      const SizedBox(height: 20.0),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(32.0),
                        child: Image.network(
                          data['avatar_url'],
                          width: 64.0,
                          height: 64.0,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      FilledButton(
                        child: const Text('Go to'),
                        onPressed: () {
                          context.go('/login');
                        },
                      )
                    ],
                  );
                default:
                  return const Text('Home Screen');
              }
            },
          ),
        ),
      ),
    );
  }
}

Future<Map<String, dynamic>> getAuthenticatedUser(String token) async {
  final response = await get(
    Uri.parse('https://api.notion.com/v1/users/me'),
    headers: {
      'Authorization': 'Bearer $token',
      'Notion-Version': '2022-06-28',
    },
  );
  final body = jsonDecode(response.body);

  return body;
}
