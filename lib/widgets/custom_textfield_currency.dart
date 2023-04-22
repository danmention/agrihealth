import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'currecencyformatter.dart';




class CustomTextFieldAmount extends StatelessWidget {
  const CustomTextFieldAmount({Key? key,this.onchange, this.hintText, this.controller,
    this.validator, this.enabled,
    this.keyBoardType, this.maxLength,this.isPassword, this.obscureText, this.labelText, this.sufficeIcon, this.isEmail, this.onsaved}) ;
  final String? hintText;
  final TextEditingController? controller;
  final String? labelText;

  final TextInputType? keyBoardType;
  final bool? obscureText;
  final bool? enabled;
  final int? maxLength;
  final IconData? sufficeIcon;
  final bool? isPassword;
  final bool? isEmail;

  final Function(String)? onchange;
  final Function(String?)? onsaved;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return
      Padding(
          padding: EdgeInsets.only(top: 10),
          child: TextFormField(
            textAlign: TextAlign.start,
            autofocus: false,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              ThousandsSeparatorInputFormatter()
            ],

            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: controller,
            onChanged: onchange,
            onSaved: onsaved,

            validator: (text) {
              if (text!.isEmpty) {
                return "This field is required";
              }
              return null;
            },
            keyboardType: keyBoardType == null ? TextInputType.text : keyBoardType,
            obscureText: isPassword == null?false:true,
            cursorColor: Color(0xFFFA692C),
            enabled: true,
            style: Theme.of(context).primaryTextTheme.headline6,

            decoration: InputDecoration(),
            onEditingComplete: () {
              FocusScope.of(context).unfocus();
            },
          ));

    // TextFormField(
    //     autovalidateMode: AutovalidateMode.onUserInteraction,
    //     controller: controller,
    //     onChanged: onchange,
    //     onSaved: onsaved,
    //
    //     validator: (text) {
    //       if (text!.isEmpty) {
    //         return "This field is required";
    //       }
    //       return null;
    //     },
    //     keyboardType: keyBoardType == null ? TextInputType.text : keyBoardType,
    //     obscureText: isPassword == null?false:true,
    //
    // );
  }





}