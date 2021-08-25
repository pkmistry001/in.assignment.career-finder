import 'package:careerfinder/data/wrapper/Register_wrapper.dart';
import 'package:careerfinder/data/wrapper/login_wrapper.dart';
import 'package:equatable/equatable.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class LoadingProgress extends RegisterState {}
class LoadingFailure extends RegisterState {}
class LoadingState extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final RegisterWrapper?  response;

  const RegisterSuccess([this.response]);

  @override
  List<Object> get props => [response!];

  @override
  String toString() => 'RegisterSuccess { Register: $response }';
}


