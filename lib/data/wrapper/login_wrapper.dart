import 'Register_wrapper.dart';

class LoginWrapper {
  String? staus;
  String? message;

  LoginWrapper({this.staus, this.message,});

  LoginWrapper.fromJson(Map<String, dynamic> json) {
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
