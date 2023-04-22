class DioResult<T> {
  int? statusCode;
  String? status;
  String? message;
  List<dynamic>? error;
  T? data;

  DioResult({this.statusCode, this.data, this.status});
  DioResult.fromJson(dynamic response, T recordList) {
    try {
      status = response.data['status'];
      error = response.data['error'];
      message = response.data['message'];
      statusCode = response.statusCode;
      data = recordList;
    } catch (e) {
      print("Exception - dioResult.dart - DioResult.fromJson():" + e.toString());
    }
  }
}
