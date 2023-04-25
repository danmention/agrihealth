class ProfileImage {
  String? status;
  String? path;

  ProfileImage({this.status, this.path});

  ProfileImage.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['path'] = this.path;
    return data;
  }
}