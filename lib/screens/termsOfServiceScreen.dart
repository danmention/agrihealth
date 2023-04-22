import 'package:agrihealth/models/businessLayer/base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../models/termsAndConditionModel.dart';
import '../utils/constant.dart';

class TermsOfServices extends Base {
  TermsOfServices({a, o}) ;
  @override
  _TermsOfServicesState createState() => new _TermsOfServicesState();
}

class _TermsOfServicesState extends BaseState {
  GlobalKey<ScaffoldState>? _scaffoldKey;
  TermsAndCondition ?_termsAndCondition;
  bool _isDataLoaded = false;
  _TermsOfServicesState() : super();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        Navigator.of(context).pop();
        return false;
      },
      child: sc(Scaffold(
        appBar: AppBar(
          title: Text(lbl_terms_of_service),
        ),
        body: _isDataLoaded
            ? SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Html(
                    data: _termsAndCondition!.termcondition,
                    style: {
                      'body': Style(textAlign: TextAlign.justify),
                    },
                  )),
            ),
          ),
        )
            : Center(child: CircularProgressIndicator()),
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
    _init();
  }

  _getTermsAndCondition() async {
    try {
      bool isConnected = await br!.checkConnectivity();
      if (isConnected) {
        await apiHelper?.getTermsAndCondition().then((result) {
          if (result != null) {
            if (result.status == "1") {
              _termsAndCondition = result.data;
              _isDataLoaded = true;
              setState(() {});
            }
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey!);
      }
    } catch (e) {
      print("Exception - termsOfServicesScreen.dart - _getTermsAndCondition():" + e.toString());
    }
  }

  _init() async {
    try {
      await _getTermsAndCondition();
    } catch (e) {
      print("Exception - termsOfServicesScreen.dart - _init():" + e.toString());
    }
  }
}
