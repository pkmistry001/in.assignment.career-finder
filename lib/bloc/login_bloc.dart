import 'package:careerfinder/event/login_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/login_repository.dart';
import '../state/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState>{
final LoginRepository repository = LoginRepository();

LoginBloc(LoginState initialState) : super(initialState);



@override
Stream<LoginState> mapEventToState(LoginEvent event) async* {
  print('in on boarding login');
  if (event is PostLoginDataEvent) yield* _addLogin(event);
}

Stream<LoginState> _addLogin(PostLoginDataEvent event) async* {
  print('in on boarding login add login method');
  yield LoadingState();
  try {
    yield LoginSuccess(await repository.login(event));
  } catch (e) {
    print(e.toString());
    yield LoginFailure();
  }
}
}
