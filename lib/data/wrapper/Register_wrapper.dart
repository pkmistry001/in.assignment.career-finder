class RegisterWrapper {
  String? staus;
  String? message;

  RegisterWrapper({ this.staus, this.message, /*this.data*/});

  RegisterWrapper.fromJson(Map<String, dynamic> json) {
    staus = json['staus'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['staus'] = this.staus;
    data['message'] = this.message;
    return data;
  }
}

class Data {
  String? id;
  String? name;
  String? email;
  String? mno;
  String? ps;
  String? gender;
  String? currentAddress;
  String? pLocaion;
  String? jobType;
  String? qua;
  String? pYear;
  String? cgpa;
  String? aofs;
  String? exp;
  String? resume;
  String? veri;
  String? img;
  String? counter;
  String? status;
  String? token;
  String? googleId;

  Data(
      {this.id,
        this.name,
        this.email,
        this.mno,
        this.ps,
        this.gender,
        this.currentAddress,
        this.pLocaion,
        this.jobType,
        this.qua,
        this.pYear,
        this.cgpa,
        this.aofs,
        this.exp,
        this.resume,
        this.veri,
        this.img,
        this.counter,
        this.status,
        this.token,
        this.googleId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mno = json['mno'];
    ps = json['ps'];
    gender = json['gender'];
    currentAddress = json['current_address'];
    pLocaion = json['p_locaion'];
    jobType = json['job_type'];
    qua = json['qua'];
    pYear = json['p_year'];
    cgpa = json['cgpa'];
    aofs = json['aofs'];
    exp = json['exp'];
    resume = json['resume'];
    veri = json['veri'];
    img = json['img'];
    counter = json['counter'];
    status = json['status'];
    token = json['token'];
    googleId = json['google_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mno'] = this.mno;
    data['ps'] = this.ps;
    data['gender'] = this.gender;
    data['current_address'] = this.currentAddress;
    data['p_locaion'] = this.pLocaion;
    data['job_type'] = this.jobType;
    data['qua'] = this.qua;
    data['p_year'] = this.pYear;
    data['cgpa'] = this.cgpa;
    data['aofs'] = this.aofs;
    data['exp'] = this.exp;
    data['resume'] = this.resume;
    data['veri'] = this.veri;
    data['img'] = this.img;
    data['counter'] = this.counter;
    data['status'] = this.status;
    data['token'] = this.token;
    data['google_id'] = this.googleId;
    return data;
  }
}
