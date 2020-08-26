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
      ),
      body: StreamBuilder(
        // we dont have to add listen since the streambuilder handle it already
        stream:  FirebaseFirestore.instance.collection('chats/38dwl4yzw34rcClHY8jS/messages').snapshots(),
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
                  child: Text(documents[index].get('text')),
                );
                },
            );
            }
      ),
      floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: (){
                FirebaseFirestore.instance.collection('chats/38dwl4yzw34rcClHY8jS/messages').add({
                  'text': 'this is add by clicking the button'
                });
              },
      ),

    );

  }
}
