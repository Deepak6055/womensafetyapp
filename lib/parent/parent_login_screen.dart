import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/custom_text.dart';
import 'package:flutter_application_1/components/primary_button.dart';
import 'package:flutter_application_1/components/secondary_button.dart';
import 'package:flutter_application_1/child/child_login_screen.dart';
import 'package:flutter_application_1/model/user_model.dart';
import 'package:flutter_application_1/utils/constants.dart';

class RegisterParentScreen extends StatefulWidget {
  @override
  State<RegisterParentScreen> createState() => _RegisterParentScreenState();
}

class _RegisterParentScreenState extends State<RegisterParentScreen> {
  bool isPasswordShown = true;
  bool isRetypePasswordShown = true;

  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();
  bool isLoading = false;

  _onSubmit() async {
    _formKey.currentState!.save();
    if (_formData['password'] != _formData['rpassword']) {
      dialoguebox(context, 'password and retype password should be equal');
    } else {
      progressIndicator(context);
      try {
        setState(() {
          isLoading = true;
        });
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _formData['gemail'].toString(),
                password: _formData['password'].toString());
        if (userCredential.user != null) {
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
              isLoading = false;
            });
          });
        }
      } on FirebaseAuthException catch (e) {
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
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Stack(
            children: [
              isLoading
                  ? progressIndicator(context)
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "REGISTER AS Parent",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red),
                                ),
                                Image.asset(
                                  'assets/logo.png',
                                  height: 100,
                                  width: 100,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.75,
                            child: Form(
                              key: _formKey,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  CustomTextField(
                                    hintText: 'enter name',
                                    textInputAction: TextInputAction.next,
                                    keyBoardtype: TextInputType.name,
                                    prefix: Icon(Icons.person),
                                    onsave: (name) {
                                      _formData['name'] = name ?? "";
                                    },
                                    validate: (email) {
                                      if (email!.isEmpty || email.length < 3) {
                                        return 'enter correct name';
                                      }
                                      return null;
                                    },
                                  ),
                                  CustomTextField(
                                    hintText: 'enter phone',
                                    textInputAction: TextInputAction.next,
                                    keyBoardtype: TextInputType.phone,
                                    prefix: Icon(Icons.phone),
                                    onsave: (phone) {
                                      _formData['phone'] = phone ?? "";
                                    },
                                    validate: (email) {
                                      if (email!.isEmpty || email.length < 10) {
                                        return 'enter correct phone';
                                      }
                                      return null;
                                    },
                                  ),
                                  CustomTextField(
                                    hintText: 'enter email',
                                    textInputAction: TextInputAction.next,
                                    keyBoardtype: TextInputType.emailAddress,
                                    prefix: Icon(Icons.person),
                                    onsave: (email) {
                                      _formData['gemail'] = email ?? "";
                                    },
                                    validate: (email) {
                                      if (email!.isEmpty ||
                                          email.length < 3 ||
                                          !email.contains("@")) {
                                        return 'enter correct email';
                                      }
                                    },
                                  ),
                                  CustomTextField(
                                    hintText: 'enter child email',
                                    textInputAction: TextInputAction.next,
                                    keyBoardtype: TextInputType.emailAddress,
                                    prefix: Icon(Icons.person),
                                    onsave: (cemail) {
                                      _formData['cemail'] = cemail ?? "";
                                    },
                                    validate: (email) {
                                      if (email!.isEmpty ||
                                          email.length < 3 ||
                                          !email.contains("@")) {
                                        return 'enter correct email';
                                      }
                                    },
                                  ),
                                  CustomTextField(
                                    hintText: 'enter password',
                                    isPassword: isPasswordShown,
                                    prefix: Icon(Icons.vpn_key_rounded),
                                    validate: (password) {
                                      if (password!.isEmpty ||
                                          password.length < 7) {
                                        return 'enter correct password';
                                      }
                                      return null;
                                    },
                                    onsave: (password) {
                                      _formData['password'] = password ?? "";
                                    },
                                    suffix: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            isPasswordShown = !isPasswordShown;
                                          });
                                        },
                                        icon: isPasswordShown
                                            ? Icon(Icons.visibility_off)
                                            : Icon(Icons.visibility)),
                                  ),
                                  CustomTextField(
                                    hintText: 'retype password',
                                    isPassword: isRetypePasswordShown,
                                    prefix: Icon(Icons.vpn_key_rounded),
                                    validate: (password) {
                                      if (password!.isEmpty ||
                                          password.length < 7) {
                                        return 'enter correct password';
                                      }
                                      return null;
                                    },
                                    onsave: (password) {
                                      _formData['rpassword'] = password ?? "";
                                    },
                                    suffix: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            isRetypePasswordShown =
                                                !isRetypePasswordShown;
                                          });
                                        },
                                        icon: isRetypePasswordShown
                                            ? Icon(Icons.visibility_off)
                                            : Icon(Icons.visibility)),
                                  ),
                                  PrimaryButton(
                                      title: 'REGISTER',
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          _onSubmit();
                                        }
                                      }),
                                ],
                              ),
                            ),
                          ),
                          SecondaryButton(
                              title: 'Login with your account',
                              onPressed: () {
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