
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:agrihealth/models/businessLayer/global.dart' as global;
import '../screens/profileScreen.dart';
import '../screens/signInScreen.dart';
import '../utils/constant.dart';




class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Drawer(
      width: size.width*0.6,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
           //child: Image.asset('assets/farmlogo.png', width: 50,),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [

               Image.asset('assets/user.png', width: 80
                 ,),
      //global.user.userType =="student"
           Text(global.user.firstname??""),
             global.user.userType =="student"? Text("Student", style: TextStyle(color: Colors.white),):
             Text("Sponsor",style: TextStyle(color: Colors.white),),
        ],),




            decoration: BoxDecoration(
                color:  Colors.green,
                // image: DecorationImage(
                //     fit: BoxFit.fill,
                //     image: AssetImage('assets/images/cover.jpg'))

            ),
          ),
          ListTile(
            leading: Icon(Icons.input),
            title: Text('Home'),
            onTap: () => {
            Navigator.pushNamed(context, "home")
            },
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Profile'),
            onTap: () => {

              Navigator.of(context).pop(),
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  ProfileScreen()),
              )


            },
          ),
          // ListTile(
          //   leading: Icon(Icons.settings),
          //   title: Text('History'),
          //   onTap: () => {
          //     Navigator.of(context).pop(),
          //   // Navigator.push(
          //   // context,
          //   // MaterialPageRoute(builder: (context) =>  ReportHistoryScreen()),
          //   // )
          //   },
          // ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Sponsored Project '),
            onTap: () => {

              Navigator.of(context).pop(),
              Navigator.pushNamed(context, "mysponsoredproject")
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) =>  ViewTestimony()),
              // )


            },
          ),

          // ListTile(
          //   leading: Icon(Icons.),
          //   title: Text('Award'),
          //   onTap: () => {Navigator.of(context).pop()},
          // ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {_signOutDialog(context)},
          ),
        ],
      ),
    );
  }


  _signOutDialog(BuildContext context ) async {
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
                      //global.sp!.remove("currentUser");

                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignInScreen()));
                     // global.user = new CurrentUser();
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