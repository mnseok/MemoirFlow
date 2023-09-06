import 'package:flutter/material.dart';
import 'package:memorial_flow/screens/login.screen.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void debug() {
      Supabase.instance.client.auth.signOut();
    }

    return Supabase.instance.client.auth.currentUser != null
        ? TextButton(
            onPressed: debug,
            child: const Text('로그아웃'),
          )
        : const LoginScreen();
  }
}
