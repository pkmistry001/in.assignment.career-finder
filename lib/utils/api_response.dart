import 'dart:convert';

import 'package:http/http.dart' as http;

import 'AppException.dart';


  dynamic apiResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        print("apiResponse filter ${responseJson}");
        print(responseJson);
        return responseJson;
      case 401:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 201:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 202:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 400:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;

      case 403:
        throw UnauthorisedException(response.body.toString());

      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }