 
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/data/repository/character_repository.dart';

import '../../data/models/character_model.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharacterRepository characterRepository;
  CharactersCubit(this.characterRepository) : super(CharactersInitial());
  List<CharacterModel> characters = [];

  List<CharacterModel> getAllCharacters() {
    characterRepository.getAllCharacters().then((characters) {
      emit(CharactersLoaded(characters));
      this.characters = characters;
    });
    return characters;
  }
}
