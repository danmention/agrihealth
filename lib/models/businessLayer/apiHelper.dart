import 'dart:convert';
import 'dart:io';
import 'package:agrihealth/models/businessLayer/apiResult.dart';
import 'package:agrihealth/models/businessLayer/dioResult.dart';
import 'package:agrihealth/models/businessLayer/global.dart' as global;
import 'package:agrihealth/models/cancelReasonModel.dart';
import 'package:agrihealth/models/projectModel.dart';
import 'package:agrihealth/models/userModel.dart';


import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import '../../screens/otpScreen.dart';
import '../request/project_request.dart';
import '../termsAndConditionModel.dart';

class APIHelper {





  Future<dynamic> changePassword(String oldpassword, String newpassword) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}change-password"),
        headers: await global.getApiHeaders(true),
        body: json.encode({"password": oldpassword, "new_password": newpassword}),
      );

      dynamic recordList;
      if (response.statusCode == 200 ) {

        recordList = json.decode(response.body);

      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - changePassword(): " + e.toString());
    }
  }





  Future<dynamic> getAllProjectISponsored() async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}fetch-sponsor-projects"),
        headers: await global.getApiHeaders(true),

      );

      dynamic recordList;
      if (response.statusCode == 200 && jsonDecode(response.body)["status"] == "success") {
        recordList = List<ProjectModel>.from(json.decode(response.body)["data"].map((x) => ProjectModel.fromJson(x)));

      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - getAllprojectISponsored(): " + e.toString());
    }
  }





  Future<dynamic> getAllProject() async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}fetch-projects"),
        headers: await global.getApiHeaders(true),

      );

      dynamic recordList;
      if (response.statusCode == 200 && jsonDecode(response.body)["status"] == "success") {
        recordList = List<ProjectModel>.from(json.decode(response.body)["data"].map((x) => ProjectModel.fromJson(x)));

      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - getAllproject(): " + e.toString());
    }
  }





  Future<dynamic> getStudentProject() async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}get-student-projects"),
        headers: await global.getApiHeaders(true),

      );

      dynamic recordList;
      if (response.statusCode == 200 && jsonDecode(response.body)["status"] == "success") {
        recordList = List<ProjectModel>.from(json.decode(response.body)["data"].map((x) => ProjectModel.fromJson(x)));

      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - getStudentproject(): " + e.toString());
    }
  }



  Future<dynamic> submitProject(AddProjectRequest projectModel) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}create-project"),
        headers: await global.getApiHeaders(true),
        body: json.encode(projectModel),
      );

      dynamic recordList;
      if (response.statusCode == 200 && jsonDecode(response.body)["status"] == "success") {
        recordList = ProjectModel.fromJson(json.decode(response.body)["data"]);
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - addproject(): " + e.toString());
    }
  }



  Future<dynamic> editProject(AddProjectRequest projectModel) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}edit-project"),
        headers: await global.getApiHeaders(true),
        body: json.encode(projectModel),
      );

      dynamic recordList;
      if (response.statusCode == 200 && jsonDecode(response.body)["status"] == "success") {
        recordList = ProjectModel.fromJson(json.decode(response.body)["data"]);
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - editproject(): " + e.toString());
    }
  }


  //
  // Future<dynamic> deleteAllNotifications(int user_id) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse("${global.baseUrl}delete_all_notifications"),
  //       headers: await global.getApiHeaders(true),
  //       body: json.encode({"user_id": user_id}),
  //     );
  //
  //     dynamic recordList;
  //     if (response.statusCode == 200) {
  //       return getAPIResult(response, recordList);
  //     }
  //   } catch (e) {
  //     print("Exception - deleteAllNotifications(): " + e.toString());
  //   }
  // }

  // Future<dynamic> delFromCart(int user_id, int product_id) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse("${global.baseUrl}del_frm_cart"),
  //       headers: await global.getApiHeaders(true),
  //       body: json.encode({"user_id": user_id, "product_id": product_id}),
  //     );
  //
  //     dynamic recordList;
  //     if (response.statusCode == 200 && json.decode(response.body)["status"] == "1") {
  //       recordList = Cart.fromJson(json.decode(response.body)["data"]);
  //     } else {
  //       recordList = null;
  //     }
  //     return getAPIResult(response, recordList);
  //   } catch (e) {
  //     print("Exception - delFromCart(): " + e.toString());
  //   }
  // }

  Future<dynamic> forgotPassword(String user_email) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}forget_password"),
        headers: await global.getApiHeaders(false),
        body: json.encode({"user_email": user_email}),
      );

      dynamic recordList;
      if (response.statusCode == 200 && json.decode(response.body) != null && json.decode(response.body)["status"] == "1") {
        recordList = CurrentUser.fromJson(json.decode(response.body)["data"]);
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - forgotPassword(): " + e.toString());
    }
  }

  // Future<dynamic> getAllBookings(int user_id) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse("${global.baseUrl}all_booking"),
  //       headers: await global.getApiHeaders(true),
  //       body: json.encode({"user_id": user_id, "lang": global.languageCode}),
  //     );
  //
  //     dynamic recordList;
  //     if (response.statusCode == 200 && json.decode(response.body)["status"] == "1") {
  //       recordList = List<AllBookings>.from(json.decode(response.body)["data"].map((x) => AllBookings.fromJson(x)));
  //     } else {
  //       recordList = null;
  //     }
  //     return getAPIResult(response, recordList);
  //   } catch (e) {
  //     print("Exception - getAllBookings(): " + e.toString());
  //   }
  // }

  dynamic getAPIResult<T>(final response, T recordList) {
    try {
      dynamic result;
      result = APIResult.fromJson(json.decode(response.body), recordList);
      return result;
    } catch (e) {
      print("Exception - getAPIResult():" + e.toString());
    }
  }

  // Future<dynamic> getBarbersDescription(int staff_id) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse("${global.baseUrl}barber_desc"),
  //       headers: await global.getApiHeaders(false),
  //       body: json.encode({"staff_id": staff_id, }),
  //     );
  //
  //     dynamic recordList;
  //
  //     if (response.statusCode == 200 && json.decode(response.body)["status"] == "1") {
  //       recordList = PopularBarbers.fromJson(json.decode(response.body)["data"]);
  //     } else {
  //       recordList = null;
  //     }
  //     return getAPIResult(response, recordList);
  //   } catch (e) {
  //     print("Exception - getBarbersDescription(): " + e.toString());
  //   }
  // }



  Future<dynamic> getCancelReasons() async {
    try {
      Response response;
      var dio = Dio();

      response = await dio.get('${global.baseUrl}cancel_reasons',
        
          options: Options(
            headers: await global.getApiHeaders(true),
          ));

      dynamic recordList;
      if (response.statusCode == 200 && response.data["status"] == "1") {
        recordList = List<CancelReasons>.from(response.data["data"].map((x) => CancelReasons.fromJson(x)));
      } else {
        recordList = null;
      }
      return getDioResult(response, recordList);
    } catch (e) {
      print("Exception - getCancelReasons(): " + e.toString());
    }
  }



  // Future<dynamic> getCurrency() async {
  //   try {
  //     final response = await http.get(
  //       Uri.parse("${global.baseUrl}currency"),
  //     );
  //
  //     dynamic recordList;
  //     if (response.statusCode == 200 && json.decode(response.body)["status"] == "1") {
  //       recordList = Currency.fromJson(json.decode(response.body)["data"]);
  //     } else {
  //       recordList = null;
  //     }
  //     return getAPIResult(response, recordList);
  //   } catch (e) {
  //     print("Exception - getCurrency(): " + e.toString());
  //   }
  // }

  dynamic getDioResult<T>(final response, T recordList) {
    try {
      dynamic result;
      result = DioResult.fromJson(response, recordList);
      return result;
    } catch (e) {
      print("Exception - getDioResult():" + e.toString());
    }
  }

  // Future<dynamic> getFavoriteList(int user_id) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse("${global.baseUrl}show_fav"),
  //       headers: await global.getApiHeaders(true),
  //       body: json.encode({"user_id": user_id, "lang": global.languageCode}),
  //     );
  //
  //     dynamic recordList;
  //     if (response.statusCode == 200 && json.decode(response.body)["status"] == "1") {
  //       recordList = Favorites.fromJson(json.decode(response.body)["data"]);
  //     } else {
  //       recordList = null;
  //     }
  //     return getAPIResult(response, recordList);
  //   } catch (e) {
  //     print("Exception - getFavoriteList(): " + e.toString());
  //   }
  // }

  // Future<dynamic> getGoogleMap() async {
  //   try {
  //     final response = await http.get(
  //       Uri.parse("${global.baseUrl}google_map"),
  //     );
  //
  //     dynamic recordList;
  //     if (response.statusCode == 200 && json.decode(response.body)["status"] == "1") {
  //       recordList = GoogleMapModel.fromJson(json.decode(response.body)["data"]);
  //     } else {
  //       recordList = null;
  //     }
  //     return getAPIResult(response, recordList);
  //   } catch (e) {
  //     print("Exception - getGoogleMap(): " + e.toString());
  //   }
  // }
  //
  // Future<dynamic> getMapBox() async {
  //   try {
  //     final response = await http.get(
  //       Uri.parse("${global.baseUrl}mapbox"),
  //     );
  //
  //     dynamic recordList;
  //     if (response.statusCode == 200 && json.decode(response.body)["status"] == "1") {
  //       recordList = MapBoxModel.fromJson(json.decode(response.body)["data"]);
  //     } else {
  //       recordList = null;
  //     }
  //     return getAPIResult(response, recordList);
  //   } catch (e) {
  //     print("Exception - getMapBox(): " + e.toString());
  //   }
  // }
  //
  // Future<dynamic> getMapGateway() async {
  //   try {
  //     final response = await http.get(
  //       Uri.parse("${global.baseUrl}mapby"),
  //     );
  //
  //     dynamic recordList;
  //     if (response.statusCode == 200 && json.decode(response.body)["status"] == "1") {
  //       recordList = MapByModel.fromJson(json.decode(response.body)["data"]);
  //     } else {
  //       recordList = null;
  //     }
  //     return getAPIResult(response, recordList);
  //   } catch (e) {
  //     print("Exception - getMapGateway(): " + e.toString());
  //   }
  // }

  // Future<dynamic> getNearByBanners(String lat, String lng) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse("${global.baseUrl}getnearbanner"),
  //       headers: await global.getApiHeaders(false),
  //       body: json.encode({
  //         "lat": lat,
  //         "lng": lng,
  //
  //       }),
  //     );
  //
  //     dynamic recordList;
  //     if (response.statusCode == 200 && json.decode(response.body)["status"] == "1") {
  //       recordList = List<BannerModel>.from(json.decode(response.body)["data"].map((x) => BannerModel.fromJson(x)));
  //     } else {
  //       recordList = null;
  //     }
  //     return getAPIResult(response, recordList);
  //   } catch (e) {
  //     print("Exception - getNearByBanners(): " + e.toString());
  //   }
  // }
  //
  // Future<dynamic> getNearByBarberShops(String lat, String lng, int pageNumber, {String searchstring}) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse("${global.baseUrl}getnearbysalons?page=${pageNumber.toString()}"),
  //       headers: await global.getApiHeaders(false),
  //       body: json.encode({
  //         "lat": lat,
  //         "lng": lng,
  //         "searchstring": searchstring,
  //         "lang": global.languageCode,
  //       }),
  //     );
  //
  //     dynamic recordList;
  //     if (response.statusCode == 200 && json.decode(response.body)["status"] == "1") {
  //       recordList = List<BarberShop>.from(json.decode(response.body)["data"].map((x) => BarberShop.fromJson(x)));
  //     } else {
  //       recordList = null;
  //     }
  //     return getAPIResult(response, recordList);
  //   } catch (e) {
  //     print("Exception - getNearByBarberShops(): " + e.toString());
  //   }
  // }
  //
  // Future<dynamic> getNearByCouponsList(String lat, String lng) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse("${global.baseUrl}getnearcouponlist"),
  //       headers: await global.getApiHeaders(true),
  //       body: json.encode({"lat": lat, "lng": lng, "lang": global.languageCode}),
  //     );
  //
  //     dynamic recordList;
  //     if (response.statusCode == 200 && json.decode(response.body)["status"] == "1") {
  //       recordList = List<Coupons>.from(json.decode(response.body)["data"].map((x) => Coupons.fromJson(x)));
  //     } else {
  //       recordList = null;
  //     }
  //     return getAPIResult(response, recordList);
  //   } catch (e) {
  //     print("Exception - getNearByCouponsList(): " + e.toString());
  //   }
  // }
  //
  // Future<dynamic> getNotifications(int user_id) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse("${global.baseUrl}allnotifications"),
  //       headers: await global.getApiHeaders(true),
  //       body: json.encode({
  //         "user_id": user_id,
  //
  //       }),
  //     );
  //
  //     dynamic recordList;
  //     if (response.statusCode == 200 && json.decode(response.body)["status"] == "1") {
  //       recordList = List<NotificationList>.from(json.decode(response.body)["data"].map((x) => NotificationList.fromJson(x)));
  //     } else {
  //       recordList = null;
  //     }
  //     return getAPIResult(response, recordList);
  //   } catch (e) {
  //     print("Exception - getNotifications(): " + e.toString());
  //   }
  // }
  //
  // Future<dynamic> getPaymentGateways() async {
  //   try {
  //     final response = await http.get(Uri.parse("${global.baseUrl}payment_gateways"), headers: await global.getApiHeaders(true));
  //
  //     dynamic recordList;
  //     if (response.statusCode == 200 && json.decode(response.body)["status"] == "1") {
  //       recordList = PaymentGateway.fromJson(json.decode(response.body)["data"]);
  //     } else {
  //       recordList = null;
  //     }
  //     return getAPIResult(response, recordList);
  //   } catch (e) {
  //     print("Exception - getPaymentGateways(): " + e.toString());
  //   }
  // }

  // Future<dynamic> getPopularBarbersList(String lat, String lng, int pageNumber, String searchstring) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse("${global.baseUrl}popular_barber?page=${pageNumber.toString()}"),
  //       headers: await global.getApiHeaders(false),
  //       body: json.encode({
  //         "lat": lat,
  //         "lng": lng,
  //         "searchstring": searchstring,
  //         "lang": global.languageCode,
  //       }),
  //     );
  //
  //     dynamic recordList;
  //     if (response.statusCode == 200 && json.decode(response.body)["status"] == "1") {
  //       recordList = List<PopularBarbers>.from(json.decode(response.body)["data"].map((x) => PopularBarbers.fromJson(x)));
  //     } else {
  //       recordList = null;
  //     }
  //     return getAPIResult(response, recordList);
  //   } catch (e) {
  //     print("Exception - getPopularBarbersList(): " + e.toString());
  //   }
  // }
  //
  // Future<dynamic> getProductDetails(int product_id) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse("${global.baseUrl}product_det"),
  //       headers: await global.getApiHeaders(false),
  //       body: json.encode({"product_id": product_id, "user_id": global.user.id, "lang": global.languageCode}),
  //     );
  //
  //     dynamic recordList;
  //
  //     if (response.statusCode == 200 && json.decode(response.body)["status"] == "1") {
  //       recordList = ProductDetail.fromJson(json.decode(response.body)["data"]);
  //     } else {
  //       recordList = null;
  //     }
  //     return getAPIResult(response, recordList);
  //   } catch (e) {
  //     print("Exception - getProductDetails(): " + e.toString());
  //   }
  // }
  //
  // Future<dynamic> getProductOrderHistory() async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse("${global.baseUrl}product_orders"),
  //       headers: await global.getApiHeaders(true),
  //       body: json.encode({"user_id": global.user.id, }),
  //     );
  //
  //     dynamic recordList;
  //     if (response.statusCode == 200 && json.decode(response.body)["status"] == "1") {
  //       recordList = List<ProductOrderHistory>.from(json.decode(response.body)["data"].map((x) => ProductOrderHistory.fromJson(x)));
  //     } else {
  //       recordList = null;
  //     }
  //     return getAPIResult(response, recordList);
  //   } catch (e) {
  //     print("Exception - getProductOrderHistory(): " + e.toString());
  //   }
  // }
  //
  // Future<dynamic> getProducts(String lat, String lng, int pageNumber, String searchstring) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse("${global.baseUrl}salon_products?page=${pageNumber.toString()}"),
  //       headers: await global.getApiHeaders(false),
  //       body: json.encode({"lat": lat, "lng": lng, "user_id": global.user.id, "searchstring": searchstring, "lang": global.languageCode}),
  //     );
  //
  //     dynamic recordList;
  //     if (response.statusCode == 200 && json.decode(response.body)["status"] == "1") {
  //       recordList = List<Product>.from(json.decode(response.body)["data"].map((x) => Product.fromJson(x)));
  //     } else {
  //       recordList = null;
  //     }
  //     return getAPIResult(response, recordList);
  //   } catch (e) {
  //     print("Exception - getProducts(): " + e.toString());
  //   }
  // }
  //
  // Future<dynamic> getReferandEarn() async {
  //   try {
  //     Response response;
  //     var dio = Dio();
  //
  //     response = await dio.get('${global.baseUrl}refer_n_earn',
  //
  //         options: Options(
  //           headers: await global.getApiHeaders(true),
  //         ));
  //
  //     dynamic recordList;
  //     if (response.statusCode == 200 && response.data["status"] == "1") {
  //       recordList = response.data["data"];
  //     } else {
  //       recordList = null;
  //     }
  //     return getDioResult(response, recordList);
  //   } catch (e) {
  //     print("Exception - getReferandEarn(): " + e.toString());
  //   }
  // }
  //
  // Future<dynamic> getSalonListForServices(String lat, String lng, String service_name) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse("${global.baseUrl}service_salons"),
  //       headers: await global.getApiHeaders(false),
  //       body: json.encode({
  //         "lat": lat,
  //         "lng": lng,
  //         "service_name": service_name,
  //
  //       }),
  //     );
  //
  //     dynamic recordList;
  //     if (response.statusCode == 200 && json.decode(response.body)["status"] == "1") {
  //       recordList = List<BarberShop>.from(json.decode(response.body)["data"].map((x) => BarberShop.fromJson(x)));
  //     } else {
  //       recordList = null;
  //     }
  //     return getAPIResult(response, recordList);
  //   } catch (e) {
  //     print("Exception - getNearByBarberShops(): " + e.toString());
  //   }
  // }
  //
  // Future<dynamic> getScratchCards() async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse("${global.baseUrl}user_scratch_cards"),
  //       headers: await global.getApiHeaders(true),
  //       body: json.encode({
  //         "user_id": global.user.id,
  //
  //       }),
  //     );
  //
  //     dynamic recordList;
  //     if (response.statusCode == 200 && json.decode(response.body)["status"] == "1") {
  //       recordList = List<ScratchCard>.from(json.decode(response.body)["data"].map((x) => ScratchCard.fromJson(x)));
  //     } else {
  //       recordList = null;
  //     }
  //     return getAPIResult(response, recordList);
  //   } catch (e) {
  //     print("Exception - getScratchCards(): " + e.toString());
  //   }
  // }
  //
  // Future<dynamic> getServices(String lat, String lng, int pageNumber, {String searchstring}) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse("${global.baseUrl}services?page=${pageNumber.toString()}"),
  //       headers: await global.getApiHeaders(false),
  //       body: json.encode({"lat": lat, "lng": lng, "searchstring": searchstring, "lang": global.languageCode}),
  //     );
  //
  //     dynamic recordList;
  //     if (response.statusCode == 200 && json.decode(response.body)["status"] == "1") {
  //       recordList = List<Service>.from(json.decode(response.body)["data"].map((x) => Service.fromJson(x)));
  //     } else {
  //       recordList = null;
  //     }
  //     return getAPIResult(response, recordList);
  //   } catch (e) {
  //     print("Exception - getServices(): " + e.toString());
  //   }
  // }
  //
  Future<dynamic> getTermsAndCondition() async {
    try {
      Response response;
      var dio = Dio();

      response = await dio.get('${global.baseUrl}terms',
          queryParameters: {
           // 'lang': global.languageCode!,
          },
          options: Options(
            headers: await global.getApiHeaders(false),
          ));

      dynamic recordList;
      if (response.statusCode == 200) {
        recordList = TermsAndCondition.fromJson(response.data['data']);
      } else {
        recordList = null;
      }
      return getDioResult(response, recordList);
    } catch (e) {
      print("Exception - getTermsAndCondition(): " + e.toString());
    }
  }
  //
  // Future<dynamic> getTimeSLot(String selected_date, int staff_id, int vendor_id) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse("${global.baseUrl}timeslot"),
  //       headers: await global.getApiHeaders(true),
  //       body: json.encode({
  //         "selected_date": selected_date,
  //         "staff_id": staff_id,
  //         "vendor_id": vendor_id,
  //
  //       }),
  //     );
  //
  //     dynamic recordList;
  //     if (response.statusCode == 200 && json.decode(response.body)["status"] == "1") {
  //       recordList = List<TimeSlot>.from(json.decode(response.body)["data"].map((x) => TimeSlot.fromJson(x)));
  //     } else {
  //       recordList = null;
  //     }
  //     return getAPIResult(response, recordList);
  //   } catch (e) {
  //     print("Exception - getTimeSLot(): " + e.toString());
  //   }
  // }






  Future<dynamic> getUserProfile(int id) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}myprofile"),
        headers: await global.getApiHeaders(true),
        body: json.encode({
          "id": id,
          
        }),
      );

      dynamic recordList;
      if (response.statusCode == 200 && json.decode(response.body)["status"] == "1") {
        recordList = CurrentUser.fromJson(json.decode(response.body)["data"]);
        recordList.token = json.decode(response.body)["token"];
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - getUserProfile(): " + e.toString());
    }
  }

  Future<dynamic> loginWithEmail(CurrentUser user) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}login"),
        headers: await global.getApiHeaders(false),
        body: json.encode(user),
      );

      dynamic recordList;
      if (response.statusCode == 200 && json.decode(response.body)["status"] == "success") {
        recordList = CurrentUser.fromJson(json.decode(response.body)["user_data"]);
print(recordList.toString());
        //recordList.token = json.decode(response.body)["access_token"];
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - loginWithEmail(): " + e.toString());
    }
  }




  Future<dynamic> sponsor(int projectId, String reference, String amount) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}sponsor-project"),
        headers: await global.getApiHeaders(true),
        body:  json.encode({"project_id": projectId, "tran_ref": reference, "amount": amount}),
      );

