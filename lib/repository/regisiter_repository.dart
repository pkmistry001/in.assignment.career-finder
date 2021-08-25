
import 'dart:convert';

import 'package:careerfinder/client/api_client.dart';
import 'package:careerfinder/data/wrapper/Register_wrapper.dart';
import 'package:careerfinder/event/register_event.dart';
import 'package:careerfinder/utils/api_response.dart';

class RegisterRepository {
  final ApiClient client = ApiClient();

  Future<RegisterWrapper> registerRepo(PostRegisterDataEvent registerDataEvent) async {
    print('on register of repo');
    final resultAPI = await client.postRequest("/job/api/signUp/", registerDataEvent.data);
    return RegisterWrapper.fromJson(apiResponse(resultAPI));
  }
}

