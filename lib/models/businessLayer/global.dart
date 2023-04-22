import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:agrihealth/models/userModel.dart';

String? appDeviceId;
String appName = 'Agrihealth';
String appShareMessage = "I'm inviting you to use $appName, a simple and easy app to find saloon services and products near by your location. Here's my code [CODE] - jusy enter it while registration.";
String appVersion = '1.0';
String baseUrl = 'http://api.agri-health.org/public/';
 String baseUrlForImage = 'https://demo.in/';
 //Currency currency = Currency();

//String currentLocation;
String googleAPIKey = "place your google key here.";
bool isRTL = false;
String? currentLocation;
String? lat;
String? lng;
bool isGoogleMap = false;
// MapBoxModel mapBoxModel = new MapBoxModel();
// GoogleMapModel mapGBoxModel = new GoogleMapModel();

SharedPreferences? sp;
CurrentUser user = new CurrentUser();
Future<Map<String, String>?> getApiHeaders(bool authorizationRequired) async {
  Map<String, String> apiHeader = new Map<String, String>();


  if (authorizationRequired) {
    sp = await SharedPreferences.getInstance();
    try{

      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString('currentUser');
      if (userJson == null) {
        print(" no value");
      }
      final userMap = json.decode(userJson!);
      CurrentUser currentUser  =  CurrentUser.fromJson(userMap);



    //  CurrentUser currentUser = CurrentUser.fromJson(json.decode(sp!.getString("currentUser")??" "));
      print(currentUser);
    }catch (e) {
      print("Exception - addproject(): " + e.toString());
    }



    if (sp?.getString("currentUser") != null) {
      CurrentUser currentUser = CurrentUser.fromJson(json.decode(sp!.getString("currentUser")??" "));
      apiHeader.addAll({"Authorization": "Bearer" + currentUser.accessToken!});
    }
  }
  apiHeader.addAll({"Content-Type": "application/json"});
  apiHeader.addAll({"Accept": "application/json"});
  return apiHeader;
}

Future<String> getDeviceId() async {
  String deviceId =" ";
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  if (Platform.isAndroid) {
    AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
    deviceId = androidDeviceInfo.id;
  } else if (Platform.isIOS) {
    IosDeviceInfo androidDeviceInfo = await deviceInfo.iosInfo;
    deviceId = androidDeviceInfo.identifierForVendor!;
  }
  return deviceId;
}
