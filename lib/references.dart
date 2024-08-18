import 'package:cloud_firestore/cloud_firestore.dart';

import 'models/post/post.dart';

final postsReference_WithConverter =
    FirebaseFirestore.instance.collection('posts').withConverter<Post>(
          fromFirestore: (snapshot, _) => Post.fromFirestore(snapshot),
          toFirestore: (value, _) => value.toMap(),
        );
