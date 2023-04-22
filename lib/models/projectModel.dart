class ProjectModel2{

  String? description;
  String? name;
  String? title;
  String? image;
  String? amount;

  ProjectModel2({this.description, this.name, this.image, this.amount, this.title});

}

// class ProjectModel {
//   String? status;
//   Data? data;
//   int? id;
//
//   ProjectModel({this.status, this.data, this.id});
//
//   ProjectModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//     id = json['id'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     data['id'] = this.id;
//     return data;
//   }
// }

class ProjectModel {
  int? id;
  int? studentId;
  String? studentName;
  String? projectTitle;
  String? projectDesc;
  String? currentSchoolLevel;
  String? nameOfSchool;
  String? discipline;
  String? projectSupervisor;
  String? costOfProject;
  String? balance;
  int? hasSponsor;
  String? sponsorName;
  int? projectCompletionStatus;
  String? createdAt;

  ProjectModel(
      {this.id,
        this.studentId,
        this.studentName,
        this.projectTitle,
        this.projectDesc,
        this.currentSchoolLevel,
        this.nameOfSchool,
        this.discipline,
        this.projectSupervisor,
        this.costOfProject,
        this.balance,
        this.hasSponsor,
        this.sponsorName,
        this.projectCompletionStatus,
        this.createdAt});

  ProjectModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    studentId = json['student_id'];
    studentName = json['student_name'];
    projectTitle = json['project_title'];
    projectDesc = json['project_desc'];
    currentSchoolLevel = json['current_school_level'];
    nameOfSchool = json['name_of_school'];
    discipline = json['discipline'];
    projectSupervisor = json['project_supervisor'];
    costOfProject = json['cost_of_project'];
    balance = json['balance'];
    hasSponsor = json['has_sponsor'];
    sponsorName = json['sponsor_name'];
    projectCompletionStatus = json['project_completion_status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['student_id'] = this.studentId;
    data['student_name'] = this.studentName;
    data['project_title'] = this.projectTitle;
    data['project_desc'] = this.projectDesc;
    data['current_school_level'] = this.currentSchoolLevel;
    data['name_of_school'] = this.nameOfSchool;
    data['discipline'] = this.discipline;
    data['project_supervisor'] = this.projectSupervisor;
    data['cost_of_project'] = this.costOfProject;
    data['balance'] = this.balance;
    data['has_sponsor'] = this.hasSponsor;
    data['sponsor_name'] = this.sponsorName;
    data['project_completion_status'] = this.projectCompletionStatus;
    data['created_at'] = this.createdAt;
    return data;
  }
}



// class ProjectModel {
//   String? status;
//   List<Data>? data;
//
//   ProjectModel({this.status, this.data});
//
//   ProjectModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(new Data.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Data {
//   int? id;
//   int? studentId;
//   String? studentName;
//   String? projectTitle;
//   String? projectDesc;
//   String? currentSchoolLevel;
//   String? nameOfSchool;
//   String? discipline;
//   String? projectSupervisor;
//   String? costOfProject;
//   String? balance;
//   int? hasSponsor;
//   Null? sponsorName;
//   int? projectCompletionStatus;
//   String? createdAt;
//
//   Data(
//       {this.id,
//         this.studentId,
//         this.studentName,
//         this.projectTitle,
//         this.projectDesc,
//         this.currentSchoolLevel,
//         this.nameOfSchool,
//         this.discipline,
//         this.projectSupervisor,
//         this.costOfProject,
//         this.balance,
//         this.hasSponsor,
//         this.sponsorName,
//         this.projectCompletionStatus,
//         this.createdAt});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     studentId = json['student_id'];
//     studentName = json['student_name'];
//     projectTitle = json['project_title'];
//     projectDesc = json['project_desc'];
//     currentSchoolLevel = json['current_school_level'];
//     nameOfSchool = json['name_of_school'];
//     discipline = json['discipline'];
//     projectSupervisor = json['project_supervisor'];
//     costOfProject = json['cost_of_project'];
//     balance = json['balance'];
//     hasSponsor = json['has_sponsor'];
//     sponsorName = json['sponsor_name'];
//     projectCompletionStatus = json['project_completion_status'];
//     createdAt = json['created_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['student_id'] = this.studentId;
//     data['student_name'] = this.studentName;
//     data['project_title'] = this.projectTitle;
//     data['project_desc'] = this.projectDesc;
//     data['current_school_level'] = this.currentSchoolLevel;
//     data['name_of_school'] = this.nameOfSchool;
//     data['discipline'] = this.discipline;
//     data['project_supervisor'] = this.projectSupervisor;
//     data['cost_of_project'] = this.costOfProject;
//     data['balance'] = this.balance;
//     data['has_sponsor'] = this.hasSponsor;
//     data['sponsor_name'] = this.sponsorName;
//     data['project_completion_status'] = this.projectCompletionStatus;
//     data['created_at'] = this.createdAt;
//     return data;
//   }
// }

