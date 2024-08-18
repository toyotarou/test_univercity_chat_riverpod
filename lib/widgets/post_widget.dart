import 'package:chat/providers/auth_provider.dart';

//
// import 'package:firebase_auth/firebase_auth.dart';
//

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../models/post/post.dart';

//class PostWidget extends StatelessWidget
class PostWidget extends ConsumerWidget {
  const PostWidget({super.key, required this.post});

  final Post post;

  @override
  Widget build(
      //      BuildContext context
      BuildContext context,
      WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
              post.posterImageUrl,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      post.posterName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      // toDate() で Timestamp から DateTime に変換できます。
                      DateFormat('MM/dd HH:mm').format(post.createdAt!),
                      style: const TextStyle(fontSize: 10),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        // 角丸にするにはこれを追加します。
                        // 4 の数字を大きくするともっと丸くなります。
                        borderRadius: BorderRadius.circular(4),

                        //
                        // color: FirebaseAuth.instance.currentUser!.uid ==
                        //         post.posterId
                        //     ? Colors.amber[100]
                        //     : Colors.blue[100],
                        //

                        color:
                            (ref.read(uidProvider).value ?? '') == post.posterId
                                ? Colors.amber[100]
                                : Colors.blue[100],
                      ),
                      child: Text(post.text),
                    ),
                    if (

//                    FirebaseAuth.instance.currentUser!.uid == post.posterId
                        (ref.read(uidProvider).value ?? '') == post.posterId)
                      Row(
                        children: [
                          /// 編集ボタン
                          if (

//                          FirebaseAuth.instance.currentUser!.uid ==post.posterId
                              (ref.read(uidProvider).value ?? '') ==
                                  post.posterId)
                            IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: TextFormField(
                                        initialValue: post.text,
                                        autofocus: true,
                                        onFieldSubmitted: (newText) {
                                          post.reference
                                              .update({'text': newText});
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    );
                                  },
                                );
                              },
                              icon: const Icon(Icons.edit),
                            ),

                          /// 削除ボタン
                          IconButton(
                            onPressed: post.reference.delete,
                            icon: const Icon(Icons.delete),
                          ),
                        ],
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
