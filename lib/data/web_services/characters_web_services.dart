import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rick_and_morty/constants/strings.dart';

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
    try {
      Response response = await dio.get(endPointCharacters);
      return response.data['results'];
    } catch (e) {
      log(" api error ${e.toString()}");
      return [];
    }
  }

  Future<Map<String,dynamic>> fetchLocation(String id) async {
    try {
      Response response = await dio.get("$endPointLocation/$id");
      log(response.data.toString());
      return response.data;
    } catch (e) {
      log(" api error ${e.toString()}");
      return {};
    }
  }
}
