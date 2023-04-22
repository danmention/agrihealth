import 'dart:io';
import 'dart:ui';


import 'package:agrihealth/models/businessLayer/global.dart' as global;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jiffy/jiffy.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'apiHelper.dart';

class BusinessRule {
  APIHelper? apiHelper;

  BusinessRule(APIHelper _apiHelper) {
    apiHelper = _apiHelper;
  }
  String calculateDurationDiff(DateTime date) {
    String durationText =" ";
    try {
      if (Jiffy(DateTime.now()).diff(Jiffy(date), Units.YEAR) > 0) {
        durationText = '${Jiffy(DateTime.now()).diff(Jiffy(date), Units.YEAR)} year ago';
      } else if (Jiffy(DateTime.now()).diff(Jiffy(date), Units.MONTH) > 0) {
        durationText = '${Jiffy(DateTime.now()).diff(Jiffy(date), Units.MONTH)} mon ago';
      } else if (Jiffy(DateTime.now()).diff(Jiffy(date), Units.WEEK) > 0) {
        durationText = '${Jiffy(DateTime.now()).diff(Jiffy(date), Units.WEEK)} week ago';
      } else if (Jiffy(DateTime.now()).diff(Jiffy(date), Units.DAY) > 0) {
        durationText = '${Jiffy(DateTime.now()).diff(Jiffy(date), Units.DAY)} day ago';
      } else if (Jiffy(DateTime.now()).diff(Jiffy(date), Units.HOUR) > 0) {
        durationText = '${Jiffy(DateTime.now()).diff(Jiffy(date), Units.HOUR)} hour ago';
      } else if (Jiffy(DateTime.now()).diff(Jiffy(date), Units.MINUTE) > 0) {
        durationText = '${Jiffy(DateTime.now()).diff(Jiffy(date), Units.MINUTE)} min ago';
      } else {
        durationText = 'now';
      }

      return durationText;
    } catch (e) {
      print("Exception - barberDescriptionScreen.dart - _calculateDurationDiff(): " + e.toString());
      return durationText;
    }
  }

