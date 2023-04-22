import 'package:agrihealth/widgets/buttonWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CardSponsor extends StatelessWidget {


  final String? cardImage;
  final String? buttonTitle;
  final String? heading;
  final String? supportingText;
  final String? subheading;
  final String? amount;
  const CardSponsor({this.buttonTitle=" Open", this.amount,this.cardImage, this.heading,this.subheading,this.supportingText}) ;



  @override
  Widget build(BuildContext context) {
     return Card(
        shadowColor: Colors.blueGrey,
        margin: EdgeInsets.only(top: 60),
        elevation: 4.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                   Container(
                        width: 50.0,
                        height: 50.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                                image: NetworkImage(
                                    cardImage!
                                ), fit: BoxFit.cover)
                        ),
                      ),





                    Expanded(
                      flex: 2,
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(

                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(heading!, style: Theme.of(context).primaryTextTheme.headline6,),
                              Row(children: [
                                Container(
                                  width:120,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: const Text('Sponsor this Project ', style: TextStyle(fontSize: 10, color: Colors.white),),
                                  ),
                                decoration: BoxDecoration(
                                    color: Colors.blueGrey,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(7.0),
                                    ),

                                ),),

                              ],)
                              ,
                            ],),
                        ),
                      ),
                    ),


                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Column(

                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(child: Text(amount != null ?'NGN ${NumberFormat("##,##0.00", "en_US").format(int.parse(amount!))}': " ", style: Theme.of(context).primaryTextTheme.headline6,)),
                            //Text(subheading!),
                          ],),
                      ),
                    )
                  ],),
              ),


             Row(
               children:[
                 Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   mainAxisAlignment: MainAxisAlignment.start,
                   children: [
                     Text("Project Title", style: Theme.of(context).primaryTextTheme.subtitle1,),
                     Text(subheading!,overflow: TextOverflow.ellipsis,maxLines: 1,),
                   ],),
               ]
             ),


              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Button(
                  btnText: buttonTitle,

                ),
              )
            ],
          ),
        ));;
  }
}
