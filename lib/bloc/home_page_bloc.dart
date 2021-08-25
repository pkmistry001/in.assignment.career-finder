import 'package:careerfinder/event/home_page_event.dart';
import 'package:careerfinder/repository/home_page_repository.dart';
import 'package:careerfinder/state/home_page_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState>{
final HomePageRepository repository = HomePageRepository();

HomePageBloc(HomePageState initialState) : super(initialState);



@override
Stream<HomePageState> mapEventToState(HomePageEvent event) async* {
  print('in on boarding login');
  if (event is GetAllJobsEvent) yield* _getAllJobsList(event);
}

Stream<HomePageState> _getAllJobsList(GetAllJobsEvent event) async* {
  print('in on register method');
  yield LoadingState();
  try {
    yield GetAllJobsSuccess(await repository.getAllJobsRepo());
  } catch (e) {
    print(e.toString());
    yield LoadingFailure();
  }
}
}
