import 'package:flutter/material.dart';
import 'package:memorial_flow/main.dart';
import 'package:memorial_flow/screens/login.screen.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Map<String, dynamic>? userMetadata;
  late String? avatarUrl;

  @override
  void initState() {
    super.initState();
    userMetadata = supabase.auth.currentUser?.userMetadata;
    avatarUrl = userMetadata?['avatar_url'];
  }

  void signOutAndNavigateToLogin(BuildContext context) async {
    await Supabase.instance.client.auth.signOut();

    // 로그아웃 후 로그인 화면으로 이동
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false, // 이전 화면들을 모두 삭제하고 새 화면으로 이동
    );
  }

  void userMetadataPrint() {
    print(userMetadata);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    image: avatarUrl == null
                        ? null
                        : DecorationImage(
                            image: NetworkImage(avatarUrl!),
                            fit: BoxFit.cover, // 이미지를 적절하게 표시하도록 fit 속성 추가
                          ),
                  ),
                  width: 100,
                  height: 100,
                ),
                Column(
                  children: [
                    Text('${userMetadata?['preferred_username']}'),
                  ],
                ),
              ],
            ),
          ),
          // ...
        ],
      ),
    );
  }
}
