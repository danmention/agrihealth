import 'package:agrihealth/screens/signInScreen.dart';
import 'package:flutter/material.dart';

import '../models/businessLayer/base.dart';

class ResetPasswordScreen extends Base {
  final String? email;
  ResetPasswordScreen( {this.email, o}) ;
  @override
  _ResetPasswordScreenState createState() => new _ResetPasswordScreenState(this.email!);
}

class _ResetPasswordScreenState extends BaseState {
  GlobalKey<ScaffoldState>? _scaffoldKey;
  TextEditingController _cNewPassword = new TextEditingController();
  TextEditingController _cConfirmPassword = new TextEditingController();
  FocusNode _fNewPassword = new FocusNode();
  FocusNode _fConfirmPassword = new FocusNode();
  String email;
  _ResetPasswordScreenState(this.email) : super();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        Navigator.of(context).pop();
        return false;
      },
      child: sc(Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 10),
            child: Column(
              children: [
                Text(
                  'Reset Password',
                  style: Theme.of(context).primaryTextTheme.caption,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text('Please enter your Email so we can help you to recover your password.', textAlign: TextAlign.center, style: Theme.of(context).primaryTextTheme.headline3),
                ),
                Container(
                    margin: EdgeInsets.only(top: 70),
                    height: 50,
                    child: TextFormField(
                      textAlign: TextAlign.start,
                      autofocus: false,
                      cursorColor: Color(0xFFFA692C),
                      enabled: true,
                      style: Theme.of(context).primaryTextTheme.headline6,
                      controller: _cNewPassword,
                      focusNode: _fNewPassword,
                      decoration: InputDecoration(hintText: 'New Password'),
                      onEditingComplete: () {
                        _fConfirmPassword.requestFocus();
                      },
                    )),
                Container(
                    margin: EdgeInsets.only(top: 15),
                    height: 50,
                    child: TextFormField(
                      textAlign: TextAlign.start,
                      autofocus: false,
                      cursorColor: Color(0xFFFA692C),
                      enabled: true,
                      style: Theme.of(context).primaryTextTheme.headline6,
                      controller: _cConfirmPassword,
                      focusNode: _fConfirmPassword,
                      decoration: InputDecoration(hintText: 'Confirm Password'),
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
                          _changePassword();
                        },
                        child: Text('Reset Password'))),
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

  _changePassword() async {
    try {
      if (_cNewPassword.text.isNotEmpty && _cNewPassword.text.trim().length >= 8 && _cConfirmPassword.text.isNotEmpty && _cNewPassword.text.trim() == _cConfirmPassword.text.trim()) {
        bool isConnected = await br!.checkConnectivity();
        if (isConnected) {
          showOnlyLoaderDialog();
          await apiHelper!.changePassword(email, _cNewPassword.text.trim()).then((result) {
            if (result != null) {
              if (result.status == "1") {
                hideLoader();
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => SignInScreen(
                      )),
                );
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
      } else if (_cNewPassword.text.isEmpty || _cNewPassword.text.trim().length < 8) {
        showSnackBar(key: _scaffoldKey, snackBarMessage: 'Password should be of minimun 8 characters');
      } else if (_cConfirmPassword.text.isEmpty || _cConfirmPassword.text.trim() != _cNewPassword.text.trim()) {
        showSnackBar(key: _scaffoldKey, snackBarMessage: 'Passwords do not match');
      }
    } catch (e) {
      print("Exception - resetPasswordScreen.dart - _changePassword():" + e.toString());
    }
  }
}
