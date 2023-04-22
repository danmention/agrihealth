import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../models/businessLayer/base.dart';
import '../models/businessLayer/businessRule.dart';

class OtpScreen extends Base {
String? email ;
  OtpScreen({this.email});

  @override
  _OtpScreenState createState() => _OtpScreenState(email!);
}

class _OtpScreenState extends BaseState {
  String emailAdress;
  _OtpScreenState(this.emailAdress);

  GlobalKey<ScaffoldState>? _scaffoldKey;
  String? phoneNumberOrEmail;
  String? verificationId;
  int _seconds = 60;
  Timer? _countDown;
  var _cCode = new TextEditingController();
  String? status;
  int? screenId;
  BusinessRule? br;


  @override
  void initState() {
    //startTimer();
    startTimer1();
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
       return promptExit();
      },
      child: sc(Scaffold(
        key: _scaffoldKey,

        body:
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 90, bottom: 0, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Verifying Email',
                  style: Theme.of(context).primaryTextTheme.caption,

                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 40),
                  child: Text(
                    'Enter the verification code from the email we just sent you.',

                    style: Theme.of(context).primaryTextTheme.headline3,
                  ),
                ),
                TextFormField(



                  controller: _cCode,

                  keyboardType: TextInputType.number,

                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                        onTap: () async {

                          resendOTP(emailAdress);
                         // await _getOTP(phoneNumberOrEmail!);
                        },
                        child: Text(_start != 0 ? 'Resend code 0:$_start' : 'Resend OTP', style: Theme.of(context).primaryTextTheme.headline5))),
                Container(
                    height: 50,
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 10),
                    child: TextButton(
                        onPressed: () async {
                          _checkSecurityPin();
                        },
                        child: Text('Verify'))),
                Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - 30,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('By tapping verification code above, you agree ', style: Theme.of(context).primaryTextTheme.subtitle1),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('to the ', style: Theme.of(context).primaryTextTheme.subtitle1),
                              InkWell(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                                  onTap: () {
                                    // Navigator.of(context).push(
                                    //   MaterialPageRoute(builder: (context) => TermsOfServices(a: widget.analytics, o: widget.observer)),
                                    // );
                                  },
                                  child: Text('Terms of Services,', style: Theme.of(context).primaryTextTheme.subtitle2)),
                              InkWell(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                                  onTap: () {
                                    // Navigator.of(context).push(
                                    //   MaterialPageRoute(builder: (context) => PrivacyAndPolicy(a: widget.analytics, o: widget.observer)),
                                    // );
                                  },
                                  child: Text('  privacy policy', style: Theme.of(context).primaryTextTheme.subtitle2)),
                              Text(' and', style: Theme.of(context).primaryTextTheme.subtitle1),
                            ],
                          ),
                          InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              overlayColor: MaterialStateProperty.all(Colors.transparent),
                              onTap: () {
                                // Navigator.of(context).push(
                                //   MaterialPageRoute(builder: (context) => CookiesPolicy(a: widget.analytics, o: widget.observer)),
                                // );
                              },
                              child: Text(' cookies policy.', style: Theme.of(context).primaryTextTheme.subtitle2))
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ),
      )),
    );
  }
  Timer? _timer;
  int _start = 10;

  void startTimer1() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  Future startTimer() async {
    try {
      setState(() {});
      const oneSec = const Duration(seconds: 1);
      _countDown = new Timer.periodic(
        oneSec,
            (timer) {
          if (_seconds == 0) {
            setState(() {
              _countDown!.cancel();
              timer.cancel();
            });
          } else {
            setState(() {
              _seconds--;
            });
          }
        },
      );

      setState(() {});
    } catch (e) {
      print("Exception - otpVerificationScreen.dart - startTimer():" + e.toString());
    }
  }





  _checkSecurityPin() async {
    try {
      if (_cCode.text.length == 6) {
        await _verifyOtp(_cCode.text.trim());
      } else {
        showSnackBar(
            key: _scaffoldKey, snackBarMessage: 'Please enter 6 digit otp');
      }
    } catch (e) {
      print("Exception - otpVerificationScreen.dart - _checkSecurityPin() : " +
          e.toString());
    }
  }





  _verifyOtp(String _code) async {
    try {
      bool isConnected = await br!.checkConnectivity();
      if (isConnected) {

          showOnlyLoaderDialog();
          await apiHelper!.verifyOtpAfterRegistration(_code).then((result) async {
            if (result != null) {
              if (result.status == "success") {
                showSnackBar(key: _scaffoldKey, snackBarMessage: 'Account created successfully , pls login ');
                  nextScreen(context, 'login');




              } else {
                hideLoader();
                showSnackBar(key: _scaffoldKey, snackBarMessage: '${result.error[0].message}');
              }
            } else {
              hideLoader();
            }
          }).catchError((e) {});

      } else {
        showNetworkErrorSnackBar(_scaffoldKey!);
      }
    } catch (e) {
      print("Exception - otpVerificationScreen.dart - _verifyOtp():" + e.toString());
    }
  }

  void resendOTP(String email) async {
    try {
      bool isConnected = await br!.checkConnectivity();
      if (isConnected) {
        showOnlyLoaderDialog();
        await apiHelper!.resendOtp( email).then((result) async {
          if (result != null) {
            if (result.status == "success") {
              hideLoader();

              showSnackBar(key: _scaffoldKey,
                  snackBarMessage: 'OTP resent successfully ');

            } else {
              hideLoader();
              showSnackBar(key: _scaffoldKey,
                  snackBarMessage: '${result.error[0].message}');
            }
          } else {
            hideLoader();
          }
        }).catchError((e) {});
      } else {
        showNetworkErrorSnackBar(_scaffoldKey!);
      }
    } catch (e) {
      print("Exception - otpVerificationScreen.dart - _verifyOtp():" +
          e.toString());
    }
  }

}


