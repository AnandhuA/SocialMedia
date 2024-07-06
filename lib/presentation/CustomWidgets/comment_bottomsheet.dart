import 'package:flutter/material.dart';
import 'package:social_media/core/size.dart';
import 'package:social_media/presentation/CustomWidgets/confirmation_diloge.dart';

Future<dynamic> commentBottomSheet({
 required BuildContext context,
  
 required
  TextEditingController commentController,
  // required GlobalKey<FormState> formkey,
  // required List<Comment> comments,
  required String id,
}) {
  return showModalBottomSheet(
//     backgroundColor: kwhiteColor,
    context: context,
    builder: (context) => Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 25,
              ),
              constWidth10,
              Expanded(
                child: Form(
                  // key: formkey,
                  child: TextFormField(
                    controller: commentController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(7),
                      hintText: 'write a comment....',
                      suffix: TextButton(
                        onPressed: () {
                         
                        },
                        child: const Text(
                          'Post',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Write comment';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
              )
            ],
          ),
          const Divider(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.415,
            child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        radius: 18,
                      ),
                      constWidth10,
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              maxLines: 5,
                              "  comment.user.userName,",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis),
                            ),
                            Text(
                              maxLines: 100,
                              "comment.content,",
                              style: TextStyle(
                                  fontSize: 15,
                                  overflow: TextOverflow.ellipsis),
                            ),
                            Text(
                              "",
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      constWidth10,
                      GestureDetector(
                        onTap: () {
                          confirmationDiloge(
                              context: context,
                              title: "Delete",
                              confirmBtn: () {
                                Navigator.pop(context);
                              },
                              content: "Are you sure want to Delete comment ?");
                        },
                        child: const Icon(
                          Icons.delete_rounded,
                          size: 22,
                        ),
                      )
                    ],
                  );
                }),
          ),
        ],
      ),
    ),
  );
}
