import 'package:careerfinder/data/wrapper/Register_wrapper.dart';
import 'package:careerfinder/data/wrapper/all_jobs_wrapper.dart';
import 'package:careerfinder/data/wrapper/login_wrapper.dart';
import 'package:equatable/equatable.dart';

abstract class HomePageState extends Equatable {
  const HomePageState();

  @override
  List<Object> get props => [];
}

class LoadingProgress extends HomePageState {}
class LoadingFailure extends HomePageState {}
class LoadingState extends HomePageState {}

class GetAllJobsSuccess extends HomePageState {
  final AllJobsWrapper?  response;

  const GetAllJobsSuccess([this.response]);

  @override
  List<Object> get props => [response!];

  @override
  String toString() => 'Get All Jobs Success { All jobs: $response }';
}


