class AddProjectRequest {

  String? projectTitle;
  String? projectDesc;
  String? currentSchoolLevel;
  String? nameOfSchool;
  String? discipline;
  String? projectSupervisor;
  String? costOfProject;
  int? projectId;


  AddProjectRequest(
      {

        this.projectTitle,
        this.projectDesc,
        this.currentSchoolLevel,
        this.nameOfSchool,
        this.discipline,
        this.projectSupervisor,
        this.costOfProject,
        this.projectId


      });

  AddProjectRequest.fromJson(Map<String, dynamic> json) {

    projectTitle = json['project_title'];
    projectDesc = json['project_desc'];
    currentSchoolLevel = json['current_school_level'];
    nameOfSchool = json['name_of_school'];
    discipline = json['discipline'];
    projectSupervisor = json['project_supervisor'];
    costOfProject = json['cost_of_project'];
    projectId = json['project_id'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['project_title'] = this.projectTitle;
    data['project_desc'] = this.projectDesc;
    // data['current_school_level'] = this.currentSchoolLevel;
    // data['name_of_school'] = this.nameOfSchool;
    // data['discipline'] = this.discipline;
    // data['project_supervisor'] = this.projectSupervisor;
    data['cost_of_project'] = this.costOfProject;
    data['project_id'] = this.projectId;

    return data;
  }
}