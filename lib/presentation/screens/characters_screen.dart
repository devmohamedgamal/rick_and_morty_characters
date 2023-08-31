import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/business_logic/cubit/characters_cubit.dart';

import '../../contants/my_colors.dart';
import '../../data/models/character_model.dart';
import '../widgets/character_item.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late List<CharacterModel> allCharacters;
  late List<CharacterModel> searchForCharacters;
  bool _isSearching = false;
  final _searchTextController = TextEditingController();
  var isLoaded = false;

  Widget _buildSearchField() {
    return TextField(
      controller: _searchTextController,
      cursorColor: MyColors.kGreyColor,
      decoration: const InputDecoration(
        hintText: "Find a characters ..",
        border: InputBorder.none,
        hintStyle: TextStyle(color: MyColors.kGreyColor, fontSize: 18),
        ),
      style: const TextStyle(color: MyColors.kGreyColor, fontSize: 18),
      onChanged: (searchedCharacter) {
        addSearchedForItemsToSearchedList(searchedCharacter);
      },
    );
  }

  void addSearchedForItemsToSearchedList(String searchedCharacter) {
    searchForCharacters = allCharacters
        .where((character) =>
            character.name.toLowerCase().startsWith(searchedCharacter))
        .toList();
    setState(() {});
  }

  List<Widget> _buildAppbarActions() {
    if (_isSearching) {
      return [
        IconButton(
            onPressed: () {
              _clearSearch();
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.clear,
              color: MyColors.kGreyColor,
            )),
      ];
    } else {
      return [
        IconButton(
          onPressed: _startSearch,
          icon: const Icon(
            Icons.search,
            color: MyColors.kGreyColor,
          ),
        ),
      ];
    }
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearch();
    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchTextController.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context).getAllCharacters();
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(builder: (ctx, state) {
      if (state is CharactersLoaded) {
        allCharacters = (state).characters;
        return buildLoadedListWidgets();
      } else {
        return showLoadingIndicator();
      }
    });
  }

  Widget showLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: MyColors.kYellowColor,
      ),
    );
  }

  Widget buildLoadedListWidgets() {
    return SingleChildScrollView(
      child: Container(
        color: MyColors.kGreyColor,
        child: Column(
          children: [
            buildCharactersList(),
          ],
        ),
      ),
    );
  }

  Widget buildCharactersList() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: _searchTextController.text.isEmpty
          ? allCharacters.length
          : searchForCharacters.length,
      itemBuilder: (ctx, index) {
        return CharacterItem(
          characterModel: _searchTextController.text.isEmpty
              ? allCharacters[index]
              : searchForCharacters[index],
        );
      },
    );
  }

  Widget _buildAppBarTitle() {
    return const Text(
      'Characters',
      style: TextStyle(color: MyColors.kGreyColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.kYellowColor,
        title: _isSearching ? _buildSearchField() : _buildAppBarTitle(),
        leading: _isSearching ? const BackButton(color: MyColors.kGreyColor,) : Container(),
        actions: _buildAppbarActions(),
      ),
      body: buildBlocWidget(),
    );
  }
}
