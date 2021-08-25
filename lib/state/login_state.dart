import 'package:careerfinder/data/wrapper/login_wrapper.dart';
import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoadingProgress extends LoginState {}
class LoginFailure extends LoginState {}
class LoadingState extends LoginState {}

class LoginSuccess extends LoginState {
  // final BaseModel<Login>  response;
  final LoginWrapper?  response;

  const LoginSuccess([this.response]);

  @override
  List<Object> get props => [response!];

  @override
  String toString() => 'LoginLoadSuccess { Login: $response }';
}

/*class DeviceRegistrationSuccess extends LoginState {
  // final BaseModel<Login>  response;
  final NotificationResponse?  response;

  const DeviceRegistrationSuccess([this.response]);

  @override
  List<Object> get props => [response!];

  @override
  String toString() => 'DeviceRegistrationSuccess { DeviceRegistration: $response }';
}*/

