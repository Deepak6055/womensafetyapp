import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/custom_text.dart';
import 'package:flutter_application_1/components/primary_button.dart';
import 'package:flutter_application_1/components/secondary_button.dart';
import 'package:flutter_application_1/child/child_login_screen.dart';
import 'package:flutter_application_1/model/user_model.dart';
import 'package:flutter_application_1/utils/constants.dart';

class RegisterChildScreen extends StatefulWidget {
  @override
  State<RegisterChildScreen> createState() => _RegisterChildScreenState();
}

class _RegisterChildScreenState extends State<RegisterChildScreen> {
  bool isPasswordshown = true;

  final _formkey = GlobalKey<FormState>();

  final _formData = Map<String,Object>();

  bool isLoading  = false;


_onSubmit() async{
    _formkey.currentState!.save();
    if (_formData['password']!=_formData['rpassword']) {
      dialoguebox(context, 'password and retype password should be equal');
    } else {
      progressIndicator(context);
      try {
        setState(() {
          isLoading = true;
        });
  UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
   email:_formData['email'].toString(),
    password:_formData['password'].toString());
    if(userCredential.user != null){
      final v = userCredential.user!.uid;
      DocumentReference<Map<String, dynamic>> db =
            FirebaseFirestore.instance.collection('users').doc(v);
            final user = UserModel(
              name: _formData['name'].toString(),
              phone: _formData['phone'].toString(),
              childEmail: _formData['cemail'].toString(),
              gaurdianEmail: _formData['gemail'].toString(),
              id: v,
            );
            final jsonData = user.toJson();
            await db.set(jsonData).whenComplete(() {
              goto(context, LoginScreen());
              setState(() {
                isLoading= false;
              });
            } );
}
}on FirebaseAuthException catch (e) {
  setState(() {
    isLoading = false;
  });
  if (e.code == 'weak-password') {
    print('The password provided is too weak.');
    dialoguebox(context, 'The password provided is too weak.');
  } else if (e.code == 'email-already-in-use') {
    print('The account already exists for that email.');
    dialoguebox(context, 'The account already exists for that email.');
  }
} catch (e) {
  print(e);
  setState(() {
    isLoading = false;
  });
  dialoguebox(context, e.toString());
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
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [ isLoading
              ? progressIndicator(context):
                     Container(
                          height: MediaQuery.of(context).size.height*0.3,
                          child: Column(
                            mainAxisAlignment:MainAxisAlignment.center ,
                            children: [
                              Text(
                                "User Register",
                                textAlign: TextAlign.center,
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
                      height: MediaQuery.of(context).size.height*0.85 ,
                
                      child: Form(
                        key: _formkey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CustomTextField(
                              hintText: 'Enter name',
                              textInputAction: TextInputAction.next,
                              keyBoardtype: TextInputType.emailAddress,
                              prefix: Icon(Icons.person),
                              onsave: (name) {
                                  _formData['name'] = name ?? "";
                              },
                              validate: (name) {
                                if(name!.isEmpty || name.length<3)
                                {
                                  return "enter a valid name";
                                }
                                return null;
                              },
                            ),
                            CustomTextField(
                              hintText: 'Enter Phone',
                              textInputAction: TextInputAction.next,
                              keyBoardtype: TextInputType.phone,
                              prefix: Icon(Icons.phone),
                              onsave: (phone) {
                                  _formData['phone'] = phone ?? "";
                              },
                              validate: (phone) {
                                if(phone!.isEmpty || phone.length<10)
                                {
                                  return "enter a valid Number";
                                }
                                return null;
                              },
                            ),
                            CustomTextField(
                              hintText: 'Enter Email',
                              textInputAction: TextInputAction.next,
                              keyBoardtype: TextInputType.emailAddress,
                              prefix: Icon(Icons.person),
                              onsave: (email) {
                                  _formData['cemail'] = email ?? "";
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
                              hintText: 'Enter Gaurdian Email',
                              textInputAction: TextInputAction.next,
                              keyBoardtype: TextInputType.emailAddress,
                              prefix: Icon(Icons.person),
                              onsave: (gemail) {
                                  _formData['gemail'] = gemail ?? "";
                              },
                              validate: (gemail) {
                                if(gemail!.isEmpty || gemail.length<3||!gemail.contains("@"))
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
                                              CustomTextField(
                          hintText: 'Retype Password',
                          isPassword: isPasswordshown,
                          prefix: Icon(Icons.vpn_key_rounded),
                           onsave: (password) {
                                  _formData['rpassword'] = password ?? "";
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
                        PrimaryButton(title: 'Register',onPressed: (){
                          if(_formkey.currentState!.validate()){
                              _onSubmit();
                          }
                          
                        }),
                          ],
                        ),
                      ),
                    ),
                    SecondaryButton(title: 'Login with your account',onPressed:(){
                      goto(context, LoginScreen());
                    }),
                  ],
                        
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}