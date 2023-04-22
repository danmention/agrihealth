import 'package:agrihealth/models/businessLayer/base.dart';
import 'package:agrihealth/models/projectModel.dart';
import 'package:agrihealth/models/request/project_request.dart';
import 'package:agrihealth/widgets/buttonWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../widgets/custom_textfield.dart';
import '../widgets/custom_textfield_area.dart';
import '../widgets/custom_textfield_currency.dart';

class AddProjectScreen extends Base {
  AddProjectScreen({Key? key}) ;

  @override
  _PostProjectScreenState createState() => _PostProjectScreenState();
}

class _PostProjectScreenState extends BaseState {




  GlobalKey<ScaffoldState>? _scaffoldKey;
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  AddProjectRequest projectModel = AddProjectRequest();
  // TextEditingController _cNameofSchool = new TextEditingController();
  // TextEditingController _cDepartment = new TextEditingController();
  // TextEditingController _cLevel= new TextEditingController();
  TextEditingController _cCost= new TextEditingController();
  TextEditingController _cProjectTitle = new TextEditingController();
  TextEditingController _cprojectDesc = new TextEditingController();
  //TextEditingController _cProjectSupervisor = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
   appBar: AppBar(title: Text(' Add Project')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 60,),

              Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [



                    SizedBox(height: 10,),
                    Text('Cost of Project'),


                    CustomTextFieldAmount(
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




                        SizedBox(height: 40,),
                        Button(btnText: 'Submit',onClick: (){
                          submit();
                         // Navigator.pushNamed(context, "home");
                        },),
                    SizedBox(height: 20,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

    );




  }


  _addproject() {

  }





  submit() async {
    try {

      projectModel.costOfProject = _cCost.text.replaceAll(",", "");


      projectModel.projectTitle = _cProjectTitle.text.trim();
      projectModel.projectDesc = _cprojectDesc.text.trim();




      if (_cCost.text.isNotEmpty && _cProjectTitle.text.isNotEmpty && _cprojectDesc.text.isNotEmpty ) {
        bool isConnected = await br!.checkConnectivity();
        if (isConnected) {
          showOnlyLoaderDialog();
          await apiHelper!.submitProject(projectModel).then((result) {
            if (result != null) {
              if (result.status == "success") {
                hideLoader();
                showSnackBar(key: _scaffoldKey, snackBarMessage: 'Project submitted succesfully' );
                 nextScreen(context, 'home');
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
        showSnackBar(key: _scaffoldKey, snackBarMessage: 'Enter cost of the peoject');
      } else if (_cprojectDesc.text.isEmpty ) {
        showSnackBar(key: _scaffoldKey, snackBarMessage: 'Enter details of the project');
      }
    } catch (e) {
      print("Exception - resetPasswordScreen.dart - _changePassword():" + e.toString());
    }
  }
}

