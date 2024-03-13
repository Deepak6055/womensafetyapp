import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final  String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validate;
  final Function(String?)? onsave;
  final int? maxLine;
  final bool isPassword;
  final bool enable;
  final bool? check;
  final TextInputType? keyBoardtype;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final Widget? prefix;
  final Widget? suffix;
 
 CustomTextField(
  {this.controller,
  this.check,
  this.enable = true,
  this.focusNode,
  this.hintText,
  this.isPassword = false,
  this.keyBoardtype,
  this.maxLine,
  this.onsave,
  this.prefix,
  this.suffix,
  this.textInputAction,
  this.validate});
 

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enable ==true? true:enable,
      maxLines: maxLine==null?1:maxLine,
      onSaved: onsave,
      focusNode: focusNode,
      textInputAction: textInputAction,
      keyboardType: keyBoardtype==null?TextInputType.name:keyBoardtype,
      controller: controller,
      validator: validate,
      obscureText: isPassword==false?false:isPassword,
      decoration: InputDecoration(
        prefixIcon: prefix,
        suffixIcon: suffix,
        labelText: hintText?? "Hint text...",
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            style: BorderStyle.solid,
            color: Theme.of(context).primaryColor,
          ),
          ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            style: BorderStyle.solid,
            color: Color(0Xff909a9e),
          ),
          ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            style: BorderStyle.solid,
            color: Theme.of(context).primaryColor,
          ),
          ),
          errorBorder:  OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            style: BorderStyle.solid,
            color: Colors.red,
          ),
          ),

      ),
    );
  }
}