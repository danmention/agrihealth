import 'package:agrihealth/screens/otpScreen.dart';
import 'package:agrihealth/screens/signInScreen.dart';
import 'package:agrihealth/utils/constant.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:agrihealth/models/businessLayer/global.dart' as global;
import 'package:google_fonts/google_fonts.dart';

import '../models/businessLayer/base.dart';
import '../models/userModel.dart';
import '../widgets/buttonWidget.dart';






class SignUpScreen extends Base {


  final String? appleId;
  final String? email;
  final String? fbId;
  final String? name;
  SignUpScreen({a, o, this.email, this.fbId, this.name, this.appleId}) ;

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends BaseState {

  GlobalKey<ScaffoldState>? _scaffoldKey;
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String? _dropDownValue;

  TextEditingController _cFName = new TextEditingController();
  TextEditingController _cLName = new TextEditingController();
  TextEditingController _cEmail = new TextEditingController();
  TextEditingController _cMobile = new TextEditingController();
  TextEditingController _cPassword = new TextEditingController();


  FocusNode _fReferralCode = new FocusNode();
  FocusNode _fFirstName = new FocusNode();
  FocusNode _fEmail = new FocusNode();
  FocusNode _fMobile = new FocusNode();
  FocusNode _fPassword = new FocusNode();
  FocusNode _fLastName = new FocusNode();



  bool _isRemember = false;
  bool _isPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        body: SingleChildScrollView(
    child: Form(
      key: _formkey,
      child: Container(
        padding: const EdgeInsets.only(top: 0, bottom: 0, left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 70,
            ),

            Image.asset(
              'assets/agrihealthlogo.png',
              width: 200,


            ),
            SizedBox(
              height: 20,
            ),


            Text(
              "Register",
              style:  GoogleFonts.roboto(
                textStyle: TextStyle(color: Colors.black45,fontSize: 24, letterSpacing: .5),
              ),


            ),

            SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Enter Firstname'),
                Container(
                    margin: EdgeInsets.only(top: 15),
                    height: 50,
                    child: TextFormField(
                      textAlign: TextAlign.start,
                      //autofocus: false,
                      cursorColor: Color(0xFFFA692C),
                      enabled: true,
                      //readOnly: email != null ? true : false,
                      keyboardType: TextInputType.emailAddress,
                      style: Theme.of(context).primaryTextTheme.headline6,
                      controller: _cFName,
                     // focusNode: _fFirstName,
                      //// decoration: InputDecoration(hintText: email != null ? email : AppLocalizations.of(context).lbl_email),
                      // onEditingComplete: () {
                      //   _fLastName.requestFocus();
                      // },
                    )),
                SizedBox(
                  height: 10,
                ),

                Text('Enter Lastname'),
                Container(
                    margin: EdgeInsets.only(top: 15),
                    height: 50,
                    child: TextFormField(
                      textAlign: TextAlign.start,
                      //autofocus: false,
                      cursorColor: Color(0xFFFA692C),
                      enabled: true,
                      //readOnly: email != null ? true : false,

                      style: Theme.of(context).primaryTextTheme.headline6,
                      controller: _cLName,

                      //// decoration: InputDecoration(hintText: email != null ? email : AppLocalizations.of(context).lbl_email),

                    )),



                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.only(top: 15),
                  height: 50,
                  child: TextFormField(
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
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(5),
                      border: OutlineInputBorder(),
                      labelText: 'Email Address',
                      hintText: 'Enter Your Name',
                    ),
                  ),
                ),



                SizedBox(
                  height: 10,
                ),

                Text('Enter Phone Number'),
                Container(
                    margin: EdgeInsets.only(top: 15),
                    height: 50,
                    child: TextFormField(
                      textAlign: TextAlign.start,
                      //autofocus: false,
                      cursorColor: Color(0xFFFA692C),
                      enabled: true,
                      //readOnly: email != null ? true : false,

                      style: Theme.of(context).primaryTextTheme.headline6,
                      controller: _cMobile,

                    )),

                Text('Enter Password'),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: TextFormField(
                    controller: _cPassword,

                    obscureText: _isPasswordVisible,

                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off, color: IconTheme.of(context).color),
                          onPressed: () {
                            _isPasswordVisible = !_isPasswordVisible;
                            setState(() {});
                          },
                        ),
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(5),
                        hintText: hnt_password),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(' User Type'),
                SizedBox(
                  height: 5,
                ),
                DropdownButtonFormField(
                  isDense: true,
                  hint: _dropDownValue == null
                      ? Text('Select user type')
                      : Text(
                    _dropDownValue!,
                    style: TextStyle(color: Colors.blue),
                  ),

                  iconSize: 30.0,
                  style: TextStyle(color: Colors.blue),
                  items: ['student', 'sponsor'].map(
                        (val) {
                      return DropdownMenuItem<String>(
                        value: val,
                        child: Text(val),
                      );
                    },
                  ).toList(),
                  onChanged: (val) {
                    setState(
                          () {
                        _dropDownValue = val;
                      },
                    );
                  },
                ),

