import 'package:chat_app/widgets/chat/messages.dart';
import 'package:chat_app/widgets/chat/news_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


//stream is dart object that emit new value when data source change
///snapshots Notifies of query results at this location. emit new value when data change ,set up listen through firebase database to listen to firestore(subscription to the database)


class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              FirebaseAuth.instance.signOut();
                // log out
            },)
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Messages(),
            ),
            NewMessage(),
          ],
        ),
      )



    );

  }
}
