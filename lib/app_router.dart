import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/business_logic/cubit/characters_cubit.dart';
import 'package:rick_and_morty/data/web_services/characters_web_services.dart';

import 'contants/strings.dart';
import 'data/models/character_model.dart';
import 'data/repository/character_repository.dart';
import 'presentation/screens/character_details_screen.dart';
import 'presentation/screens/characters_screen.dart';

class AppRouter {
  late CharacterRepository characterRepository;
  late CharactersCubit charactersCubit;

  AppRouter() {
    characterRepository = CharacterRepository(CharactersWebServices());
    charactersCubit = CharactersCubit(characterRepository);
  }
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => charactersCubit,
            child: const CharactersScreen(),
          ),
        );
      case characterDetailsScreen:
        final character = settings.arguments as CharacterModel;
        return MaterialPageRoute(
            builder: (_) => CharacterDetailsScreen(character: character,));
    }
  }
}
