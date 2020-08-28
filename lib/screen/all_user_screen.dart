// after the auth page should display the all user screen first then chat screen
// in stateless widget context is not avaible in all the method

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'chat_screen.dart';
// the stateless widget does not have init only the stateful has the init which we can get the current user in init in stead of future builder
class DisplayUser extends StatelessWidget {
  User currentuser = FirebaseAuth.instance.currentUser;

  void chat(String peerusername, BuildContext context){
    String chatId="";
    // create the id between two user
    if(currentuser.uid.hashCode >= peerusername.hashCode){
      chatId = currentuser.uid + '-' +peerusername;
    }
    else{
      chatId = peerusername  + '-' +currentuser.uid;
    }
    // then pop to the chat screen and show the message
//    print(chatId);
    Navigator.push(context,  MaterialPageRoute(builder: (ctx) => ChatScreen(chatId)));
  }


  @override
  Widget build(BuildContext context) {
//    print('all user builder');
    return Scaffold(
        appBar: AppBar(title: Text("All users"),
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
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Users').snapshots(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return  Center(child: CircularProgressIndicator(),);
          }
          var userdoc = snapshot.data.docs;
          List<QueryDocumentSnapshot> availbleuser =[];

          for(var  i=0;i < userdoc.length ; i++){
            if(currentuser.uid !=userdoc[i].documentID){
              availbleuser.add(userdoc[i]);
            }
          }

          return (userdoc.length ==1 && currentuser.uid == userdoc[0].documentID)? Center(child: Text("No user to message"),): ListView.builder(
            itemCount:availbleuser.length,
            itemBuilder: (context, index) {
//              print(userdoc[index].get('username'));
            // display should exclude your self from list
//              print(currentuser.uid != userdoc[index].documentID);
//              print('listview builder');
//              print(index);
//              if(currentuser.uid == userdoc[index].documentID )
//                return null;
//              print(userdoc[index]);
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(availbleuser[index].get('imageurl')),
                ),
                title: Text(availbleuser[index].get('username')),
                trailing: FlatButton.icon(
                    onPressed: () {
                      // from data we can get documentID and use get(field) to get the value of field
                      chat(availbleuser[index].id, context); // get is get the field
                      // to start message
                    } ,
                    icon: Icon(Icons.mail_outline),
                    label: Text("Message")),
              );
            },);
        },
      )
    );

  }
}
