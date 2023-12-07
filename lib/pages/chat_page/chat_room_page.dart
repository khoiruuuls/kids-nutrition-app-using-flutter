// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kids_nutrition_app/components/components_back.dart';
import 'package:kids_nutrition_app/components/components_chat_bubble.dart';
import 'package:kids_nutrition_app/components/components_input.dart';
import 'package:kids_nutrition_app/config/config_color.dart';
import 'package:kids_nutrition_app/services/chat_services.dart';
import 'package:line_icons/line_icon.dart';

import '../../config/config_size.dart';

class ChatRoomPage extends StatefulWidget {
  final String receiverUserEmail;
  final String recieverUserID;

  const ChatRoomPage({
    required this.receiverUserEmail,
    required this.recieverUserID,
    super.key,
  });

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  final TextEditingController messageController = TextEditingController();
  final ChatService chatService = ChatService();
  final ScrollController _scrollController = ScrollController();
  final FirebaseAuth auth = FirebaseAuth.instance;

  void sendMessage() async {
    if (messageController.text.isNotEmpty) {
      await chatService.sendMessage(
        widget.recieverUserID,
        messageController.text,
      );
      messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ComponentsBack(textTitle: widget.receiverUserEmail),
            Expanded(
              child: buildMesssageList(),
            ),
            buildMessageInput(),
          ],
        ),
      ),
    );
  }

  Widget buildMesssageList() {
    return StreamBuilder(
      stream:
          chatService.getMessages(widget.recieverUserID, auth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error ${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("");
        }
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeOut,
          );
        });
        return ListView(
          physics: BouncingScrollPhysics(),
          controller: _scrollController,
          children: snapshot.data!.docs
              .map((document) => buildMessageItem(document))
              .toList(),
        );
      },
    );
  }

  Widget buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    var alignment = (data['senderId'] == auth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: paddingMin,
          vertical: paddingMin / 2,
        ),
        child: Column(
          crossAxisAlignment: (data['senderId'] == auth.currentUser!.uid)
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            SizedBox(height: paddingMin * 0.2),
            ComponentsChatBubble(
              message: data["message"],
              colorContainer: (data['senderId'] == auth.currentUser!.uid)
                  ? ConfigColor.chatSend
                  : ConfigColor.chatReceive,
              colorText: (data['senderId'] == auth.currentUser!.uid)
                  ? ConfigColor.chatReceive
                  : ConfigColor.chatSend,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.only(
        left: paddingMin,
        right: paddingMin,
        top: paddingMin,
      ),
      child: Row(
        children: [
          Expanded(
            child: ComponentsInput(
              controller: messageController,
              hintText: "Type anything . . .",
              obscureText: false,
            ),
          ),
          SizedBox(width: paddingMin * 0.1),
          GestureDetector(
            onTap: sendMessage,
            child: Container(
              height: 60,
              child: Align(
                alignment: Alignment.topCenter,
                child: Transform.rotate(
                  angle: 90 *
                      3.141592653589793 /
                      180, // Convert degrees to radians
                  child: LineIcon.locationArrow(
                    color: Colors.grey.shade500,
                    size: 45,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
