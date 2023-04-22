class CancelReasons {
  int? res_id;
  String? reason;
  CancelReasons(this.reason, this.res_id);

  CancelReasons.fromJson(Map<String, dynamic> json) {
    try {
      res_id = json['res_id'] != null ? json['res_id'] : null;
      reason = json['reason'] != null ? json['reason'] : null;
    } catch (e) {
      print("Exception - cancelReasonsModel.dart - CancelReasons.fromJson():" + e.toString());
    }
  }
}
