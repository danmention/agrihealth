
import 'package:agrihealth/models/projectModel.dart';
import 'package:agrihealth/screens/productDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:shimmer/shimmer.dart';
import 'package:agrihealth/models/businessLayer/global.dart' as global;
import '../models/businessLayer/base.dart';
import '../models/businessLayer/baseRoute.dart';
import '../utils/constant.dart';
import '../widgets/cardSponsorWidget.dart';
import '../widgets/navbar.dart';
import 'addProjectScreen.dart';

class HomeScreen extends Base {

  HomeScreen({a, }) ;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseState {
  bool _isProductsLoaded = false;
  GlobalKey<ScaffoldState>? _scaffoldKey;
  List<ProjectModel> _productList = [];




  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
        onWillPop: ()async {
      return false;
    },

   child:   sc(
      Scaffold(
        appBar: AppBar(
           // automaticallyImplyLeading: false,
            title: Text('Projects',), centerTitle: true,),
        drawer: NavDrawer(),
        floatingActionButton:
        global.user.userType =="student"?
        Container(

          padding: EdgeInsets.only(bottom: 50.0, right: 16),
          child: Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton.extended(
                backgroundColor: Colors.orange,
             // onPressed: _addproject(),
              onPressed: (){

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  AddProjectScreen()),
                );
              },
              icon: Icon(Icons.add),
              label: Text("Add New Project"),
            ),
          ),
        ): Container(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        resizeToAvoidBottomInset: true,
        body: _isProductsLoaded
        ? _productList.length > 0
        ? _products()
        : Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Align(
        alignment: Alignment.center,
        child: Text(
            txt_nothing_is_yet_to_see_here,
        style: Theme.of(context).primaryTextTheme.subtitle1,
        ),
        ),
        )
        : _shimmer3(),
              ),
              ));
          }

  _init() async {
    if(global.user.userType =="student"){
      await _getStudentProJects();
    }else{
      _getAllProjects();
    }


    setState(() {});
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _init();
  }

  _getStudentProJects() async {
    try {
     _isProductsLoaded = true;
      bool isConnected = await br!.checkConnectivity();
      _isProductsLoaded = true;
      if (isConnected) {
        showOnlyLoaderDialog();
        await apiHelper?.getStudentProject().then((result) {
          hideLoader();
          if (result != null) {
            if (result.status == "success") {

              _productList = result.recordList;

            } else {}
          }
          _isProductsLoaded = true;
          setState(() {});
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey!);
      }
    } catch (e) {
      print("Exception - homeScreen.dart - _getProducts():" + e.toString());
    }
  }



  _getAllProjects() async {
    try {
      _isProductsLoaded = true;
      bool isConnected = await br!.checkConnectivity();
      _isProductsLoaded = true;
      if (isConnected) {
        showOnlyLoaderDialog();
        await apiHelper?.getAllProject().then((result) {
          hideLoader();
          if (result != null) {
            if (result.status == "success") {
              _productList = result.recordList;

            } else {}
          }
          _isProductsLoaded = true;
          setState(() {});
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey!);
      }
    } catch (e) {
      print("Exception - homeScreen.dart - _getAllProjects():" + e.toString());
    }
  }

  Widget _shimmer3() {
    return Padding(
        padding: const EdgeInsets.all(15),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return SizedBox(
                  width: 170,
                  height: 150,
                  child: Card(
                    margin: EdgeInsets.only(left: 5, right: 5),
                  ),
                );
              }),
        ));
  }


 Widget _products(){
return
  ListView.builder(
      itemCount: _productList.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => ProductDetailScreen(_productList[index])),
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 7, right: 7, bottom: 3, top: 5),
            child: CardSponsor(heading: _productList[index].studentName,amount:_productList[index].costOfProject,  subheading:_productList[index].projectTitle ,
              cardImage: "https://source.unsplash.com/random/800x600?house ",
              buttonTitle:
              global.user.userType =="student"?
              _productList[index].hasSponsor==0?" Open For Sponsorship":"Has a Sponsor":
              "Open for Sponsorship",
              supportingText: _productList[index].projectDesc, ),
          ),
        );
      });
 }

  _addproject() {
   Navigator.pushNamed(context, "add");
  }
}
