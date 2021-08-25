import 'package:careerfinder/event/register_event.dart';
import 'package:careerfinder/repository/regisiter_repository.dart';
import 'package:careerfinder/state/register_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState>{
final RegisterRepository repository = RegisterRepository();

RegisterBloc(RegisterState initialState) : super(initialState);



@override
Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
  print('in on boarding login');
  if (event is PostRegisterDataEvent) yield* _addRegister(event);
}

Stream<RegisterState> _addRegister(PostRegisterDataEvent event) async* {
  print('in on register method');
  yield LoadingState();
  try {
    yield RegisterSuccess(await repository.registerRepo(event));
  } catch (e) {
    print(e.toString());
    yield LoadingFailure();
  }
}
}
