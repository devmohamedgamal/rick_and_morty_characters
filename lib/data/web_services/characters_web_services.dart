import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rick_and_morty/contants/strings.dart';

class CharactersWebServices {
  late Dio dio;

  CharactersWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    );
    dio = Dio(options);
  }

  Future<List<dynamic>> fetchAllCaracters() async {
    // Uri url = Uri.parse("$baseUrl/$endPointCharacters");
    try {
      // http.Response response = await http.get(url);
      // Map<String, dynamic> jsonData = jsonDecode(response.body);
      // CharacterModel characterModel = CharacterModel.fromJson(jsonData['results']);
      // return characterModel;
      Response response = await dio.get(endPointCharacters);
      return response.data['results'];
    } catch (e) {
      log(" api error ${e.toString()}");
      return [];
    }
  }
}
