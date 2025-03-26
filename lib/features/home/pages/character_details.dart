import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      backgroundColor: const Color(0xFFE98E03),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE98E03),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/img/db.png',
              height: 60,
              width: 60,
            ),
            const SizedBox(width: 8),
            Text(
              'Wiki',
              style: GoogleFonts.knewave(
                textStyle: const TextStyle(color: Colors.black, fontSize: 32),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Container(
                    width: 225,
                    height: 300,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFCA07),
                      borderRadius: BorderRadius.circular(36),
                      border: Border.all(color: Colors.black),
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 32),
                        child: RotatedBox(
                          quarterTurns: -1,
                          child: Text(
                            widget.character.name.toUpperCase(),
                            style: GoogleFonts.knewave(
                              textStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Image.network(
                      widget.character.image,
                      height: 385,
                      width: 225,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Card(
                color: const Color(0xFFFFCA07),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(widget.character.description),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
