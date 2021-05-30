import 'package:flutter/material.dart';
import 'package:secure_messaging/screen/login_screen.dart';
class WelcomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text("Secured Messaging"),backgroundColor: Colors.red,),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("Welcome",textAlign: TextAlign.center,),
            Builder(
              builder: (context) => FloatingActionButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                  },child: Icon(Icons.arrow_forward_ios,),backgroundColor: Colors.red,),
              ),
          ],
        ),
      ),
    );
  }
}
