import 'dart:ui';
import 'package:flutter/material.dart';
import 'chat.dart';

class ChatCard extends StatefulWidget {
  final Chat? chat;
  final VoidCallback? press;
  ChatCard({this.chat,required this.press});
  @override
  _ChatCardState createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.press,
      child: Container(
        padding: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
        CircleAvatar(radius: 25,),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.chat!.name!,style: TextStyle(

                    fontWeight: FontWeight.bold,
                    fontSize: 20
                ),
                ),
                Text(widget.chat!.lastMessage!)
                  ],
                ),
          ),
        ),
            Text(widget.chat!.time!),
          ],
        ),
      ),
    );
  }
}
