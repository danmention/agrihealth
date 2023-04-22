import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import '../models/businessLayer/base.dart';
import '../utils/constant.dart';

class ForgotPasswordScreen extends Base {

  @override
  _ForgotPasswordScreenState createState() => new _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends BaseState {
  GlobalKey<ScaffoldState>? _scaffoldKey;

  TextEditingController _cEmail = new TextEditingController();
  FocusNode _fEmail = new FocusNode();


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {

        return promptExit();
      },
      child: sc(Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 10),
            child: Column(
              children: [
                Text(txt_forgot_password, style: Theme.of(context).primaryTextTheme.caption),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(txt_please_enter_your_email_so_we_can_help_you_to_recover_your_password, textAlign: TextAlign.center, style: Theme.of(context).primaryTextTheme.headline3),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 70),
                    child: TextFormField(
                      textAlign: TextAlign.start,
                      autofocus: false,
                      cursorColor: Color(0xFFFA692C),
                      enabled: true,
                      style: Theme.of(context).primaryTextTheme.headline6,
                      controller: _cEmail,
                      focusNode: _fEmail,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(hintText: lbl_email),
                      onEditingComplete: () {
                        FocusScope.of(context).unfocus();
                      },
                    )),
                Container(
                    height: 50,
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 20),
                    child: TextButton(
                        onPressed: () {
                          _forgotPassword();
                        },
                        child: Text(btn_send))),
              ],
            ),
          ),
        ),
      )),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  _forgotPassword() async {
    try {
      if (_cEmail.text.isNotEmpty) {
        bool isConnected = await br!.checkConnectivity();
        if (isConnected) {
          showOnlyLoaderDialog();
          await apiHelper!.forgotPassword(_cEmail.text.trim()).then((result) {
            if (result != null) {
              if (result.status == "1") {
                hideLoader();
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //       builder: (context) => OTPVerificationScreen(
                //         a: widget.analytics,
                //         o: widget.observer,
                //         screenId: 2,
                //         phoneNumberOrEmail: _cEmail.text.trim(),
                //       )),
                // );

                setState(() {});
              } else {
                hideLoader();
                showSnackBar(key: _scaffoldKey, snackBarMessage: '${result.message}');
              }
            }
          });
        } else {
          showNetworkErrorSnackBar(_scaffoldKey!);
        }
      } else if (_cEmail.text.isEmpty) {
        showSnackBar(key: _scaffoldKey, snackBarMessage: txt_please_enter_your_email);
      } else if (_cEmail.text.isNotEmpty && !EmailValidator.validate(_cEmail.text)) {
        showSnackBar(key: _scaffoldKey, snackBarMessage: txt_please_enter_your_valid_email);
      }
    } catch (e) {
      print("Exception - forgotPasswordScreen.dart - _forgotPassword():" + e.toString());
    }
  }
}