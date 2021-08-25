import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PostLoginDataEvent extends LoginEvent {
  final Map<String, dynamic> loginCredentials;

  PostLoginDataEvent(this.loginCredentials);

  @override
  List<Object> get props => [int];
}