  Future<bool> checkConnectivity() async {
    try {
      bool isConnected;
      var _connectivity = await (Connectivity().checkConnectivity());
      if (_connectivity == ConnectivityResult.mobile) {
        isConnected = true;
      } else if (_connectivity == ConnectivityResult.wifi) {
        isConnected = true;
      } else {
        isConnected = false;
      }

      if (isConnected) {
        try {
          final result = await InternetAddress.lookup('google.com');
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            isConnected = true;
          }
        } on SocketException catch (_) {
          isConnected = false;
        }
      }

      return isConnected;
    } catch (e) {
      print('Exception - businessRule.dart - checkConnectivity(): ' + e.toString());
    }
    return false;
  }

  getSharedPreferences() async {
    try {
      global.sp = await SharedPreferences.getInstance();
    } catch (e) {
      print("Exception - otpVerificationScreen.dart - _saveUser():" + e.toString());
    }
  }

  inviteFriendShareMessage() {
    try {
      Share.share("${global.appShareMessage.replaceAll("[CODE]", "${global.user.userType}")}");
    } catch (e) {
      print("Exception -  businessRule.dart - inviteFriendShareMessage():" + e.toString());
    }
  }

  Future<File?> openCamera() async {
    try {
      PermissionStatus permissionStatus = await Permission.camera.status;
      if (permissionStatus.isLimited || permissionStatus.isDenied) {
        permissionStatus = await Permission.camera.request();
      }
      XFile? _selectedImage = await ImagePicker().pickImage(source: ImageSource.camera);
      File imageFile = File(_selectedImage!.path);
      if (imageFile != null) {
        File? _finalImage = await _cropImage(imageFile.path);

        File? _finalImage1 = await _imageCompress(_finalImage!, imageFile.path);

        return _finalImage1;
      }
    } catch (e) {
      print("Exception - businessRule.dart - openCamera():" + e.toString());
    }
    return null;
  }

  Future<File?> selectImageFromGallery() async {
    try {
      PermissionStatus permissionStatus = await Permission.photos.status;
      if (permissionStatus.isLimited || permissionStatus.isDenied) {
        permissionStatus = await Permission.photos.request();
      }
      File imageFile;
      XFile? _selectedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      imageFile = File(_selectedImage!.path);
      if (imageFile != null) {
        File? _byteData = await _cropImage(imageFile.path);
        _byteData = await _imageCompress(_byteData!, imageFile.path);
        return _byteData;
      }
    } catch (e) {
      print("Exception - businessRule.dart - selectImageFromGallery()" + e.toString());
    }
    return null;
  }

  Future<File?> _cropImage(String sourcePath) async {
    try {



      var croppedFile = await ImageCropper().cropImage(
        sourcePath: sourcePath,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        androidUiSettings: AndroidUiSettings(
          initAspectRatio: CropAspectRatioPreset.original,
          backgroundColor: Colors.white,
          toolbarColor: Colors.black,
          dimmedLayerColor: Colors.white,
          toolbarWidgetColor: Colors.white,
          cropGridColor: Colors.white,
          activeControlsWidgetColor: Color(0xFF46A9FC),
          cropFrameColor: Color(0xFF46A9FC),
          lockAspectRatio: true,
        ),
      );
      if (croppedFile != null) {
        return croppedFile;
      }
    } catch (e) {
      print("Exception - businessRule.dart - _cropImage():" + e.toString());
    }
    return null;
  }


  Future<File?> getCameraImage( )async{
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera,
        // maxHeight: 150.0,
        maxWidth: 350.0,

      );
      if (image != null) {

        // print(image.path.toString());
        final  imageTemporary = File(image.path);
        return imageTemporary;

      }
      // Navigator.of(context).pop();


    } catch(e){
      print("error::::::::: $e");
    }
  }


  Future<File?> getGalleryImage( )async{
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery,
        // maxHeight: 150.0,
        maxWidth: 350.0,

      );
      if (image != null) {

        // print(image.path.toString());
        final  imageTemporary = File(image.path);
        return imageTemporary;

      }
      // Navigator.of(context).pop();


    } catch(e){
      print("error::::::::: $e");
    }
  }



  Future<File?> _imageCompress(File file, String targetPath) async {
    try {
      var result = await FlutterImageCompress.compressAndGetFile(
        file.path,
        targetPath,
        minHeight: 500,
        minWidth: 500,
        quality: 60,
      );

      return result;
    } catch (e) {
      print("Exception - businessRule.dart - _cropImage():" + e.toString());
      return null;
    }
  }

  static int convertYearTo4Digits(int year) {
    if (year < 100 && year >= 0) {
      var now = DateTime.now();
      String currentYear = now.year.toString();
      String prefix = currentYear.substring(0, currentYear.length - 2);
      year = int.parse('$prefix${year.toString().padLeft(2, '0')}');
    }
    return year;
  }

  static String getCleanedNumber(String text) {
    RegExp regExp = new RegExp(r"[^0-9]");
    return text.replaceAll(regExp, '');
  }

  static List<int> getExpiryDate(String value) {
    var split = value.split(new RegExp(r'(\/)'));
    return [int.parse(split[0]), int.parse(split[1])];
  }

  static bool hasDateExpired(int month, int year) {
    return !(month == null || year == null) && isNotExpired(year, month);
  }

  static bool hasMonthPassed(int year, int month) {
    var now = DateTime.now();
    // The month has passed if:
    // 1. The year is in the past. In that case, we just assume that the month
    // has passed
    // 2. Card's month (plus another month) is more than current month.
    return hasYearPassed(year) || convertYearTo4Digits(year) == now.year && (month < now.month + 1);
  }

  static bool hasYearPassed(int year) {
    int fourDigitsYear = convertYearTo4Digits(year);
    var now = DateTime.now();
    // The year has passed if the year we are currently is more than card's
    // year
    return fourDigitsYear < now.year;
  }

  static bool isNotExpired(int year, int month) {
    // It has not expired if both the year and date has not passed
    return !hasYearPassed(year) && !hasMonthPassed(year, month);
  }
}

class CardMonthInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    var newText = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = new StringBuffer();
    for (int i = 0; i < newText.length; i++) {
      buffer.write(newText[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 2 == 0 && nonZeroIndex != newText.length) {
        buffer.write('/');
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(text: string, selection: new TextSelection.collapsed(offset: string.length));
  }
}

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = new StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write('  '); // Add double spaces.
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(text: string, selection: new TextSelection.collapsed(offset: string.length));
  }
}

class Strings {
  static const String appName = 'Payment Card Demo';
  static const String fieldReq = 'This field is required';
  static const String numberIsInvalid = 'Card is invalid';
  static const String pay = 'Pay';
}
