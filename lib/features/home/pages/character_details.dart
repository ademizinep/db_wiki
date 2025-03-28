import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants.dart';
import '../../../datasources/remote_datasource.dart';
import '../model/character_model.dart';
import '../model/characters_list_model.dart';

class CharacterDetails extends StatefulWidget {
  final CharacterModel character;
  const CharacterDetails({
    super.key,
    required this.character,
  });

  @override
  State<CharacterDetails> createState() => _CharacterDetailsState();
}

class _CharacterDetailsState extends State<CharacterDetails> {
  final remote = RemoteDatasource();
  late Future<CharactersList?> characters;

  @override
  void initState() {
    characters = remote.getCharacters();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: kOrangeColor,
      body: ListView(
        children: [
          _buildCharacter(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.character.name.toUpperCase(),
                  style: GoogleFonts.knewave(
                    textStyle: const TextStyle(
                      color: kBlackColor,
                      fontSize: 36,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(widget.character.description),
                const SizedBox(height: 24),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 100 / 48,
                  children: [
                    _buildGridItems('Afiliação', widget.character.affiliation),
                    _buildGridItems('Gênero', widget.character.gender),
                    _buildGridItems('Ki', widget.character.ki),
                    _buildGridItems('Ki Máximo', widget.character.maxKi),
                    _buildGridItems('Raça', widget.character.race),
                  ],
                ),
                const SizedBox(height: 48),
              ],
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: kYellowColor,
      elevation: 0,
      scrolledUnderElevation: 0,
    );
  }

  Widget _buildGridItems(String title, String value) {
    return Container(
      decoration: BoxDecoration(
        color: kDarkOrangeColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kBlackColor),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.roboto(
              textStyle: const TextStyle(
                color: kBrownColor,
                fontSize: 12,
              ),
            ),
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              style: GoogleFonts.knewave(
                textStyle: const TextStyle(color: kBlackColor, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Stack _buildCharacter() {
    return Stack(
      children: [
        Image.asset('assets/ellipse.png'),
        Align(
          alignment: Alignment.bottomCenter,
          child: Hero(
            tag: 'character-image-${widget.character.name}',
            child: Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Image.network(
                widget.character.image,
                height: 385,
                width: 225,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
