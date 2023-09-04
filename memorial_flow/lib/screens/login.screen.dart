import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SupaSocialsAuth(
      socialProviders: const [
        SocialProviders.github,
      ],
      colored: true,
      redirectUrl: kIsWeb ? null : 'io.mydomain.myapp://callback',
      onSuccess: (Session response) {},
      onError: (error) {},
    );
  }
}
