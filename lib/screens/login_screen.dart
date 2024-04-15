import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grove/environment.dart';
import 'package:grove/notion/client.dart';
import 'package:url_launcher/url_launcher.dart';

final authorizationUrl = Uri.parse(Environment.authorizationUrl);

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  _onPressed() async {
    if (await canLaunchUrl(authorizationUrl)) {
      await launchUrl(
        authorizationUrl,
        mode: LaunchMode.inAppBrowserView,
      );
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    final code = GoRouterState.of(context).uri.queryParameters['code'] ?? '';

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: FutureBuilder(
            future: code.isEmpty ? null : retrievetoken(code),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.active:
                case ConnectionState.waiting:
                  return const CircularProgressIndicator();
                case ConnectionState.done:
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  return Text('Done with token: ${snapshot.data}');
                case ConnectionState.none:
                  return FilledButton(
                    onPressed: _onPressed,
                    child: const Text('Login with Notion'),
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}
