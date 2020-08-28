import 'package:chat_app/widgets/chat/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// fetch all from the chat message  but it not personal chat every one are in the same chat room
class Messages extends StatefulWidget {
  final String chatId;

  Messages(this.chatId);

  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  User _currentuser;


  @override
  void initState() {
    // TODO: implement initState
    _currentuser =  FirebaseAuth.instance.currentUser;
//    print(FirebaseFirestore.instance.collection('Users').get());
//    FirebaseFirestore.instance.collection('Users').get().then((value) =>print(value.getDocuments())); query snapshot does not have the getDocuments



    super.initState();
  }

  @override
  Widget build(BuildContext context) {
//    print(_currentuser.uid);
    print(widget.chatId);

    return StreamBuilder(
      // we dont have to add listen since the streambuilder handle it already
        stream:  FirebaseFirestore.instance.collection('chat/${widget.chatId}/messages').orderBy('timestamp', descending: true).snapshots(),
        // this builder will be re execute when the stream change
        builder: (ctx, streamSnapshot) {
          if(streamSnapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }
          final documents =  streamSnapshot.data.docs;

          return documents!=null? ListView.builder(
            reverse: true,
            itemCount:documents.length,
            itemBuilder: (context, index) {
//                  print(documents[index].get('text')); get, get the value of speicific field, get all the field
              return Container(
                  padding: EdgeInsets.all(10),
                  child: MessageBubble(
                    imageurl: documents[index].get('imageurl'),
                    isMe: _currentuser.uid== documents[index].get('useruid'),
                    username:documents[index].get('username') ,
                    message:documents[index].get('text') , ),
                // message buble need the image url, username, isMe , message

              );
            },
          ): null;
        }
    );
  }
}
