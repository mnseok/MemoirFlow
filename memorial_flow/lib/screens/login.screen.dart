import 'package:flutter/material.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SupaSocialsAuth(
      socialProviders: const [
        SocialProviders.github,
      ],
      colored: true,
      onSuccess: (Session response) {},
      onError: (error) {},
    );
  }
}
