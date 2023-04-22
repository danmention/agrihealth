import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Map<int, Color> color = {
  50: Color.fromRGBO(255, 166, 146, .1),
  100: Color.fromRGBO(255, 166, 146, .2),
  200: Color.fromRGBO(255, 166, 146, .3),
  300: Color.fromRGBO(255, 166, 146, .4),
  400: Color.fromRGBO(255, 166, 146, .5),
  500: Color.fromRGBO(255, 166, 146, .6),
  600: Color.fromRGBO(255, 166, 146, .7),
  700: Color.fromRGBO(255, 166, 146, .8),
  800: Color.fromRGBO(255, 166, 146, .9),
  900: Color.fromRGBO(255, 166, 146, 1),
};
ThemeData nativeTheme() {
  return ThemeData(
    textSelectionTheme: TextSelectionThemeData(cursorColor: Color(0xFF07BD50), selectionHandleColor: Color(0xFF07e060)),
    splashFactory: NoSplash.splashFactory,
    primaryColor: Color(0xFF07BD50),
    primaryColorLight: Color(0xFF898A8D), // Color(0xFF66d5ff),
    primaryColorDark: Color(0xFF07BD50),
    primarySwatch: MaterialColor(0xFF07BD50, color),
    primaryIconTheme: IconThemeData(color: Color(0xFF07BD50)),
    cardColor: Colors.white,
    accentColor: Colors.red,
    primaryTextTheme: TextTheme(
      headline1: TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.w500), // listtile title white
      headline2: TextStyle(color: Colors.white70, fontSize: 11), // listtile subtitle white
      headline3: TextStyle(fontSize: 14, color: Color(0xFF171D2C), fontWeight: FontWeight.w500), // signup / signin
      headline4: TextStyle(fontSize: 30, color: Color(0xFF171D2C), letterSpacing: -0.5, fontWeight: FontWeight.bold), // signup && sign in
      headline5: TextStyle(fontSize: 15, color: Color(0xFF07BD50), fontWeight: FontWeight.w400), // - homeScreen - orange
      headline6: TextStyle(fontSize: 15, color: Color(0xFF171D2C), fontWeight: FontWeight.w600), //-  home Screen
      subtitle1: TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w400), // listtile subtitle
      subtitle2: TextStyle(fontSize: 14, color: Color(0xFF565656), fontWeight: FontWeight.w600), // Listtile title
      caption: TextStyle(fontSize: 25, color: Color(0xFF171D2C), fontWeight: FontWeight.bold), // verify, reset, forgot pwd,
      overline: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w600), // book appoinments

      button: TextStyle(fontSize: 13.5, color: Color(0xFF565656), fontWeight: FontWeight.w600),

      bodyText1: TextStyle(
        fontSize: 13,
        color: Color(0xFF171D2C),
        fontWeight: FontWeight.w500,
      ), // home screen
      bodyText2: TextStyle(fontSize: 12, color: Color(0xFF898A8D), fontWeight: FontWeight.w400), // home screen
    ),
    scaffoldBackgroundColor: Colors.white,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF07BD50),
    ),
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: Colors.grey[100],
      titleTextStyle: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF07BD50)),
    ),
    fontFamily: 'Poppins',
    dividerColor: Colors.transparent,
    buttonTheme: ButtonThemeData(
      textTheme: ButtonTextTheme.primary,
      height: 50,
      buttonColor: Color(0xFF07BD50),
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      disabledColor: Colors.grey,
      shape: RoundedRectangleBorder(borderRadius: new BorderRadius.all(new Radius.circular(10.0))),
    ),
    cardTheme: CardTheme(
      elevation: 2,
      margin: EdgeInsets.all(0),
      shadowColor: Colors.grey[200],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    ),
    disabledColor: Colors.grey,
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.all(8),
      alignLabelWithHint: true,
      hintStyle: TextStyle(
        fontSize: 15,
        color: Color(0xFF898A8D),
        fontWeight: FontWeight.w400,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        borderSide: BorderSide(width: 0.2, color: Colors.transparent),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        borderSide: BorderSide(color: Color(0xFF898A8D).withOpacity(0.5)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.green),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.green),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF07BD50)),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      filled: true,
      fillColor: Colors.white,
      floatingLabelBehavior: FloatingLabelBehavior.always,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF171D2C),
      selectedIconTheme: IconThemeData(color: Color(0xFFFA692C), size: 26),
      unselectedIconTheme: IconThemeData(color: Color(0xFF898A8D), size: 26),
    ),
    appBarTheme: AppBarTheme(
      color: Colors.green,
      elevation: 0,
      toolbarHeight: 80,
      brightness: Brightness.light,
      actionsIconTheme: IconThemeData(color: Color(0xFF171D2C), size: 30),
      iconTheme: IconThemeData(color: Color(0xFFFFFFFF), size: 30),
      titleTextStyle: TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.w600),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          Color(0xFF07BD50),
        ),
        textStyle: MaterialStateProperty.all(TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w400)),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.all(0)),
          backgroundColor: MaterialStateProperty.all(Color(0xFF07BD50)),
          shadowColor: MaterialStateProperty.all(Colors.white),
          foregroundColor: MaterialStateProperty.all(Colors.white),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          )),
          textStyle: MaterialStateProperty.all(TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w400)),
        )),
    iconTheme: IconThemeData(color: Color(0xFF898A8D)),
    accentIconTheme: IconThemeData(color: Color(0xFF07BD50)),

    tabBarTheme: TabBarTheme(
      labelPadding: EdgeInsets.only(bottom: 3),
      indicatorSize: TabBarIndicatorSize.label,
      labelStyle: TextStyle(fontSize: 13.5, color: Color(0xFF171D2C), fontWeight: FontWeight.w500),
      unselectedLabelStyle: TextStyle(fontSize: 13.5, color: Color(0xFF898A8D), fontWeight: FontWeight.w400),
    ),

    bottomAppBarTheme: BottomAppBarTheme(color: Color(0xFF171D2C)),
    snackBarTheme: SnackBarThemeData(backgroundColor: Color(0xFF171D2C), contentTextStyle: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w400), behavior: SnackBarBehavior.fixed),
  );
}
