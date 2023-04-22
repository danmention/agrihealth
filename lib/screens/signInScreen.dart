import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'dart:math';

import 'package:agrihealth/models/businessLayer/global.dart' as global;
import 'package:agrihealth/screens/addPhoneScreen.dart';
import 'package:agrihealth/screens/signUpScreen.dart';
import 'package:agrihealth/widgets/buttonWidget.dart';
import 'package:crypto/crypto.dart';
import 'package:email_validator/email_validator.dart';

import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../models/businessLayer/base.dart';
import '../models/userModel.dart';
import '../utils/constant.dart';
import '../widgets/bottomNavigationWidget.dart';

class SignInScreen extends Base {

  @override
  _SignInScreenState createState() => new _SignInScreenState();
}

class _SignInScreenState extends BaseState {
  GlobalKey<ScaffoldState>? _scaffoldKey;
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController _cEmail = new TextEditingController();
  TextEditingController _cPassword = new TextEditingController();
  FocusNode _fEmail = new FocusNode();
  FocusNode _fPassword = new FocusNode();
  bool _isRemember = false;
  bool _isPasswordVisible = true;

  _SignInScreenState() : super();
  @override
  Widget build(BuildContext context) {


    return WillPopScope(
      onWillPop: () {
        return promptExit();
      },
      child:

      sc(Scaffold(
        key: _scaffoldKey,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Container(

            decoration: BoxDecoration(
              image: DecorationImage(
                colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.9), BlendMode.modulate,),
                image: AssetImage("assets/bg2.jpg", ),
                fit:BoxFit.cover
              )
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, ),
              child: SingleChildScrollView(
                child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[

                            SizedBox(height:95),
                            Image.asset(
                              'assets/agrihealthlogo.png',
                              width: 300,

                            ),
                            SizedBox(height: 80,),


                            TextFormField(
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return 'Can\'t be empty';
                                }
                                if (text.length < 4) {
                                  return 'Too short';
                                }
                                return null;
                              },
                              controller: _cEmail,
                              focusNode: _fEmail,
                              keyboardType: TextInputType.emailAddress,
                              onEditingComplete: () {
                                _fPassword.requestFocus();
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(5),
                                border: OutlineInputBorder(),
                                hintText: 'Email Address',
                                //hintText: 'Enter Your Name',
                              ),
                            ),

                          SizedBox(height: 30,),
                            TextFormField(
                              controller: _cPassword,
                              focusNode: _fPassword,
                              obscureText: _isPasswordVisible,
                              onEditingComplete: () {
                                FocusScope.of(context).unfocus();
                              },
                              decoration: InputDecoration(
                                hintText: 'Enter Password',
                                suffixIcon: IconButton(
                                  icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off,                               color: IconTheme.of(context).color),
                                  onPressed: () {
                                    _isPasswordVisible = !_isPasswordVisible;
                                    setState(() {});
                                  },
                                ),
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.all(5),
                                // hintText: hnt_password

                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),

                            // TextButton(onPressed: (){
                            //   _loginWithEmail();
                            // }, child: Text("Login"))

                            Button(btnText:" LOGIN" ,onClick:(){
                              _loginWithEmail();
                            } ,),

                          ],



          ),
              ),
            ),),
        ),
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(txt_you_dont_have_an_account, style: Theme.of(context).primaryTextTheme.subtitle1),
                GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SignUpScreen()),
                      );
                    },
                    child: Text(lbl_sign_up, style: Theme.of(context).primaryTextTheme.headline5))
              ],
            )),
        ),


      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
   // _init();
  }



  _loginWithEmail() async {


    try {
      CurrentUser _user = new CurrentUser();
      _user.email = _cEmail.text.trim();
      _user.password = _cPassword.text.trim();




      if (_cEmail.text.isNotEmpty && EmailValidator.validate(_cEmail.text)
          && _cPassword.text.isNotEmpty && _cPassword.text.trim().length >= 6) {
        bool isConnected = await br!.checkConnectivity();
        if (isConnected) {
          showOnlyLoaderDialog();
          await apiHelper!.loginWithEmail(_user).then((result) async {
            if (result != null) {
              if (result.status == "success") {
                global.user = result.recordList;

                if(global.user.isVerified == 0){
                  hideLoader();
                  showSnackBar(
                      key: _scaffoldKey, snackBarMessage: 'Verify your account with the otp was sent to your email,');
                  Navigator.pushNamed(context, "otp");
                }

                final prefs = await SharedPreferences.getInstance();
                final userJson = json.encode( global.user.toJson());
                await prefs.setString('currentUser', userJson);

            //  global.sp?.setString('currentUser', json.encode(global.user.toJson()));

                Navigator.pushNamed(context, "home");
              } else {
                hideLoader();
                //showSnackBar(key: _scaffoldKey, snackBarMessage: '${result.message}');
                showSnackBar(key: _scaffoldKey, snackBarMessage: '${result.error[0].message}');
              }
            }
          });
        } else {
          showNetworkErrorSnackBar(_scaffoldKey!);
        }
      }else{
        if (_cEmail.text.isEmpty) {
          showSnackBar(key: _scaffoldKey, snackBarMessage: txt_please_enter_your_email);
        }else
       if (_cEmail.text.isNotEmpty && !EmailValidator.validate(_cEmail.text)) {
          showSnackBar(key: _scaffoldKey, snackBarMessage: txt_please_enter_your_valid_email);
        } else if (_cPassword.text.isEmpty || _cPassword.text.trim().length < 8) {
          showSnackBar(key: _scaffoldKey, snackBarMessage: txt_password_should_be_of_minimum_8_character);
          return;
        }


      }
    } catch (e) {
      print("Exception - signInScreen.dart - _loginWithEmail():" + e.toString());
    }
  }




}
