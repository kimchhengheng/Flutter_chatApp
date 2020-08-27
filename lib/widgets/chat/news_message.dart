import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _textcontroller = TextEditingController();


  @override
  void initState() {
    _textcontroller.addListener(() {
//      print("listener"); when you go in or out it call setstate because it consider change and listener listen to all change of it
      setState(() {
    });
    });
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _textcontroller.dispose();
    super.dispose();
  }
  Future<void> _sendMessage()async{

      FocusScope.of(context).unfocus();
      final _authuser =await FirebaseAuth.instance.currentUser;
      final userData =await FirebaseFirestore.instance.collection('Users').doc(_authuser.uid).get();
//      print(userData.data()['username']); // .get is get documentsnapshot . Data return Map which allow to get the value like list
      FirebaseFirestore.instance.collection('chat/38dwl4yzw34rcClHY8jS/messages').add({ // add would create auto id
                  'text': _textcontroller.text,
                  'timestamp': Timestamp.now(),
                  'useruid': _authuser.uid,
                  'username': userData.data()['username'],
                  'imageurl': userData.data()['imageurl']
                });
      _textcontroller.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        children: [
            Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).primaryColorLight,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(

                    textCapitalization: TextCapitalization.sentences,
                    autocorrect: true,
                    enableSuggestions: true,
                    controller:_textcontroller,// this is just use to clear when you submit to get the value we on changed, if we want to use controller we use with setstage setstate init
//                onChanged: (value){
//                  setState(() {
//                    _message = value;
//                  });
//                },

                  ),
                ),
              ),

            FlatButton(
                onPressed: _textcontroller.text == "" ? null : () {
//                  print(_textcontroller.text);
                  _sendMessage();
                },
                child: Icon(Icons.send), )
        ],
      ),
    );

  }
}