print(json.encode({"project_id": projectId, "tran_ref": reference, "amount": amount}));
      dynamic recordList;
      if (response.statusCode == 200 && jsonDecode(response.body)["status"] == "success") {
       // recordList = " ";
        print(recordList);
        //recordList.token = json.decode(response.body)["access_token"];
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - sponsorproject(): " + e.toString());
    }
  }


  Future<dynamic> updateProfileImage({
    int? id,

    File? user_image,

  }) async {
    try {
      Response response;
      var dio = Dio();
      var formData = FormData.fromMap({

        "user_id": id,
        'picture': user_image != null ? await MultipartFile.fromFile(user_image.path.toString()) : null,
      });

      response = await dio.post('${global.baseUrl}profile/update/dp',
          data: formData,
          options: Options(
            headers: await global.getApiHeaders(true),
          ));
      dynamic recordList;
      if (response.statusCode == 200) {
        recordList = CurrentUser.fromJson(response.data['data']);
        //  recordList.token = response.data["token"];
      } else {
        recordList = null;
      }
      return getDioResult(response, recordList);
    } catch (e) {
      print("Exception - submitreport(): " + e.toString());
    }
  }

  // Future<dynamic> onScratch(int scratch_id, int user_id) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse("${global.baseUrl}scratch"),
  //       headers: await global.getApiHeaders(true),
  //       body: json.encode({"user_id": user_id, "scratch_id": scratch_id}),
  //     );
  //
  //     dynamic recordList;
  //     if (response.statusCode == 200 && json.decode(response.body)["status"] == "1") {
  //       recordList = ScratchCard.fromJson(json.decode(response.body)["data"]);
  //     } else {
  //       recordList = null;
  //     }
  //     return getAPIResult(response, recordList);
  //   } catch (e) {
  //     print("Exception - onScratch(): " + e.toString());
  //   }
  // }

  // Future<dynamic> privacyPolicy() async {
  //   try {
  //     Response response;
  //     var dio = Dio();
  //
  //     response = await dio.get('${global.baseUrl}privacy',
  //         queryParameters: {
  //           'lang': global.languageCode,
  //         },
  //         options: Options(
  //           headers: await global.getApiHeaders(false),
  //         ));
  //     dynamic recordList;
  //     if (response.statusCode == 200) {
  //       recordList = PrivacyPolicy.fromJson(response.data['data']);
  //     } else {
  //       recordList = null;
  //     }
  //     return getDioResult(response, recordList);
  //   } catch (e) {
  //     print("Exception - privacyPolicy(): " + e.toString());
  //   }
  // }

  // Future<dynamic> productCartCheckout(int user_id, String payment_status, String payment_gateway, {String payment_id}) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse("${global.baseUrl}product_cart_checkout"),
  //       headers: await global.getApiHeaders(true),
  //       body: json.encode({"user_id": user_id, "payment_status": payment_status, "payment_gateway": payment_gateway, "payment_id": payment_id, "lang": global.languageCode}),
  //     );
  //
  //     dynamic recordList;
  //     if (response.statusCode == 200 && json.decode(response.body)["status"] == "1" || json.decode(response.body)["status"] == "2") {
  //       recordList = ProductCartCheckout.fromJson(json.decode(response.body)["data"]["order"]);
  //       global.user.cart_count = json.decode(response.body)['data']['cart_count'];
  //     } else {
  //       recordList = null;
  //     }
  //     return getAPIResult(response, recordList);
  //   } catch (e) {
  //     print("Exception - productCartCheckout(): " + e.toString());
  //   }
  // }

  Future<dynamic> signUp(CurrentUser user) async {
    try {
      Response response;
      var dio = Dio();
      var formData = FormData.fromMap({
        'lastname': user.lastname,
        'email': user.email,
        'phone': user.phone,
        'password': user.password,
        'firstname': user.firstname,
        'user_type': user.userType,

        //'user_image': user.user_image != null ? await MultipartFile.fromFile(user.user_image!.path.toString()) : null,

      });
      
      response = await dio.post('${global.baseUrl}create-user',
          data: formData,
          options: Options(
            headers: await global.getApiHeaders(false),
          ));
      dynamic recordList;
      if (response.statusCode == 200) {
        recordList = CurrentUser.fromJson(response.data);
      } else {
        recordList = null;
      }
      return getDioResult(response, recordList);
    } catch (e) {
      print("Exception - signUp(): " + e.toString());
    }
  }



  Future<dynamic> updateProfile(
    int id,
    String user_name,
    File user_image, {
    String? user_password,
  }) async {
    try {
      Response response;
      var dio = Dio();
      var formData = FormData.fromMap({
        'id': id,
        'user_name': user_name,
        'user_password': user_password,
        
        'user_image': user_image != null ? await MultipartFile.fromFile(user_image.path.toString()) : null,
      });
      
      response = await dio.post('${global.baseUrl}profile_edit',
          data: formData,
          options: Options(
            headers: await global.getApiHeaders(true),
          ));
      dynamic recordList;
      if (response.statusCode == 200) {
        recordList = CurrentUser.fromJson(response.data['data']);
        recordList.token = response.data["token"];
      } else {
        recordList = null;
      }
      return getDioResult(response, recordList);
    } catch (e) {
      print("Exception - updateProfile(): " + e.toString());
    }
  }

  Future<dynamic> verifyOtpAfterLogin(String user_phone, String status, String device_id) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}login_verifyotpfirebase"),
        headers: await global.getApiHeaders(false),
        body: json.encode({"user_phone": user_phone, "status": status, "device_id": device_id}),
      );

      dynamic recordList;
      if (response.statusCode == 200 && json.decode(response.body) != null && json.decode(response.body)["data"] != null) {
        recordList = CurrentUser.fromJson(json.decode(response.body)["data"]["user"]);
        recordList.cart_count = json.decode(response.body)['data']["cart_count"];
        recordList.token = json.decode(response.body)["token"];
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - verifyOtpAfterLogin(): " + e.toString());
    }
  }



  // Future<dynamic> verifyOtpAfterRegistration2(String otp) async {
  //   try {
  //     Response response;
  //     var dio = Dio();
  //     var formData = FormData.fromMap({
  //       'code': otp,
  //
  //
  //       //'user_image': user.user_image != null ? await MultipartFile.fromFile(user.user_image!.path.toString()) : null,
  //
  //     });
  //
  //     response = await dio.post('${global.baseUrl}verify',
  //         data: formData,
  //         options: Options(
  //           headers: await global.getApiHeaders(false),
  //         ));
  //     dynamic recordList;
  //     if (response.statusCode == 200) {
  //       recordList = CurrentUser.fromJson(response.data);
  //     } else {
  //       recordList = null;
  //     }
  //     return getDioResult(response, recordList);
  //   } catch (e) {
  //     print("Exception - otp(): " + e.toString());
  //   }
  // }




  Future<dynamic> verifyOtpAfterRegistration(String otp,) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}verify"),
        headers: await global.getApiHeaders(false),
        body: json.encode({"code": otp, }),
      );

      dynamic recordList;
      if (response.statusCode == 200  && json.decode(response.body) != null) {



          recordList = CurrentUser.fromJson(json.decode(response.body));





      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - verifyOtpAfterRegistration(): " + e.toString());
    }
  }







  Future<dynamic> resendOtp(email) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}resend-code"),
        headers: await global.getApiHeaders(true),
        body: json.encode({"email": email, }),
      );

      dynamic recordList;
      if (response.statusCode == 200  && jsonDecode(response.body)["status"] == "success") {

      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - verifyOtpAfterRegistration(): " + e.toString());
    }
  }



  Future<dynamic> verifyOtpForgotPassword(String user_email, String otp) async {
    try {
      final response = await http.post(
        Uri.parse("${global.baseUrl}verify_otp"),
        headers: await global.getApiHeaders(false),
        body: json.encode({"user_email": user_email, "otp": otp}),
      );

      dynamic recordList;
      if (response.statusCode == 200 && jsonDecode(response.body)["status"] == "1") {
        recordList = CurrentUser.fromJson(json.decode(response.body)["data"]);
      } else {
        recordList = null;
      }
      return getAPIResult(response, recordList);
    } catch (e) {
      print("Exception - verifyOtpForgotPassword(): " + e.toString());
    }
  }
}
