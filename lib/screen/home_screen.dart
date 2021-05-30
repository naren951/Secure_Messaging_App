import 'package:flutter/material.dart';
import 'package:secure_messaging/models/chat.dart';
import 'package:secure_messaging/models/chat_card.dart';
import 'package:secure_messaging/screen/message_screen.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final Chat? chat;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          onPressed: (){

          },
          child: Icon(Icons.person_add_alt_1),
        ),
        appBar: AppBar(
          title: Text("Secured Messaging"),
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
          backgroundColor: Colors.red,
        ),
        body: Center(
          child: Column(
            children: [
              Expanded(
                  child: ListView.builder(
                      itemCount: chatData.length,
                      itemBuilder: (context, index) => ChatCard(chat:chatData[index],
                      press: (){
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>MessageScreen()));
                      },
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
