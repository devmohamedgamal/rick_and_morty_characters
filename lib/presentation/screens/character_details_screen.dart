import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/business_logic/characters_cubit/characters_cubit.dart';
import 'package:rick_and_morty/data/models/character_location_model.dart';

import '../../constants/my_colors.dart';
import '../../data/models/character_model.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final CharacterModel character;
  const CharacterDetailsScreen({super.key, required this.character});

  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.kGreyColor,
      flexibleSpace: FlexibleSpaceBar(
        // centerTitle: true,
        title: Text(
          character.name,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        background: Hero(
          tag: character.id,
          child: Image.network(
            character.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget characterInfo({required String title, required String value}) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: "$title : ",
            style: const TextStyle(
              color: MyColors.kWhiteColor,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(
              color: MyColors.kWhiteColor,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDivider(double endindet) {
    return Divider(
      color: MyColors.kYellowColor,
      endIndent: endindet,
      height: 30,
      thickness: 2,
    );
  }

  Widget checkIfLocationIsLoaded(CharactersState state) {
    if (state is LocationLoaded) {
      return displyLocationOrEmptySpace(state);
    } else {
      return showProgressIndicator();
    }
  }

  Widget showProgressIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: MyColors.kYellowColor,
      ),
    );
  }

  Widget displyLocationOrEmptySpace(state) {
    var location = (state).location;
    if (location != null) {
      return Center(
        child: DefaultTextStyle(
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,
            color: MyColors.kWhiteColor,
            shadows: [
              Shadow(
                blurRadius: 7,
                color: MyColors.kYellowColor,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              WavyAnimatedText(location.name),
              WavyAnimatedText(location.type),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CharactersCubit>(context).getLocation("${character.id}");
    return Scaffold(
      backgroundColor: MyColors.kGreyColor,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      characterInfo(title: "Status", value: character.status),
                      buildDivider(200),
                      characterInfo(title: "Species", value: character.species),
                      buildDivider(220),
                      character.type == ""
                          ? Container()
                          : characterInfo(title: "Type", value: character.type),
                      character.type == "" ? Container() : buildDivider(100),
                      characterInfo(title: "Gender", value: character.gander),
                      buildDivider(250),
                      characterInfo(
                          title: "Origin", value: character.origin.name),
                      buildDivider(150),
                      characterInfo(
                          title: "Location", value: character.location.name),
                      buildDivider(50),
                      const SizedBox(
                        height: 30,
                      ),
                      BlocBuilder<CharactersCubit, CharactersState>(
                        builder: (context, state) {
                          return checkIfLocationIsLoaded(state); 
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
