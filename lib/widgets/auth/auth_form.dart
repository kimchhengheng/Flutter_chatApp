import 'package:flutter/material.dart';
enum AuthMode {SignUp,SignIn}

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _form = GlobalKey<FormState>();
  var _pwcontroller = TextEditingController();
  AuthMode authmode= AuthMode.SignIn;
  var _formdata = {};


  @override
  void dispose() {
    // TODO: implement dispose
    _pwcontroller.dispose();
    super.dispose();
  }
  void saveform(){
    bool valid = _form.currentState.validate();
    if(!valid)
      return;
    _form.currentState.save();
    print(_formdata);
  }
  void toggleSignUpSignIn(){
    if(authmode == AuthMode.SignIn){
      setState(() {
        // the value from sigin keep in sign up
        _form.currentState.reset();
        _pwcontroller.clear();
        authmode = AuthMode.SignUp;
      });
    }
    else{
      setState(() {
        _form.currentState.reset();
        _pwcontroller.clear();
        authmode = AuthMode.SignIn;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
//    var height = MediaQuery.of(context).size.height;

    return Center(
      child: AnimatedContainer(
          duration: Duration(milliseconds: 400),
          curve: Curves.fastOutSlowIn,
          height: authmode == AuthMode.SignUp? 440 : 380,
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
                      TextFormField(

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
                          _formdata['email']=value;
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Username'
                        ),
                        validator: (value) {
                          if(value.isEmpty)
                            return 'Please input valid username';
                          return null;
                        },
                        onSaved: (value){
                          _formdata['username']=value;
                        },
                      ),
                      TextFormField(
                        controller: _pwcontroller,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password'
                        ),
                        validator: (value) {
                          if(value.isEmpty)
                            return 'Please input the password';
                          if(value.length <7)
                            return 'password length have to be at least 7 character';
                          return null;
                        },
                        onSaved: (value){
                          _formdata['password']=value;
                        },
                      ),
                      if(authmode==AuthMode.SignUp)
                        TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                              labelText: 'Confirm Password'
                          ),
                          validator: (value) {
                            if(value.isEmpty)
                              return 'Please input the password';
                            if(value != _pwcontroller.text)
                              return 'password does not match';
                            return null;
                          },

                        ),
                      SizedBox(height: 12,),
                      RaisedButton(
                        child: authmode == AuthMode.SignIn?Text('Sign In'): Text('Sign Up'),// would change between login and sign up
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
