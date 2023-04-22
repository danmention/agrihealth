class APIResult<T> {
  String? status;
  bool ?isDisplayMessage;
  String ?message;
  T? recordList;
  int? totalRecords;
  dynamic value;
  //List<dynamic>? error;
  //Error? error;
  List<Error>? error;
  APIResult({
    this.status,
    this.isDisplayMessage,
    this.message,
    this.recordList,
    this.totalRecords,
    this.value,
    this.error,
  });

  factory APIResult.fromJson(Map<String, dynamic> json, T _recordList) => new APIResult(
        status: json["status"].toString(),
        isDisplayMessage: json['isDisplayMessage'],
        message: json["message"],
        recordList: _recordList,
        totalRecords: json["totalRecords"] != null ? json["totalRecords"] : null,
        value: json["value"] == null ? null : json["value"],
        error:  json['error'] != null?List<Error>.from(
            json['error'].map((error) => Error.fromJson(error))):null,

//        (json['error'] != null) {
//   error = <Error>[];
//   json['error'].forEach((v) {
//   error!.add(new Error.fromJson(v));
//   });
// }
//         error: json["error"] != null ? Error.fromJson(json["error"]) : null,



       // error: json["error"] ,
      );
}




class Error {
  String? message;

  Error({this.message});

  Error.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    return data;
  }
}


// class Error {
//   String? apiName;
//   String? apiType;
//   String? fileName;
//   dynamic functionName;
//   dynamic lineNumber;
//   dynamic typeName;
//   String? stack;
//
//   Error({
//     this.apiName,
//     this.apiType,
//     this.fileName,
//     this.functionName,
//     this.lineNumber,
//     this.typeName,
//     this.stack,
//   });
//
//   factory Error.fromJson(Map<String, dynamic> json) => new Error(
//         apiName: json["apiName"],
//         apiType: json["apiType"],
//         fileName: json["fileName"],
//         functionName: json["functionName"],
//         lineNumber: json["lineNumber"],
//         typeName: json["typeName"],
//         stack: json["stack"],
//       );
// }
