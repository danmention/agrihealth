import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({this.btnText, this.onClick}) ;
  final btnText;
  final Function() ? onClick;

  @override
  Widget build(BuildContext context) {
    return
      // InkWell(
      //   onTap: (){
      //     onClick;
      //   },
      //   child: Container(
      //     width: double.infinity,
      //     height: 50,
      //     decoration: BoxDecoration(
      //       gradient: LinearGradient(
      //           colors: [Colors.green, CupertinoColors.systemGreen,],
      //       //     // colors: [Colors.yellow, CupertinoColors.systemYellow,],
      //           end: Alignment.centerLeft,
      //            begin: Alignment.centerRight),
      //       borderRadius: BorderRadius.all(
      //         Radius.circular(5),
      //       ),
      //     ),
      //
      //     child: Center(
      //       child: Text(
      //         btnText,
      //         style: TextStyle(
      //             fontSize: 20,
      //             color: Colors.white,
      //             fontWeight: FontWeight.bold),
      //       ),
      //     ),
      //   ),
      // );

      Container(
        height: 50,
       // width: double.infinity,
        margin: EdgeInsets.only(top: 10),
        //padding: EdgeInsets.symmetric(horizontal: 15),
        child: TextButton(
            style: ButtonStyle(
                textStyle: MaterialStateProperty.all(
                  const TextStyle(fontSize: 15,color: Colors.white),
                ),
                //textStyle: MaterialStateProperty.all(fontSize: 15, color: Colors.white, letterSpacing: 1, fontWeight: FontWeight.w400),


                backgroundColor: MaterialStateProperty.all(
                  Colors.green,
                )),
            onPressed: onClick,
              //_signInWithApple();

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                Text(btnText,style:

                TextStyle(color: Colors.white, letterSpacing: 1, fontWeight: FontWeight.w400), ),

              ],
            )));
  }
}
