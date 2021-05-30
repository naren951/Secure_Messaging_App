import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageScreen extends StatefulWidget {
  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              BackButton(
                onPressed: () => Navigator.pop(context),
              ),
              CircleAvatar(
                radius: 20,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Narendiran",
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          backgroundColor: Colors.red,
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.local_phone)),
            IconButton(onPressed: () {}, icon: Icon(Icons.videocam)),
            SizedBox(
              width: 10,
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 5,
            vertical: 2.5,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 4),
                blurRadius: 32,
                color: Color(0xFF087949).withOpacity(0.08),
              ),
            ],
          ),
          child: SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  CircleAvatar(
                      backgroundColor: Colors.red,
                      child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.add,
                            color: Colors.white,
                          ))),
                  SizedBox(width: 5),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: "Type message",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  CircleAvatar(
                      backgroundColor: Colors.red,
                      child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.send,
                            color: Colors.white,
                          ))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
