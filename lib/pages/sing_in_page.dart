// ignore_for_file: use_build_context_synchronously

import 'package:chat/providers/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../utils/util_log.dart';

//
// import 'chat_page.dart';
//

//class SignInPage extends StatefulWidget
class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({super.key});

  @override
//  State<SignInPage> createState() => _SignInPageState();
  ConsumerState<SignInPage> createState() => _SignInPageState();
}

//class _SignInPageState extends State<SignInPage>
class _SignInPageState extends ConsumerState<SignInPage> {
  Future<void> signInWithGoogle() async {
    // GoogleSignIn をして得られた情報を Firebase と関連づけることをやっています。
    final googleUser =
        await GoogleSignIn(scopes: ['profile', 'email']).signIn();

    final googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

//    await FirebaseAuth.instance.signInWithCredential(credential);
    await ref.read(firebaseAuthProvider).signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GoogleSignIn')),
      body: Center(
        child: ElevatedButton(
          child: const Text('GoogleSignIn'),
          onPressed: () async {
            await signInWithGoogle();

//            utilLog(FirebaseAuth.instance.currentUser?.displayName);
            utilLog(ref.read(userProvider).value?.displayName);

            //
            // if (mounted) {
            //   await Navigator.of(context).pushAndRemoveUntil(
            //     MaterialPageRoute(builder: (context) => const ChatPage()),
            //     (route) => false,
            //   );
            // }
            //
          },
        ),
      ),
    );
  }
}
