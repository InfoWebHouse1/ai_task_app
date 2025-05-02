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
      final encodedData = jsonEncode(data);
      http.Response response = await http.post(
        Uri.parse(url),
        body: encodedData,
        headers: headers ?? {'Content-Type': 'application/json'},
      );
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
        dynamic responseJson = json.decode(response.body);
        String rawText = responseJson['candidates'][0]['content']['parts'][0]['text'];

        rawText = rawText.trim();
        if (rawText.startsWith("```json")) {
          rawText = rawText.replaceFirst("```json", "").trim();
        }
        if (rawText.startsWith("```")) {
          rawText = rawText.replaceFirst("```", "").trim();
        }
        if (rawText.endsWith("```")) {
          rawText = rawText.substring(0, rawText.length - 3).trim();
        }

        return jsonDecode(rawText);
      case 201:dynamic responseJson = json.decode(response.body);
      String rawText = responseJson['candidates'][0]['content']['parts'][0]['text'];
      rawText = rawText.trim();
      if (rawText.startsWith("```json")) {
        rawText = rawText.replaceFirst("```json", "").trim();
      }
      if (rawText.startsWith("```")) {
        rawText = rawText.replaceFirst("```", "").trim();
      }
      if (rawText.endsWith("```")) {
        rawText = rawText.substring(0, rawText.length - 3).trim();
      }

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
