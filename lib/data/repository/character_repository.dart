import '../models/character_model.dart';
import '../web_services/characters_web_services.dart';

class CharacterRepository {
  final CharactersWebServices charctersWebServices;
  CharacterRepository(this.charctersWebServices);

  Future<List<CharacterModel>> getAllCharacters() async {
    final characters = await charctersWebServices.fetchAllCaracters();
    return characters.map((character) => CharacterModel.fromJson(character)).toList();
  }
  
}
