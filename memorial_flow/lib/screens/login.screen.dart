import 'package:flutter/material.dart';
import 'package:memorial_flow/main.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Screen'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 4.0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Welcome to My App',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Please sign in to continue',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  SupaSocialsAuth(
                    socialProviders: const [
                      SocialProviders.github,
                    ],
                    colored: true,
                    onSuccess: (Session response) {
                      // 로그인 성공 후 메인 화면으로 이동
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) =>
                            const MyApp(), // MainScreen을 실제 화면으로 대체해야 합니다.
                      ));
                    },
                    onError: (error) {
                      // 로그인 오류 처리
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
