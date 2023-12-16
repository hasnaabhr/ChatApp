import 'package:chat/constants.dart';
import 'package:chat/models/messages.dart';
import 'package:chat/widgets/ChatBuble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: must_be_immutable
class ChatPage extends StatefulWidget {
  const ChatPage({super.key});
  static String id = 'ChatPage';

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ScrollController _controller = ScrollController();
  bool isLoading = false;
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollections);

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy(Kcreatedat, descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Message> messageslist = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messageslist.add(
                Message.fromJson(snapshot.data!.docs[i]),
              );
            }
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: kPrimaryColor,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/chat-app.png',
                      width: 100,
                      height: 50,
                    ),
                    const Text(
                      'Let\'s chat',
                      style: TextStyle(fontSize: 27, color: Colors.white),
                    ),
                  ],
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      controller: _controller,
                      itemCount: messageslist.length,
                      itemBuilder: (context, index) {
                        return messageslist[index].id == email
                            ? ChatBuble(
                                message: messageslist[index],
                              )
                            : ChatBubleForFriend(message: messageslist[index]);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: TextField(
                      controller: controller,
                      onSubmitted: (data) {
                        messages.add({
                          kMessage: data,
                          Kcreatedat: DateTime.now(),
                          'id': email
                        });
                        controller.clear();
                        _controller.animateTo(
                          0,
                          curve: Curves.easeOut,
                          duration: const Duration(milliseconds: 500),
                        );
                      },
                      style:
                          const TextStyle(fontSize: 18, color: kPrimaryColor),
                      decoration: InputDecoration(
                        hintText: 'Send Message',
                        suffixIcon: IconButton(
                            icon: const Icon(Icons.send), onPressed: () {}),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Text('loading....');
          }
        });
  }
}
