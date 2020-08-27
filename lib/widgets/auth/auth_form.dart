import 'dart:io';
import 'package:flutter/material.dart';
import '../pickers/user_image_picker.dart';
enum AuthMode {SignUp,SignIn}

class AuthForm extends StatefulWidget {
  bool isloading;
  Function handleform;

  AuthForm(this.handleform, this.isloading);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _form = GlobalKey<FormState>();
  String _email;
  String _username;
  String _password;
  File _image;
//  var _pwcontroller = TextEditingController();
  AuthMode authmode= AuthMode.SignIn;



  @override
  void dispose() {
    // TODO: implement dispose
//    _pwcontroller.dispose();
    super.dispose();
  }
  void setimage(File img){
    setState(() {
      _image = img;
    });
  }
  void saveform(){

    bool valid = _form.currentState.validate();
    FocusScope.of(context).unfocus();
//    print(_image); we have to set state since it is stateful widget and affect the ui data
//    R
    if(!valid)
      return;
    _form.currentState.save();

    widget.handleform(
        _email.trim(),
        _username == null?_username: _username.trim(),
        _password.trim(),
        _image,
        context);
  }
  void toggleSignUpSignIn(){
    FocusScope.of(context).unfocus();
    _form.currentState.reset();
//    print('before set state'); so it finish this method first then call build since it is setstate, not consider about the await and async
    if(authmode == AuthMode.SignIn){

      setState(() {
        // the value from sigin keep in sign up

//        _pwcontroller.clear();
        authmode = AuthMode.SignUp;
      });
    }
    else{
      setState(() {

//        _pwcontroller.clear();
        authmode = AuthMode.SignIn;
      });
    }
//    print('after set state');
  }
  @override
  Widget build(BuildContext context) {
//    var height = MediaQuery.of(context).size.height;
//    print('build');
    return Center(
      child: AnimatedContainer(
          duration: Duration(milliseconds: 400),
          curve: Curves.fastOutSlowIn,
          height: authmode == AuthMode.SignUp? 440 : 320,
//          constraints: BoxConstraints(
//            minHeight: min()
//          ),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            margin: EdgeInsets.all(10),
            child: SingleChildScrollView(
              padding: EdgeInsets.all(15),
              child: Form(
                key: _form,
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children:<Widget>[
                      if(authmode==AuthMode.SignUp)
                        UserImagePicker(setimage),
                        TextFormField(
                        key: ValueKey('email'),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: "Email"
  //                      icon: Icon(Icons.email) ,
                        ),
                        validator: (value) {
                          if(value.isEmpty)
                            return 'Please input the email address';
                          if(!value.contains('@'))
                            return 'Please input the valid email';
                          return null;
                        },
                        onSaved: (value){
                          _email=value;
                        },
                      ),
                      if(authmode==AuthMode.SignUp)
                      TextFormField(
                        key: ValueKey('username'),
                        decoration: InputDecoration(
                          labelText: 'Username'
                        ),
                        validator: (value) {
                          if(value.isEmpty)
                            return 'Please input valid username';
                          return null;
                        },
                        onSaved: (value){
                          _username=value;
                        },
                      ),
                      TextFormField(
                        key: ValueKey('password'),
//                        controller: _pwcontroller,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password'
                        ),
                        validator: (value) {
                          if(value.isEmpty)
                            return 'Please input the password';
                          if(value.length <6)
                            return 'password length have to be at least 7 character';
                          return null;
                        },
                        onSaved: (value){
                          _password=value;
                        },
                      ),
//                      if(authmode==AuthMode.SignUp)
//                        TextFormField(
//                          obscureText: true,
//                          decoration: InputDecoration(
//                              labelText: 'Confirm Password'
//                          ),
//                          validator: (value) {
//                            if(value.isEmpty)
//                              return 'Please input the password';
//                            if(value != _pwcontroller.text)
//                              return 'password does not match';
//                            return null;
//                          },
//
//                        ),
                      SizedBox(height: 12,),


                        RaisedButton(
                          child: widget.isloading? CircularProgressIndicator(): (authmode == AuthMode.SignIn?Text('Sign In'): Text('Sign Up')),// would change between login and sign up
                          onPressed: (){
                            saveform();
  //                          Scaffold.of(context).showSnackBar(SnackBar(
  //                            content: Text('$authmode'),
  //                          ));
                          },
                        ),
                      FlatButton(
                        child:authmode == AuthMode.SignIn? Text('Create new account') :Text('Sign In'),// would toggle between the sign in page and sign up page
                        onPressed: (){toggleSignUpSignIn();} ,
                      )
                    ],  //<widget> just tell them that it is the list of widget
                  ),
              ),
            ),
          ),
        ),
      );
  }
}
