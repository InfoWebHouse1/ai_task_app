import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

abstract class BaseApiServices {
  Future<dynamic> postApiResponse(String url, {dynamic data, headers});
}
