part of 'characters_cubit.dart';

sealed class CharactersState {}

final class CharactersInitial extends CharactersState {}

final class CharactersLoaded extends CharactersState {
  final List<CharacterModel> characters;

  CharactersLoaded(this.characters);
}
