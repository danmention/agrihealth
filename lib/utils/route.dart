
import 'package:agrihealth/screens/homeScreen.dart';
import 'package:agrihealth/screens/otpScreen.dart';
import 'package:agrihealth/screens/signInScreen.dart';
import 'package:agrihealth/screens/signUpScreen.dart';
import 'package:flutter/material.dart';

import '../screens/addProjectScreen.dart';
import '../screens/projectISponsoredScreen.dart';

class RouteGenerator{

  static Route<dynamic> generateRoute(RouteSettings settings)  {
    switch (settings.name) {
      case "home":
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case "otp":
        return MaterialPageRoute(builder: (_) => OtpScreen());

      case "add":
        return MaterialPageRoute(builder: (_) => AddProjectScreen());

      case "login":
        return MaterialPageRoute(builder: (_) => SignInScreen());

      case "mysponsoredproject":
        return MaterialPageRoute(builder: (_) => ProjectISponsoredScreen());

      case "register":
        return MaterialPageRoute(builder: (_) => SignUpScreen());
    // case "DETAIL_ROUTE":
    //   return MaterialPageRoute(builder: (_) => DetailScreen());
    default:
      return MaterialPageRoute(builder: (_) => SignInScreen());
    }
  }

}

