import 'package:task_app_ai/contants/app_urls.dart';
import 'package:task_app_ai/data/network/base_ApiServices.dart';
import 'package:task_app_ai/data/network/network_ApiServices.dart';

class TaskRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> geminiTextToGenApi(String command) async {
    try {
      dynamic response = await _apiServices.postApiResponse(
        "${AppUrls.baseGeminiTextApiURl}${AppUrls.geminiApiKey}",
        data: {
          "contents": [
            {
              "parts": [
                {"text": "Extract the following info and return JSON only: { \"action\": \"\", \"title\": \"\", \"description\": \"\", \"datetime\": \"\" }. Command: $command"},
              ],
            },
          ],
        },
        headers: {"Content-Type": "application/json"},
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
