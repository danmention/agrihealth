import 'dart:convert';
import 'dart:io';

import 'package:agrihealth/models/projectModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:agrihealth/models/businessLayer/global.dart' as global;
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:intl/intl.dart';
import '../models/businessLayer/base.dart';
import '../models/request/project_request.dart';
import '../widgets/buttonWidget.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/custom_textfield_area.dart';
import '../widgets/custom_textfield_currency.dart';

class ProductDetailScreen extends Base {
  final ProjectModel projectDetail;
   ProductDetailScreen(this.projectDetail,) ;

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState(this.projectDetail);
}

class _ProductDetailScreenState extends BaseState{

  _ProductDetailScreenState(this.projectDetail);
  ProjectModel projectDetail;
  var publicKey = 'pk_test_79e849b279e8a938d8238afb2cc38536899caadf';
  String?  projectAmount ;
  GlobalKey<ScaffoldState>? _scaffoldKey;
  final plugin = PaystackPlugin();

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  AddProjectRequest projectModel = AddProjectRequest();
  TextEditingController _cNameofSchool = new TextEditingController();
  TextEditingController _cDepartment = new TextEditingController();
  TextEditingController _cLevel= new TextEditingController();
  TextEditingController _cCost= new TextEditingController();
  TextEditingController _cProjectTitle = new TextEditingController();
  TextEditingController _cprojectDesc = new TextEditingController();
  TextEditingController _cProjectSupervisor = new TextEditingController();
  TextEditingController _cProjectId = new TextEditingController();
  TextEditingController _cAmountForPayment= new TextEditingController();

