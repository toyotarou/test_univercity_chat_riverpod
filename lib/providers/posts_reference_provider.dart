import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/post/post.dart';
import 'firestore_provider.dart';

final postsReferenceProvider = Provider(
  (ref) {
    /// ほかの provider を参照したい場合は ref をつかう。
    final firestore = ref.read(firestoreProvider);

    return firestore.collection('posts').withConverter<Post>(
          fromFirestore: (snapshot, option) => Post.fromFirestore(snapshot),
          toFirestore: (value, option) => value.toMap(),
        );
  },
);
