import 'dart:io';

import 'package:careerfinder/utils/AppException.dart';
import 'package:careerfinder/utils/api_response.dart';
import 'package:careerfinder/utils/apis.dart';
import 'package:careerfinder/utils/constant_strings.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApiClient {
  final http.Client httpClient = http.Client();
  var response;
  var header = {
  HttpHeaders.contentTypeHeader: CONTEXT_TYPE_APPLICATION_JSON
  };

  Future<Response> getRequest(String endPoint) async {
    try {
      response = await httpClient.get(
        getUrl(endPoint),
      );
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    print("Response:${response.body.toString()}");
    return response;
  }

  Future<Response> postRequest(String endPoint, Map<String, dynamic> body) async {
    try {
      response = await httpClient.post(
        getUrl(endPoint),
        body: body
      );
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    print("Response:${response.body.toString()}");
    return response;
  }

  Uri getUrl(String endPoint){
    return Uri.https("$API_BASE_URL",endPoint);
  }
}

