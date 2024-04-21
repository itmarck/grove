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
                  return Text('Error: ${snapshot.error}');
                case ConnectionState.none:
                  return OutlinedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Colors.transparent,
                      ),
                      foregroundColor: MaterialStateProperty.all(
                        Theme.of(context).colorScheme.onBackground,
                      ),
                      shape: MaterialStateProperty.all(
                        const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        ),
                      ),
                    ),
                    onPressed: _onPressed,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/notion.png',
                          width: 24.0,
                          height: 24.0,
                        ),
                        const SizedBox(width: 8.0),
                        const Text('Connect with Notion'),
                      ],
                    ),
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}
