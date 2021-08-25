
import 'dart:convert';

import 'package:careerfinder/client/api_client.dart';
import 'package:careerfinder/data/wrapper/login_wrapper.dart';
import 'package:careerfinder/event/login_event.dart';
import 'package:careerfinder/utils/api_response.dart';

class LoginRepository {
  final ApiClient client = ApiClient();

  Future<LoginWrapper> login(PostLoginDataEvent loginDataEvent) async {
    print('on login method of repo');

    final resultAPI = await client.postRequest("/job/api/login/", loginDataEvent.loginCredentials);
    return LoginWrapper.fromJson(apiResponse(resultAPI));
  }
}

