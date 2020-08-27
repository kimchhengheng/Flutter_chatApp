import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// fetch all from the chat message  but it not personal chat every one are in the same chat room
class Messages extends StatefulWidget {
  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      // we dont have to add listen since the streambuilder handle it already
        stream:  FirebaseFirestore.instance.collection('chat/38dwl4yzw34rcClHY8jS/messages').snapshots(),
        // this builder will be re execute when the stream change
        builder: (ctx, streamSnapshot) {
          if(streamSnapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }
          final documents =  streamSnapshot.data.docs;
          return ListView.builder(
            itemCount:documents.length,
            itemBuilder: (context, index) {
//                  print(documents[index].get('text')); get, get the value of speicific field, get all the field
              return Container(
                  padding: EdgeInsets.all(10),

                  child: Column(
                    children: [
                      Text(documents[index].get('text')),

                    ],
                  )

              );
            },
          );
        }
    );
  }
}