                SizedBox(
                  height: 40,
                ),
            ],),


            // Button(btnText:" LOGIN" ,onClick:_loginWithEmail() ,),
            Button(btnText:" REGISTER" ,onClick:() {
              FocusScope.of(context).unfocus();
              _signUp();
            // Navigator.pushNamed(context, "otp");
            }

             ,),



          ],
        ),
      ),
    ),
        ),
        bottomNavigationBar: Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(" Already have an account?  ", style: Theme.of(context).primaryTextTheme.subtitle1),
          GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SignInScreen()),
                );
              },
              child: Text(lbl_sign_in, style: Theme.of(context).primaryTextTheme.headline5))
        ],
      )),
      );
  }



  _signUp() async {
    try {

      CurrentUser _user = new CurrentUser();


      _user.firstname = _cFName.text.trim();
      _user.email = _cEmail.text.trim();
      _user.phone = _cMobile.text.trim();
      _user.password = _cPassword.text.trim();
      _user.lastname = _cLName.text.trim();
      _user.userType = _dropDownValue;

      if (_cFName.text.isEmpty) {
        showSnackBar(key: _scaffoldKey, snackBarMessage: "Enter firstname");
      } else if (_cEmail.text.isEmpty) {
        showSnackBar(key: _scaffoldKey, snackBarMessage: txt_please_enter_your_email);
      } else if (_cEmail.text.isNotEmpty && !EmailValidator.validate(_cEmail.text)) {
        showSnackBar(key: _scaffoldKey, snackBarMessage: txt_please_enter_your_valid_email);
      } else if (_cMobile.text.isEmpty || (_cMobile.text.isNotEmpty && _cMobile.text.trim().length < 10)) {
        showSnackBar(key: _scaffoldKey, snackBarMessage: txt_please_enter_valid_mobile_number);
      } else if (_cPassword.text.isEmpty) {
        showSnackBar(key: _scaffoldKey, snackBarMessage: txt_please_enter_your_password);
      } else if (_cPassword.text.isNotEmpty && _cPassword.text.trim().length < 6) {
        showSnackBar(key: _scaffoldKey, snackBarMessage: txt_password_should_be_of_minimum_8_character);
        return;
      }


        bool isConnected = await br!.checkConnectivity();
        if (isConnected) {
          showOnlyLoaderDialog();
          await apiHelper!.signUp(_user).then((result) async {
            if (result != null) {
              if (result.status == "success") {
                hideLoader();

               // Navigator.pushNamed(context, "otp");


                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  OtpScreen(email:_cEmail.text)),
                );
               // await _sendOTP(_cMobile.text.trim());
                //

              } else {
                hideLoader();
               // if(result.error[0][1].message != null){
                  showSnackBar(key: _scaffoldKey, snackBarMessage: result.error[0]['message'].toString());
                // }else{
                //   showSnackBar(key: _scaffoldKey, snackBarMessage: result.message.toString());
                // }

              }
            }
          });
        } else {

          showNetworkErrorSnackBar(_scaffoldKey!);
        }

    } catch (e) {
      print("Exception - signUpScreen.dart - _signUp():" + e.toString());
    }
  }
}


