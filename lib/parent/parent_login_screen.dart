import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/custom_text.dart';
import 'package:flutter_application_1/components/primary_button.dart';
import 'package:flutter_application_1/components/secondary_button.dart';
import 'package:flutter_application_1/child/child_login_screen.dart';
import 'package:flutter_application_1/utils/constants.dart';

class RegisterParent extends StatefulWidget {
  @override
  State<RegisterParent> createState() => _RegisterParentScreenState();
}

class _RegisterParentScreenState extends State<RegisterParent> {
  bool isPasswordshown = true;

  final _formkey = GlobalKey<FormState>();

  final _formData = Map<String,Object>();

_onSubmit(){
  _formkey.currentState!.save();
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                 Container(
                      height: MediaQuery.of(context).size.height*0.3,
                      child: Column(
                        mainAxisAlignment:MainAxisAlignment.center ,
                        children: [
                          Text(
                            "Register Parent",
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
                          hintText: 'Enter Child Email',
                          textInputAction: TextInputAction.next,
                          keyBoardtype: TextInputType.emailAddress,
                          prefix: Icon(Icons.person),
                          onsave: (gemail) {
                              _formData['cemail'] = gemail ?? "";
                          },
                          validate: (cemail) {
                            if(cemail!.isEmpty || cemail.length<3||!cemail.contains("@"))
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
        ),
      ),
    );
  }
}