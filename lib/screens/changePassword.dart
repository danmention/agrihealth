import 'package:agrihealth/screens/homeScreen.dart';
import 'package:agrihealth/screens/signInScreen.dart';
import 'package:flutter/material.dart';

import '../models/businessLayer/base.dart';

class ChangePasswordScreen extends Base {
  final String? email;
  ChangePasswordScreen( {this.email, o}) ;
  @override
  _ChangePasswordScreenState createState() => new _ChangePasswordScreenState(this.email!);
}

class _ChangePasswordScreenState extends BaseState {
  GlobalKey<ScaffoldState>? _scaffoldKey;
  TextEditingController _cOldPassword = new TextEditingController();
  TextEditingController _cNewPassword = new TextEditingController();
  FocusNode _fNewPassword = new FocusNode();
  FocusNode _fConfirmPassword = new FocusNode();
  String email;
  _ChangePasswordScreenState(this.email) : super();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        Navigator.of(context).pop();
        return false;
      },
      child: sc(Scaffold(
        appBar: AppBar(title:  Text(
          'Change Password',
          //style: Theme.of(context).primaryTextTheme.caption,
        ),),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 0, bottom: 0, left: 15, right: 15),
            child: Column(
              children: [

                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text('Please enter your new password  ', textAlign: TextAlign.center, style: Theme.of(context).primaryTextTheme.headline3),
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
                      controller: _cOldPassword,
                      focusNode: _fNewPassword,
                      decoration: InputDecoration(hintText: 'Old Password'),
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
                      controller: _cNewPassword,
                      focusNode: _fConfirmPassword,
                      decoration: InputDecoration(hintText: 'New Password'),
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
                        child: Text('Change Password'))),
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
      if (_cNewPassword.text.isEmpty
          && _cOldPassword.text.isEmpty ) {
        showSnackBar(key: _scaffoldKey,
            snackBarMessage: 'Password field should not be empty');
        return;
      }

        bool isConnected = await br!.checkConnectivity();
        if (isConnected) {
          showOnlyLoaderDialog();
          await apiHelper!.changePassword(_cOldPassword.text.trim(), _cNewPassword.text.trim()).then((result) {
            if (result != null) {
              if (result.status == "success") {
                hideLoader();


                showSnackBar(key: _scaffoldKey, snackBarMessage: 'Password chnaged successfully');
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => HomeScreen(
                      )),
                );
                setState(() {});
              } else {
                hideLoader();
                showSnackBar(key: _scaffoldKey, snackBarMessage: '${result.error[0].message}');
              }
            }
          });
        } else {
          showNetworkErrorSnackBar(_scaffoldKey!);
        }

    } catch (e) {
      print("Exception - resetPasswordScreen.dart - _changePassword():" + e.toString());
    }
  }
}
