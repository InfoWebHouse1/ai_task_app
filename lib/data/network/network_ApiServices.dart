import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:task_app_ai/contants/constants.dart';
import 'package:task_app_ai/data/network/base_ApiServices.dart';
import 'package:task_app_ai/data/responce/Exception/app_exception.dart';

class NetworkApiService extends BaseApiServices {
  @override
  Future postApiResponse(String url, {dynamic data, headers}) async {
    dynamic responseJson;
    try {
      http.Response response = await http.post(Uri.parse(url), body: data, headers: headers);
      responseJson = returnResponse(response);
    } on SocketException {
      Constants.toastMessage("No Internet Connection");
      throw FetchDataException("No Internet Connection");
    }

    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson200 = json.decode(response.body);
        final rawText = responseJson200['candidates'][0]['content']['parts'][0]['text'];
        return jsonDecode(rawText);
      case 201:
        dynamic responseJson201 = json.decode(response.body);
        final rawText = responseJson201['candidates'][0]['content']['parts'][0]['text'];
        return jsonDecode(rawText);
      case 400:
        throw BadRequestException("${response.reasonPhrase} with status code ${response.statusCode}");
      case 500:
      case 404:
        throw UnauthorizedException("${response.reasonPhrase} with status code ${response.statusCode}");
      default:
        throw FetchDataException("${response.reasonPhrase} with status code ${response.statusCode}");
    }
  }
}
