import 'package:be_healthy/nutritionist/User.dart';
import 'package:be_healthy/screens/wrapper.dart';
import 'package:be_healthy/shared/constants.dart';
import 'package:be_healthy/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:be_healthy/services/database.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final focus = FocusNode();

  // text field state
  String email = '';
  String password = '';
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign in to Be Healthy'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Register'),
            onPressed: (){
              widget.toggleView();
            },
          )
        ],
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (v){
                    FocusScope.of(context).requestFocus(focus);
                  },
                  decoration: TextInputDecoration.copyWith(hintText: 'Username'),
                  validator: (val)=> val.isEmpty? 'Enter a username': null,
                  onChanged: (val){
                    setState(() => email = val);
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  focusNode: focus,
                  decoration: TextInputDecoration.copyWith(hintText: 'Password'),
                  validator: (val)=> val.length < 3 ? 'Enter a password 3+ chars ': null,
                  obscureText: true, //Pass
                  onChanged: (val){
                    setState(() => password = val);
                  },
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                  color: Colors.pink[400],
                  child: Text(
                    'Sign in',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if(_formKey.currentState.validate()) {
                      setState(()=> loading = true);
                      User result = await DatabaseService().SignIn(email, password);
                      if(result == null){
                        setState(() {
                          error = 'please enter valid email';
                          loading = false;
                        });
                      }
                      else {
                        //var name = result['UserName'];
                        //print('$name');
                       print(result.toString());
                        // Pushing a named route
                        Navigator.of(context).pushNamed(
                          '/home',
                          arguments: result,
                        );
                      }

                    }

                  },
                ),
                SizedBox(height: 12.0),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                )
              ],
            ),
          ),
          decoration: BoxDecoration(
          image: DecorationImage(
          image: AssetImage('assets/bg5.jpg'),
          //alignment: Alignment.bottomLeft,
          fit: BoxFit.fill,
          // fit: BoxFit.scaleDown,
        ),
        ),
      ),

    );
  }
}
