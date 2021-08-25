import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PostRegisterDataEvent extends RegisterEvent {
  final Map<String, dynamic> data;

  PostRegisterDataEvent(this.data);

  @override
  List<Object> get props => [int];
}
