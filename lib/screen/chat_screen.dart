import 'package:chat_app/widgets/chat/messages.dart';
import 'package:chat_app/widgets/chat/news_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


//stream is dart object that emit new value when data source change
///snapshots Notifies of query results at this location. emit new value when data change ,set up listen through firebase database to listen to firestore(subscription to the database)


class ChatScreen extends StatelessWidget {
  final String chatId ;

  ChatScreen(this.chatId);

  @override
  Widget build(BuildContext context) {
//    print('messages builder');
    return Scaffold(
      appBar: AppBar(
        title: Text("chat app"),
        actions: [

          DropdownButton(
            icon: Icon(Icons.more_vert),
            items: [
              DropdownMenuItem(
                child: Row(
                  children: [
                    Icon(Icons.exit_to_app),
                    Text("Log out")
                  ],
                ),
                value: 'LogOut',
              )
            ],
            onChanged: (value) {
              // when the user click sign out the page of chat screen still load
              // when use click on the message it push the chat screen on the all user screen, but i dont know why when sign out still try to display the message again
              Navigator.of(context).pop(); // we have to pop here since this screen is push on the top of the all user so if you dont pop even the streambuilder change of auth still display this screen
              FirebaseAuth.instance.signOut();

                // log out
            },)
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Messages(chatId),
            ),
            NewMessage(chatId),
          ],
        ),
      )



    );

  }
}
