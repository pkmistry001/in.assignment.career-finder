class AllJobsWrapper {
  String? staus;
  String? message;
  List<AllJobsDto>? data;

  AllJobsWrapper({this.staus, this.message, this.data});

  AllJobsWrapper.fromJson(Map<String, dynamic> json) {
    staus = json['staus'];
    message = json['message'];
    if (json['data'] != null) {
      data = <AllJobsDto>[];
      json['data'].forEach((v) {
        data!.add(new AllJobsDto.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['staus'] = this.staus;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllJobsDto {
  String? id;
  String? jobType;
  String? designation;
  String? qualification;
  String? jobLocation;
  String? yearOfPassing;
  String? preCgpa;
  String? specialization;
  String? areaOfSector;
  String? exp;
  String? numberOfVacancies;
  String? lasrDateApplication;
  String? hiringProcess;
  String? salaryRange;
  String? min;
  String? max;
  String? rId;
  String? payCount;
  String? postDate;
  String? application;
  String? technology;
  String? jobDesc;
  String? writtenTest;
  String? groupDiscussion;
  String? technicalRound;
  String? hrRound;
  String? metaDesc;
  String? metaKeyword;
  String? author;

  AllJobsDto(
      {this.id,
        this.jobType,
        this.designation,
        this.qualification,
        this.jobLocation,
        this.yearOfPassing,
        this.preCgpa,
        this.specialization,
        this.areaOfSector,
        this.exp,
        this.numberOfVacancies,
        this.lasrDateApplication,
        this.hiringProcess,
        this.salaryRange,
        this.min,
        this.max,
        this.rId,
        this.payCount,
        this.postDate,
        this.application,
        this.technology,
        this.jobDesc,
        this.writtenTest,
        this.groupDiscussion,
        this.technicalRound,
        this.hrRound,
        this.metaDesc,
        this.metaKeyword,
        this.author});

  AllJobsDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobType = json['job_type'];
    designation = json['designation'];
    qualification = json['qualification'];
    jobLocation = json['job_location'];
    yearOfPassing = json['year_of_passing'];
    preCgpa = json['pre_cgpa'];
    specialization = json['specialization'];
    areaOfSector = json['area_of_sector'];
    exp = json['exp'];
    numberOfVacancies = json['number_of_vacancies'];
    lasrDateApplication = json['lasr_date_application'];
    hiringProcess = json['hiring_process'];
    salaryRange = json['salary_range'];
    min = json['min'];
    max = json['max'];
    rId = json['r_id'];
    payCount = json['pay_count'];
    postDate = json['post_date'];
    application = json['application'];
    technology = json['technology'];
    jobDesc = json['job_desc'];
    writtenTest = json['written_test'];
    groupDiscussion = json['group_discussion'];
    technicalRound = json['technical_round'];
    hrRound = json['hr_round'];
    metaDesc = json['meta_desc'];
    metaKeyword = json['meta_keyword'];
    author = json['author'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['job_type'] = this.jobType;
    data['designation'] = this.designation;
    data['qualification'] = this.qualification;
    data['job_location'] = this.jobLocation;
    data['year_of_passing'] = this.yearOfPassing;
    data['pre_cgpa'] = this.preCgpa;
    data['specialization'] = this.specialization;
    data['area_of_sector'] = this.areaOfSector;
    data['exp'] = this.exp;
    data['number_of_vacancies'] = this.numberOfVacancies;
    data['lasr_date_application'] = this.lasrDateApplication;
    data['hiring_process'] = this.hiringProcess;
    data['salary_range'] = this.salaryRange;
    data['min'] = this.min;
    data['max'] = this.max;
    data['r_id'] = this.rId;
    data['pay_count'] = this.payCount;
    data['post_date'] = this.postDate;
    data['application'] = this.application;
    data['technology'] = this.technology;
    data['job_desc'] = this.jobDesc;
    data['written_test'] = this.writtenTest;
    data['group_discussion'] = this.groupDiscussion;
    data['technical_round'] = this.technicalRound;
    data['hr_round'] = this.hrRound;
    data['meta_desc'] = this.metaDesc;
    data['meta_keyword'] = this.metaKeyword;
    data['author'] = this.author;
    return data;
  }
}
