import 'dart:convert';
import 'dart:io';

import 'package:agrihealth/screens/changePassword.dart';
import 'package:agrihealth/screens/resetPassword.dart';
import 'package:agrihealth/screens/signInScreen.dart';
import 'package:agrihealth/screens/termsOfServiceScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import '../models/businessLayer/base.dart';
import '../models/userModel.dart';
import 'package:agrihealth/models/businessLayer/global.dart' as global;

import '../utils/constant.dart';

class ProfileScreen extends Base {
ProfileScreen({a, o});
@override
_ProfileScreenState createState() => new _ProfileScreenState();
}

class _ProfileScreenState extends BaseState {
  GlobalKey<ScaffoldState>? _scaffoldKey;
  CurrentUser? _user;

  //bool _isDataLoaded = true;
  File? _tImage;
  List<CurrentUser> ? _userList;
  bool _isDataLoaded = false;
  _ProfileScreenState() : super();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async {
        return true;
      },
      child: sc(Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Center(child: Text('Profile', )),
         // automaticallyImplyLeading: false,
        ),
         body:

         _isDataLoaded
             ?

         ScrollConfiguration(
           behavior: ScrollBehavior(),
           child: SingleChildScrollView(
             child: Padding(
               padding: const EdgeInsets.symmetric(vertical: 16.0),
               child: Column(
                 mainAxisSize: MainAxisSize.min,
                 mainAxisAlignment: MainAxisAlignment.center,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                   _tImage != null?

                   Container(

                     height: MediaQuery.of(context).size.height * 0.20,
                     width: MediaQuery.of(context).size.height * 0.20,
                     alignment: Alignment.center,
                     decoration: BoxDecoration(
                       color: Theme.of(context).cardTheme.color,
                       borderRadius: new BorderRadius.all(
                         new Radius.circular(MediaQuery.of(context).size.height * 0.17),
                       ),
                       image: DecorationImage(
                           image: FileImage(_tImage!),
                           fit: BoxFit.cover
                       ),
                       border: new Border.all(
                         color: Theme.of(context).primaryColor,
                         width: 3.0,
                       ),
                     ),
                   )
                       :




                   Center(
                     child: global.user.photoPath != ''
                         ?

                     CachedNetworkImage(
                       // imageUrl: '${global.baseUrlForImage}${global.user.profileImage}',

                       imageUrl: '${global.user.photoPath}',
                       imageBuilder: (context, imageProvider) => Container(
                         height: MediaQuery.of(context).size.height * 0.17,
                         width: MediaQuery.of(context).size.height * 0.17,
                         alignment: Alignment.center,
                         decoration: BoxDecoration(
                           color: Theme.of(context).cardTheme.color,
                           borderRadius: new BorderRadius.all(
                             new Radius.circular(MediaQuery.of(context).size.height * 0.17),
                           ),
                           image: DecorationImage(image: imageProvider),
                           border: new Border.all(
                             color: Theme.of(context).primaryColor,
                             width: 3.0,
                           ),
                         ),
                       ),
                       placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                       errorWidget: (context, url, error) => Icon(Icons.error),
                     )
                         :

                     Container(
                       height: MediaQuery.of(context).size.height * 0.20,
                       width: MediaQuery.of(context).size.height * 0.3,
                       alignment: Alignment.center,
                       decoration: BoxDecoration(
                         color: Theme.of(context).cardTheme.color,
                         borderRadius: new BorderRadius.all(
                           new Radius.circular(MediaQuery.of(context).size.height * 0.17),
                         ),
                         border: new Border.all(
                           color: Theme.of(context).primaryColor,
                           width: 3.0,
                         ),
                       ),
                       child: Icon(
                         Icons.person,
                         size: 50,
                       ),
                     ),
                   ),


                   TextButton(
                       child: Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Text('Change Image'),
                       ),
                       onPressed: () {
                         _showCupertinoModalSheet();
                       }
                   ),
                   Center(
                       child: Padding(
                         padding: const EdgeInsets.only(top: 8.0),
                         child: Text(
                           '${global.user.lastname}',
                           style: Theme.of(context).appBarTheme.titleTextStyle,
                         ),
                       )),
                   Card(
                     margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                     child: ListTile(
                       onTap: () {
                         // Navigator.of(context).push(
                         //   MaterialPageRoute(builder: (context) => AccountSettingScreen()),
                         // );
                       },
                       shape: Theme.of(context).cardTheme.shape,
                       leading: Icon(Icons.person),
                       title: Text("Account Name", style: Theme.of(context).primaryTextTheme.subtitle2),
                       subtitle: Text("${global.user.lastname}"
                         ,
                         style: Theme.of(context).primaryTextTheme.subtitle1,
                       ),
                     ),
                   ),


                   Card(
                     margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                     child: ListTile(
                       onTap: () {
                         Navigator.of(context).push(
                           MaterialPageRoute(
                               builder: (context) => TermsOfServices(

                               )),
                         );
                       },
                       shape: Theme.of(context).cardTheme.shape,
                       leading: Icon(Icons.close),
                       title: Text("Area", style: Theme.of(context).primaryTextTheme.subtitle2),
                       subtitle: Text(
                         "${global.user.lastname}",
                         style: Theme.of(context).primaryTextTheme.subtitle1,
                       ),
                     ),
                   ),
                   // Card(
                   //   margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                   //   child: ListTile(
                   //     onTap: () {
                   //       Navigator.of(context).push(
                   //         MaterialPageRoute(
                   //             builder: (context) => ChooseLanguageScreen(
                   //               a: widget.analytics,
                   //               o: widget.observer,
                   //             )),
                   //       );
                   //     },
                   //     shape: Theme.of(context).cardTheme.shape,
                   //     leading: Icon(FontAwesomeIcons.language),
                   //     title: Text(AppLocalizations.of(context).lbl_select_language, style: Theme.of(context).primaryTextTheme.subtitle2),
                   //     subtitle: Text(
                   //       AppLocalizations.of(context).txt_set_your_preffered_language,
                   //       style: Theme.of(context).primaryTextTheme.subtitle1,
                   //     ),
                   //   ),
                   // ),
                   SizedBox(
                     height: 20,
                   ),
                   ElevatedButton.icon(
                     style: ButtonStyle(
                       backgroundColor: MaterialStateProperty.all(Theme.of(context).canvasColor),
                     ),
                     onPressed: () {
                       _signOutDialog();
                     },
                     icon: Icon(Icons.logout_rounded),
                     label: Text(btn_sign_out),
                   ),
                   SizedBox(
                     height: 40,
                   )
                 ],
               ),
             ),
           ),
         )
             : _shimmer(),

        //  _isDataLoaded
        //     ?
        //
        // ScrollConfiguration(
        //   behavior: ScrollBehavior(),
        //   child: SingleChildScrollView(
        //     child: Column(
        //       mainAxisSize: MainAxisSize.min,
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       children: [
        //         Center(
        //           child:
        //           // global.user.image != ''
        //           //     ?
        //           //
        //           // CachedNetworkImage(
        //           //   imageUrl: '${global.baseUrlForImage}${global.user.image}',
        //           //   imageBuilder: (context, imageProvider) => Container(
        //           //     height: MediaQuery.of(context).size.height * 0.17,
        //           //     width: MediaQuery.of(context).size.height * 0.17,
        //           //     alignment: Alignment.center,
        //           //     decoration: BoxDecoration(
        //           //       color: Theme.of(context).cardTheme.color,
        //           //       borderRadius: new BorderRadius.all(
        //           //         new Radius.circular(MediaQuery.of(context).size.height * 0.17),
        //           //       ),
        //           //       image: DecorationImage(image: imageProvider),
        //           //       border: new Border.all(
        //           //         color: Theme.of(context).primaryColor,
        //           //         width: 3.0,
        //           //       ),
        //           //     ),
        //           //   ),
        //           //   placeholder: (context, url) => Center(child: CircularProgressIndicator()),
        //           //   errorWidget: (context, url, error) => Icon(Icons.error),
        //           // )
        //           //     :
        //
        //           Container(
        //             margin: EdgeInsets.only(top: 20),
        //             height: MediaQuery.of(context).size.height * 0.17,
        //             width: MediaQuery.of(context).size.height * 0.17,
        //             alignment: Alignment.center,
        //             decoration: BoxDecoration(
        //               color: Theme.of(context).cardTheme.color,
        //               borderRadius: new BorderRadius.all(
        //                 new Radius.circular(MediaQuery.of(context).size.height * 0.17),
        //               ),
        //               border: new Border.all(
        //                 color: Theme.of(context).primaryColor,
        //                 width: 3.0,
        //               ),
        //             ),
        //             child: Icon(
        //               Icons.person,
        //               size: 50,
        //             ),
        //           ),
        //         ),
        //         Padding(
        //           padding: const EdgeInsets.only(top: 8.0),
        //           child: Row(
        //
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             children: [
        //               Text(
        //                 '${global.user.lastname}',
        //                 style: Theme.of(context).primaryTextTheme.caption,
        //               ),
        //                SizedBox(width: 10,),
        //               Text(
        //                 '${global.user.firstname}',
        //                 style: Theme.of(context).primaryTextTheme.caption,
        //               ),
        //             ],
        //           ),
        //         ),
        //         Card(
        //           margin: EdgeInsets.only(top: 10, left: 10, right: 10),
        //           child: ListTile(
        //             onTap: () {
        //               // Navigator.of(context).push(
        //               //   MaterialPageRoute(builder: (context) => AccountSettingScreen(a: widget.analytics, o: widget.observer)),
        //               // );
        //             },
        //             shape: Theme.of(context).cardTheme.shape,
        //             leading: Icon(Icons.person),
        //             title: Text(lbl_account_settings, style: Theme.of(context).primaryTextTheme.subtitle2),
        //             subtitle: Text(
        //              txt_name_email_address_contact_number,
        //               style: Theme.of(context).primaryTextTheme.subtitle1,
        //             ),
        //           ),
        //         ),
        //         Card(
        //           margin: EdgeInsets.only(top: 10, left: 10, right: 10),
        //           child: ListTile(
        //             onTap: () {
        //               Navigator.of(context).push(
        //                 MaterialPageRoute(builder: (context) => ChangePasswordScreen(email:global.user.email ,)),
        //               );
        //             },
        //             shape: Theme.of(context).cardTheme.shape,
        //             leading: Icon(FontAwesomeIcons.history),
        //             title: Text('Change Password ', style: Theme.of(context).primaryTextTheme.subtitle2),
        //             subtitle: Text(
        //               'Click to change your password',
        //               style: Theme.of(context).primaryTextTheme.subtitle1,
        //             ),
        //           ),
        //         ),
        //
        //         Card(
        //           margin: EdgeInsets.only(top: 10, left: 10, right: 10),
        //           child: ListTile(
        //             onTap: () {
        //               Navigator.of(context).push(
        //                 MaterialPageRoute(
        //                     builder: (context) => TermsOfServices(
        //
        //                     )),
        //               );
        //             },
        //             shape: Theme.of(context).cardTheme.shape,
        //             leading: Icon(Icons.close),
        //             title: Text(lbl_terms_of_service, style: Theme.of(context).primaryTextTheme.subtitle2),
        //             subtitle: Text(
        //               txt_save_your_terms_of_service,
        //               style: Theme.of(context).primaryTextTheme.subtitle1,
        //             ),
        //           ),
        //         ),
        //         // Card(
        //         //   margin: EdgeInsets.only(top: 10, left: 10, right: 10),
        //         //   child: ListTile(
        //         //     onTap: () {
        //         //       Navigator.of(context).push(
        //         //         MaterialPageRoute(
        //         //             builder: (context) => ChooseLanguageScreen(
        //         //               a: widget.analytics,
        //         //               o: widget.observer,
        //         //             )),
        //         //       );
        //         //     },
        //         //     shape: Theme.of(context).cardTheme.shape,
        //         //     leading: Icon(FontAwesomeIcons.language),
        //         //     title: Text(AppLocalizations.of(context).lbl_select_language, style: Theme.of(context).primaryTextTheme.subtitle2),
        //         //     subtitle: Text(
        //         //       AppLocalizations.of(context).txt_set_your_preffered_language,
        //         //       style: Theme.of(context).primaryTextTheme.subtitle1,
        //         //     ),
        //         //   ),
        //         // ),
        //         SizedBox(
        //           height: 20,
        //         ),
        //         Padding(
        //           padding: const EdgeInsets.all(8.0),
        //           child: ElevatedButton.icon(
        //             style: ButtonStyle(
        //               backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColorLight),
        //             ),
        //             onPressed: () {
        //               _signOutDialog();
        //             },
        //             icon: Icon(Icons.logout_rounded),
        //             label: Text(btn_sign_out, style: TextStyle(color: Colors.white),),
        //           ),
        //         ),
        //         SizedBox(
        //           height: 40,
        //         )
        //       ],
        //     ),
        //   ),
        // )
        //     : _shimmer(),
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
    if (global.user.id == null) {
      Future.delayed(Duration.zero, () {
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => SignInScreen(

              )),
        );
      });
    }
    _init();
  }
  //
  // _getUserProfile() async {
  //   try {
  //     bool isConnected = await br!.checkConnectivity();
  //     if (isConnected) {
  //       await apiHelper?.getUserProfile(global.user.id!).then((result) {
  //         if (result != null) {
  //           if (result.status == "1") {
  //             _user = result.recordList;
  //             int? _tCartCount = global.user.cart_count;
  //             global.user = _user!;
  //             global.user.cart_count = _tCartCount;
  //
  //             global.sp!.setString('currentUser', json.encode(global.user.toJson()));
  //           }
  //         }
  //       });
  //     } else {
  //       showNetworkErrorSnackBar(_scaffoldKey!);
  //     }
  //   } catch (e) {
  //     print("Exception - profileScreen.dart - _getUserProfile():" + e.toString());
  //   }
  // }



  Widget _shimmer() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: SingleChildScrollView(
          child: Column(
            children: [
              CircleAvatar(
                radius: 60,
                child: Card(),
              ),
              SizedBox(
                height: 10,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 80,
                              height: 80,
                              child: Card(margin: EdgeInsets.only(top: 5, bottom: 5)),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width - 220,
                                  height: 40,
                                  child: Card(margin: EdgeInsets.only(top: 5, bottom: 5, left: 5)),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width - 120,
                                  height: 40,
                                  child: Card(margin: EdgeInsets.only(top: 5, bottom: 5, left: 5)),
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 25,
                        )
                      ],
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }



  _showCupertinoModalSheet() {
    try {
      showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
          title: Text(" Select Image"),
          actions: [
            CupertinoActionSheetAction(
              child: Text("Take a picture", style: TextStyle(color: Color(0xFF171D2C))),
              onPressed: () async {
                Navigator.pop(context);
                showOnlyLoaderDialog();
                _tImage = await br?.getCameraImage();
                _updateUserProfileImage(_tImage);
                hideLoader();

                setState(() {});
              },
            ),
            CupertinoActionSheetAction(
              child: Text("Choose from gallery", style: TextStyle(color: Color(0xFF171D2C))),
              onPressed: () async {
                Navigator.pop(context);
                showOnlyLoaderDialog();
                _tImage = await br?.getGalleryImage();
                _updateUserProfileImage(_tImage);
                hideLoader();

                setState(() {});
              },
            )
          ],
          cancelButton: CupertinoActionSheetAction(
            child: Text("Cancel", style: TextStyle(color: Color(0xFFFA692C))),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      );
    } catch (e) {
      print("Exception - accountSettingScreen.dart - _showCupertinoModalSheet():" + e.toString());
    }
  }


  _init() async {
    try {
      await _getUserProfile();
      _isDataLoaded = true;
      setState(() {});
    } catch (e) {
      print("Exception - profileScreen.dart - _init():" + e.toString());
    }
  }

  _getUserProfile() async {
    try {
      bool isConnected = await br!.checkConnectivity();
      if (isConnected) {
        await apiHelper?.getUserProfile(global.user.id!).then((result) {
          if (result != null) {
            if (result.resp_code == "00") {
              global.user  = result.recordList[0];





              global.sp?.setString('currentUser', json.encode(global.user.toJson()));
              //     _user = result.recordList;
              //  int _tCartCount = global.user.cart_count;
              // global.user = _user!;
              //global.user.cart_count = _tCartCount;

              //  global.sp!.setString('currentUser', json.encode(global.user.toJson()));
              //global.sp!.setString('currentUser', json.encode(global.user.toJson()));
            }
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey!);
      }
    } catch (e) {
      print("Exception - profileScreen.dart - _getUserProfile():" + e.toString());
    }
  }




  _updateUserProfileImage(File? _tImage) async {
    try {
      bool isConnected = await br!.checkConnectivity();
      if (isConnected) {
        await apiHelper?.updateProfileImage(id:global.user.id!,user_image:_tImage ).then((result) {
          if (result != null) {
            if (result.resp_code == "00") {
              _user = result.recordList;

              // global.user = _user!;


              //  global.sp!.setString('currentUser', json.encode(global.user.toJson()));
            }
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey!);
      }
    } catch (e) {
      print("Exception - profileScreen.dart - _getUserProfile():" + e.toString());
    }
  }


  _signOutDialog() async {
    try {
      showCupertinoDialog(
          context: context,
          builder: (BuildContext context) {
            return Theme(
              data: ThemeData(dialogBackgroundColor: Colors.white),
              child: CupertinoAlertDialog(
                title: Text(
                 lbl_sign_out,
                ),
                content: Text(
                  txt_confirmation_message_for_sign_out,
                ),
                actions: <Widget>[
                  CupertinoDialogAction(
                    child: Text(
                      lbl_cancel,
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () {
                      // Dismiss the dialog but don't
                      // dismiss the swiped item
                      return Navigator.of(context).pop(false);
                    },
                  ),
                  CupertinoDialogAction(
                    child: Text(btn_sign_out),
                    onPressed: () async {
                      global.sp!.remove("currentUser");

                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignInScreen()));
                      global.user = new CurrentUser();
                    },
                  ),
                ],
              ),
            );
          });
    } catch (e) {
      print('Exception - profileScreen.dart - exitAppDialog(): ' + e.toString());
    }
  }
}
