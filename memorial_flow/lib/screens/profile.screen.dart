import 'package:flutter/material.dart';
import 'package:memorial_flow/screens/login.screen.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void signOutAndNavigateToLogin(BuildContext context) async {
    await Supabase.instance.client.auth.signOut();

    // 로그아웃 후 로그인 화면으로 이동
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false, // 이전 화면들을 모두 삭제하고 새 화면으로 이동
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = Supabase.instance.client.auth.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('프로필'),
      ),
      body: Center(
        child: currentUser != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    // 이메일 표시
                    '${currentUser.email}',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () =>
                        signOutAndNavigateToLogin(context), // context를 전달
                    child: const Text('로그아웃'),
                  ),
                ],
              )
            : const LoginScreen(),
      ),
    );
  }
}
