import 'package:cloud_firestore/cloud_firestore.dart';

import 'models/post/post.dart';

final postsReferenceWithConverter =
    FirebaseFirestore.instance.collection('posts').withConverter<Post>(
          fromFirestore: (snapshot, _) => Post.fromFirestore(snapshot),
          toFirestore: (value, _) => value.toMap(),
        );
