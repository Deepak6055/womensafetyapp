import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/primary_button.dart';
import 'package:flutter_application_1/components/secondary_button.dart';
import 'package:flutter_application_1/components/custom_text.dart';
import 'package:flutter_application_1/child/register_child.dart';
import 'package:flutter_application_1/home_screen.dart';
import 'package:flutter_application_1/parent/parent_login_screen.dart';
import 'package:flutter_application_1/utils/constants.dart';

class LoginScreen extends StatefulWidget {
  
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isPasswordshown = true;
  final _formkey = GlobalKey<FormState>();
  final _formData = Map<String,Object>();
  bool isLoading = false;

_onSubmit() async{
  _formkey.currentState!.save();
try {
 setState(() {
   isLoading  = true;
 });
  UserCredential userCredential = await FirebaseAuth.instance
  .signInWithEmailAndPassword(
    email: _formData['email'].toString(),
    password: _formData['password'].toString()
  );
  if (userCredential.user!=null) {
    setState(() {
      isLoading = false;
    });
    goto(context, HomeScreen());
  }
} on FirebaseAuthException catch (e) {
   setState(() {
      isLoading = false;
    });
  if (e.code == 'user-not-found') {
    dialoguebox(context, 'No user found for that email.');
  } else if (e.code == 'wrong-password') {
    dialoguebox(context, 'Wrong password provided for that user.');
  }
}
  print(_formData['email']);
  print(_formData['password']);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            isLoading
              ? progressIndicator(context):
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height*0.3,
                    child: Column(
                      mainAxisAlignment:MainAxisAlignment.center ,
                      children: [
                        Text(
                          "USER LOGIN",
                        style: TextStyle(fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: primaryColor
                        ),
                        ),
                        Image.asset('assets/logo.png',
                    height: 50,
                    width: 100,
                    ),
                      ],
                    ),
                  ),
                  
                  Container(
                    height: MediaQuery.of(context).size.height*0.4 ,
              
                    child: Form(
                      key: _formkey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomTextField(
                            hintText: 'Enter Email',
                            textInputAction: TextInputAction.next,
                            keyBoardtype: TextInputType.emailAddress,
                            prefix: Icon(Icons.person),
                            onsave: (email) {
                                _formData['email'] = email ?? "";
                            },
                            validate: (email) {
                              if(email!.isEmpty || email.length<3||!email.contains("@"))
                              {
                                return "enter a valid email";
                              }
                              return null;
                            },
                          ),
                          CustomTextField(
                        hintText: 'Enter Password',
                        isPassword: isPasswordshown,
                        prefix: Icon(Icons.vpn_key_rounded),
                         onsave: (password) {
                                _formData['password'] = password ?? "";
                            },
                          validate: (password) {
                              if(password!.isEmpty || password.length<7)
                              {
                                return "enter a valid password";
                              }
                              return null;
                            },
                        suffix: IconButton(
                          onPressed: (){
                            setState((){
                            isPasswordshown = !isPasswordshown;
                            });
                          },
                          icon: isPasswordshown
                          ?Icon(Icons.visibility_off)
                          :Icon(Icons.visibility)
                        ),
                      ),
                      PrimaryButton(title: 'Login',
                      onPressed: (){
                        // progressIndicator(context);
                        if(_formkey.currentState!.validate()){
                            _onSubmit();
                        }
                        
                      }),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment:MainAxisAlignment.center ,
                      children: [
                        Text(
                          "Forgort Password?",
                          style: TextStyle(fontSize: 18),
                          ),
                          SecondaryButton(title: 'Click Here',onPressed:(){} ,)
                      ],
                    ),
                  ),
                  SecondaryButton(title: 'User Register',onPressed:(){
                    goto(context, RegisterChildScreen());
                  }),
                  SecondaryButton(title: 'Gaurdian Register',onPressed:(){
                    goto(context, RegisterParentScreen());
                  }),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}