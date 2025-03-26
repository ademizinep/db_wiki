import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../datasources/remote_datasource.dart';
import '../model/character_model.dart';
import '../model/characters_list_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(124),
        child: Container(
          padding: const EdgeInsets.only(left: 24),
          width: double.infinity,
          height: 124,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Image.asset('assets/img/db_logo.png'),
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
      ),
      body: FutureBuilder(
        future: characters,
        builder: (context, snapshot) {
          final List<Character> data = snapshot.data?.characters ?? [];

          return SizedBox(
            height: 400,
            width: double.infinity,
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(width: 8),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              itemBuilder: (context, index) {
                return Stack(
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
                              data[index].name.toUpperCase(),
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
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Image.network(
                        data[index].image,
                        height: 385,
                        width: 225,
                      ),
                    ),
                  ],
                );
              },
              itemCount: data.length,
              scrollDirection: Axis.horizontal,
            ),
          );
        },
      ),
    );
  }
}
