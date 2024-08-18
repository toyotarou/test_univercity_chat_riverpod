import 'package:chat/providers/auth_provider.dart';
import 'package:chat/providers/firestore_provider.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';

//
// import 'package:firebase_auth/firebase_auth.dart';
//

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'firebase_options.dart';
import 'pages/chat_page.dart';
import 'pages/sing_in_page.dart';

Future<void> main() async {
  // main 関数でも async が使えます
  WidgetsFlutterBinding.ensureInitialized(); // runApp 前に何かを実行したいときはこれが必要です。
  await Firebase.initializeApp(
    // これが Firebase の初期化処理です。
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ProviderScope(
      overrides: [
        firestoreProvider.overrideWithValue(FakeFirebaseFirestore()),
        firebaseAuthProvider.overrideWithValue(
          MockFirebaseAuth(
            signedIn: true,
            mockUser: MockUser(
              isAnonymous: false,
              uid: 'someuid',
              email: 'hide.toyoda@gmail.com',
              displayName: '豊田　英之',
              photoURL:
                  'http://toyohide.work/BrainLog/public/UPPHOTO/2024/2024-08-17/20240817_142006821.jpg',
            ),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      theme: ThemeData(),
      home: ref.watch(userProvider).maybeWhen(
            data: (data) {
              if (data == null) {
                return const SignInPage();
              }

              return const ChatPage();
            },
            orElse: () => const Center(child: CircularProgressIndicator()),
          ),
    );
  }
}

/*
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // currentUser が null であればログインしていない
    if (FirebaseAuth.instance.currentUser == null) {
      // 未ログイン
      return MaterialApp(theme: ThemeData(), home: const SignInPage());
    } else {
      // ログイン中
      return MaterialApp(theme: ThemeData(), home: const ChatPage());
    }
  }
}
*/
