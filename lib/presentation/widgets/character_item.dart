import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty/data/models/character_model.dart';

import '../../constants/my_colors.dart';
import '../../constants/strings.dart';

class CharacterItem extends StatelessWidget {
  final CharacterModel characterModel;
  const CharacterItem({required this.characterModel, super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: const EdgeInsetsDirectional.all(4),
      decoration: BoxDecoration(
        color: MyColors.kWhiteColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, characterDetailsScreen,arguments:characterModel);
        },
        child: GridTile(
          footer: Hero(
            tag: characterModel.id,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              color: Colors.black54,
              alignment: Alignment.bottomCenter,
              child: Text(
                characterModel.name,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.3,
                  color: MyColors.kWhiteColor,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          child: Container(
            color: MyColors.kGreyColor,
            child: characterModel.image.isNotEmpty
                ? FadeInImage.assetNetwork(
                    width: double.infinity,
                    height: double.infinity,
                    placeholder: "assets/images/loading.gif",
                    image: characterModel.image,
                    fit: BoxFit.cover,
                  )
                : Image.asset('assets/images/error.gif'),
          ),
        ),
      ),
    );
  }
}