  @override
  Widget build(BuildContext context) {
    projectAmount =   _cAmountForPayment.text + "00";
    return
      SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(title: Text("Project Detail"),),
          body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 0, ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black12
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Container(
                          width: 70.0,
                          height: 70.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      'https://source.unsplash.com/random/800x600?house'
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
                                  Text('${projectDetail.studentName}', style: Theme.of(context).primaryTextTheme.headline6,),
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
                                Container(child:
                                Text(projectDetail.costOfProject != null ?

                                'NGN ${ NumberFormat("#,##0.00", "en_US").format(int.parse(projectDetail.costOfProject!)) }'
                                    : " ", style: Theme.of(context).primaryTextTheme.headline6,)),


                                //Text(subheading!),
                              ],),
                          ),
                        )
                      ],),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18),
                  child: Container(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Row(
                        children: [
                          Text('Balance: ', style: TextStyle(color: Colors.orange)),
                          Text(projectDetail.costOfProject != null ?

                          'NGN ${ NumberFormat("#,##0.00", "en_US").format(int.parse(projectDetail.costOfProject!)) }'
                              : " ", style: Theme.of(context).primaryTextTheme.subtitle1,)
                        ],
                      ),
                      SizedBox(height: 20,),
                     // Text("PROJECT TITLE", style: Theme.of(context).primaryTextTheme.headline4,),
                      Text(projectDetail.projectTitle!,  style: Theme.of(context).primaryTextTheme.headline4,),
                      SizedBox(height: 50,),

                      Text("DESCRIPTION", style: Theme.of(context).primaryTextTheme.subtitle1,),
                      Text(projectDetail.projectDesc!,  style: Theme.of(context).primaryTextTheme.headline3,),

                    global.user.userType =="student"?TextButton(onPressed: (){
                        edit();
                      }, child: Text('Edit')):Container(),
                    ],),),
                ),

                global.user.userType =="sponsor"?
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 16),
                    child: Button(
                      btnText: ' Sponsor Project',
                      onClick: (){
                        //_createPayment();
                        confirmAmount();
                      },

                    ),
                  ),
                ):SizedBox(),


              ],
            ),
          ),
        ),),
      );

  }
  String _getReference() {
    String platform;
    if (Platform.isIOS) {
      platform = 'iOS';
    } else {
      platform = 'Android';
    }

    return 'ChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}';
  }


  String _formatNumber(String s) => NumberFormat.decimalPattern().format(int.parse(s));
  String get _currency => NumberFormat.compactSimpleCurrency().currencySymbol;
  confirmAmount()async{


    await showDialog(
        context: context,
        builder: (context) =>

    new AlertDialog(
      // insetPadding: EdgeInsets.symmetric(horizontal: 20),
      // contentPadding: EdgeInsets.zero,
      // clipBehavior: Clip.antiAliasWithSaveLayer,
      title: new Text('Do you want to go ahead with Payment?'),
      content:   SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [


                Form(
                  key: _formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 10,),
                      Text('Cost of Project'),

                      CustomTextFieldAmount(
                       controller: _cAmountForPayment..text = '${projectDetail.costOfProject! }',
                        //   controller: _cCost.text =projectDetail.costOfProject!,
                        keyBoardType: TextInputType.number,

                      onchange: (string) {
                        string = '${_formatNumber(string.replaceAll(',', ''))}';
                        _cAmountForPayment.value = TextEditingValue(
                          text: string,
                          selection: TextSelection.collapsed(
                              offset: string.length),
                        );
                      }
                      ),
                      SizedBox(height: 10,),

                      Button(btnText: 'Make Payment ',onClick: (){
                         Navigator.pop(context);
                        _createPayment();
                        // Navigator.pushNamed(context, "home");
                      },),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),



      // actions: <Widget>[
      //   new TextButton(
      //     onPressed: () {
      //       Navigator.of(context, rootNavigator: true)
      //           .pop(); // dismisses only the dialog and returns nothing
      //     },
      //     child: new Text('OK'),
      //   ),
      // ],
    ),
    );
  }
  Future<void> _createPayment() async {
    // Create a CheckoutMethod object with payment details




    // Call PaystackSdk.checkout() and handle the result
    //final response = await plugin.checkout(context, checkoutMethod: checkoutMethod);
    var amt  = _cAmountForPayment.text.replaceAll(",", "");
    Charge charge = Charge()

     // ..amount = int.parse(projectAmount!)
      ..amount = int.parse(amt+"00")
     ..reference = _getReference()
    // or ..accessCode = _getAccessCodeFrmInitialization()
      ..email = '${global.user.email}';
    final response = await plugin.checkout(
    context , method: CheckoutMethod.card, charge: charge);


    if (response.status) {
      // Payment was successful
      print('Payment was successful');
      sendSponsoredProject( projectDetail.id!,response.reference!,amt );


    } else {
      // Payment failed
      print('Payment failed');
    }
  }

  @override
  void initState() {
    plugin.initialize(publicKey: publicKey);
    // TODO: implement initState
    super.initState();
  }

  void sendSponsoredProject(int projectId, String reference, String amount) async{
    bool isConnected = await br!.checkConnectivity();
    if (isConnected) {
      showOnlyLoaderDialog();
      await apiHelper!.sponsor( projectId,  reference,  amount).then((result) async {
    if (result != null) {
    if (result.status == "success") {
      showSnackBar(key: _scaffoldKey, snackBarMessage: " Project sponsorship successful");


    Navigator.pushNamed(context, "home");

    } else {
    hideLoader();
    // Map<String, dynamic> jsonResponse = json.decode(result);
    //
    // String errorMessage = jsonResponse["errors"]["message"].first;
    //

    showSnackBar(key: _scaffoldKey, snackBarMessage: '${result.error[0].message}');
    }
    }
    });
    } else {
    showNetworkErrorSnackBar(_scaffoldKey!);
    }

  }

  edit() async{
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    _cCost.text =  NumberFormat("#,##0.00", "en_US").format(int.parse(projectDetail.costOfProject!));
_cProjectTitle.text = projectDetail.projectTitle!;
_cprojectDesc.text = projectDetail.projectDesc!;
    //_cProjectId.text =  projectDetail.id!;
    await showDialog(
        context: context,
        builder: (context) =>

        new AlertDialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 20),
          contentPadding: EdgeInsets.zero,
          clipBehavior: Clip.antiAliasWithSaveLayer,
      title: new Text('Edit'),
      content:   SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: width-20,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [


                Form(
                  key: _formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 10,),
                      Text('Cost of Project'),

                      CustomTextField(
                        controller: _cCost,
                        keyBoardType: TextInputType.number,
                      ),
                      SizedBox(height: 10,),
                      Text('Project Title'),
                      CustomTextField(
                        controller: _cProjectTitle,
                      ),
                      SizedBox(height: 10,),
                      Text('Project Description'),
                      CustomTextFieldArea(controller: _cprojectDesc,),

                                     SizedBox(height: 20,),
                      Button(btnText: 'Submit',onClick: (){
                       
                        submit();
                        // Navigator.pushNamed(context, "home");
                      },),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),



      // actions: <Widget>[
      //   new TextButton(
      //     onPressed: () {
      //       Navigator.of(context, rootNavigator: true)
      //           .pop(); // dismisses only the dialog and returns nothing
      //     },
      //     child: new Text('OK'),
      //   ),
      // ],
    ),
    );
    // showModalBottomSheet(
    //   context: context,
    //   builder: (context) {
    //     return
    //       Padding(
    //         padding: const EdgeInsets.all(8.0),
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             SizedBox(height: 60,),
    //
    //             Form(
    //               key: _formkey,
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //
    //                   Text('Name of school '),
    //                   CustomTextField(
    //                     controller: _cNameofSchool,
    //                   ),
    //                   SizedBox(height: 10,),
    //                   Text('Department'),
    //
    //                   CustomTextField(
    //                     controller: _cDepartment,
    //                   ),
    //                   SizedBox(height: 10,),
    //                   Text('Current Level'),
    //
    //                   CustomTextField(
    //                     controller: _cLevel,
    //                     keyBoardType: TextInputType.number,
    //                   ),
    //
    //
    //                   SizedBox(height: 10,),
    //                   Text('Cost of Project'),
    //
    //                   CustomTextField(
    //                     controller: _cCost,
    //                     keyBoardType: TextInputType.number,
    //                   ),
    //                   SizedBox(height: 10,),
    //                   Text('Project Title'),
    //                   CustomTextField(
    //                     controller: _cProjectTitle,
    //                   ),
    //                   SizedBox(height: 10,),
    //                   Text('Project Description'),
    //                   CustomTextFieldArea(controller: _cprojectDesc,),
    //
    //                   SizedBox(height: 10,),
    //                   Text('Project Supervisor'),
    //                   CustomTextField(controller: _cProjectSupervisor,),
    //
    //
    //                   SizedBox(height: 40,),
    //                   Button(btnText: 'Submit',onClick: (){
    //                     submit();
    //                     // Navigator.pushNamed(context, "home");
    //                   },),
    //                   SizedBox(height: 20,),
    //                 ],
    //               ),
    //             ),
    //           ],
    //         ),
    //       );
    //
    //     //   Wrap(
    //     //   children: [
    //     //     ListTile(
    //     //       leading: Icon(Icons.share),
    //     //       title: Text('Share'),
    //     //     ),
    //     //     ListTile(
    //     //       leading: Icon(Icons.copy),
    //     //       title: Text('Copy Link'),
    //     //     ),
    //     //     ListTile(
    //     //       leading: Icon(Icons.edit),
    //     //       title: Text('Edit'),
    //     //     ),
    //     //   ],
    //     // );
    //   },
    // );
  }

  submit() async {
    try {



      projectModel.costOfProject = _cCost.text.trim();
      projectModel.projectSupervisor = _cProjectSupervisor.text.trim();
      projectModel.currentSchoolLevel = _cLevel.text.trim();
      projectModel.discipline = _cDepartment.text.trim();
      projectModel.nameOfSchool = _cNameofSchool.text.trim();
      projectModel.projectTitle = _cProjectTitle.text.trim();
      projectModel.projectDesc = _cprojectDesc.text.trim();
      projectModel.projectId = projectDetail.id!;




      if (_cCost.text.isNotEmpty && _cProjectTitle.text.isNotEmpty && _cprojectDesc.text.isNotEmpty ) {
        bool isConnected = await br!.checkConnectivity();
        if (isConnected) {
          showOnlyLoaderDialog();
          await apiHelper!.editProject(projectModel).then((result) {
            if (result != null) {
              if (result.status == "success") {
                hideLoader();
                Navigator.pop(context);
                showSnackBar(key: _scaffoldKey, snackBarMessage: 'Project editted succesfully' );
                setState(() { });
              } else {
                hideLoader();
                showSnackBar(key: _scaffoldKey, snackBarMessage: '${result.message}');
              }
            }
          });
        } else {
          showNetworkErrorSnackBar(_scaffoldKey!);
        }
      } else if (_cCost.text.isEmpty ) {
        showSnackBar(key: _scaffoldKey, snackBarMessage: 'Enter cost of the project');
      } else if (_cprojectDesc.text.isEmpty ) {
        showSnackBar(key: _scaffoldKey, snackBarMessage: 'Enter details of the project');
      }
    } catch (e) {
      print("Exception - resetPasswordScreen.dart - _changePassword():" + e.toString());
    }
  }

}
