// ignore_for_file: deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseAuthProvider = Provider((ref) => FirebaseAuth.instance);

final userProvider = StreamProvider((ref) {
  final firebaseAuth = ref.read(firebaseAuthProvider);
  return firebaseAuth.userChanges();
});

final uidProvider = StreamProvider((ref) {
  return ref.watch(userProvider.stream).map((user) => user?.uid);
});
