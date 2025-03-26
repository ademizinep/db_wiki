import 'package:dio/dio.dart';

import '../features/home/model/characters_list_model.dart';

class RemoteDatasource {
  final Dio http = Dio();

  Future<CharactersList?> getCharacters() async {
    var response = await http.get(
      'https://dragonball-api.com/api/characters?limit=100',
      options: Options(
        followRedirects: false,
        validateStatus: (statusCode) {
          return [200, 404].contains(statusCode);
        },
      ),
    );

    if (response.statusCode == 200) {
      return CharactersList.fromJson(response.data);
    } else {
      return null;
    }
  }
}
