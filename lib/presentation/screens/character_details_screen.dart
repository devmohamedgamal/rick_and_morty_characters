import 'package:flutter/material.dart';

import '../../contants/my_colors.dart';
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

  @override
  Widget build(BuildContext context) {
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
                        height: 20,
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
