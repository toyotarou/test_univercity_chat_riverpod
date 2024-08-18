import 'package:chat/main.dart';
import 'package:chat/providers/auth_provider.dart';
import 'package:chat/providers/firestore_provider.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  testWidgets(
    'テストと投稿するとそれが画面上に正しく表示されるか',
    (tester) async {
      await mockNetworkImagesFor(
        () async {
          await tester.pumpWidget(
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

          expect(find.text('テスト'), findsNothing);

          await tester.pumpAndSettle();

          await tester.enterText(find.byType(TextFormField), 'テスト');

          await tester.testTextInput.receiveAction(TextInputAction.done);
          await tester.pumpAndSettle();

          expect(find.text('テスト'), findsOneWidget);

          expect(find.text('豊田　英之'), findsOneWidget);
        },
      );
    },
  );
}
