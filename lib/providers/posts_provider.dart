import 'package:chat/providers/posts_reference_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../references.dart';

/// 全投稿データをstreamで提供するProvider
final postsProvider = StreamProvider((ref) {
//  return postsReferenceWithConverter.orderBy('createdAt').snapshots();

  final postReference = ref.read(postsReferenceProvider);
  return postReference.orderBy('createdAt').snapshots();
});
