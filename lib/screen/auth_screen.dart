import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../widgets/auth/auth_form.dart';
// to send the request to firebase create the user
// we can handle the send to the auth form but to make easy to change and edit we would handle in auth screen so the auth form is only to get value ,

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isloading=false;
  FirebaseAuth _auth= FirebaseAuth.instance;


  Future _handlesaveform(String userEmail, String username, String userPassword, File imagefile, BuildContext ctx) async {


    UserCredential _response;
    try{
      setState(() {
        _isloading=true;
      });
      if(username == null){
//        print("start create user");
        _response = await _auth.signInWithEmailAndPassword(email: userEmail, password: userPassword);

      }
      else{
        _response = await _auth.createUserWithEmailAndPassword(email: userEmail, password: userPassword);

        final _ref = FirebaseStorage.instance.ref().child('userImage/${_response.user.uid}.jpg');
        await _ref.putFile(imagefile).onComplete; // oncomplete return future  of StorageTaskSnapshot
        final _imageurl = await _ref.getDownloadURL();

        //set it to user of real time, i want to set document id to uid so it easy to extract after
        await FirebaseFirestore.instance.collection('Users').doc(_response.user.uid).set({
          'username': username,
          'email': userEmail,
          'imageurl': _imageurl,
        });
      }
//      setState(() { // you dont need to call set state since it would navigate to another page already
//        _isloading=false;
//      });

    } catch(error){
      if(error.message !=null){
        Scaffold.of(ctx).showSnackBar(
            SnackBar(
              content: Text(error.message),
              backgroundColor: Theme.of(ctx).errorColor,
            ));
        setState(() {
          _isloading=false;
        });
      }

    }
//    catch(error){
//      print("catch error auth screen"); // show snack bar
//      print(error);
//      if (!mounted) return;
//      setState(() {// this cause the problem call setstate when it already mounted
//        _isloading=false;
//      });
//    }


}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_handlesaveform,_isloading),
    );
  }
}
