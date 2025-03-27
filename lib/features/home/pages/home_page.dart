import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../datasources/remote_datasource.dart';
import '../../../widgets/character_card.dart';
import '../../../widgets/character_item.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/horizontal_divider.dart';
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
      appBar: const CustomAppBar(),
      body: FutureBuilder(
        future: characters,
        builder: (context, snapshot) {
          final List<CharacterModel> data = snapshot.data?.characters ?? [];
          final mainCharacter = data.take(6).toList();
          final otherCharacter = data.skip(6).toList();

          return Visibility(
            visible: data.isNotEmpty,
            replacement: _loading(),
            child: Column(
              children: [
                SizedBox(
                  height: 400,
                  width: double.infinity,
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(width: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                    itemCount: mainCharacter.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => CharacterCard(data: mainCharacter[index]),
                  ),
                ),
                const HorizontalDivider(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                          child: Text(
                            '${otherCharacter.length.toString()} personagens',
                            style: GoogleFonts.roboto(textStyle: const TextStyle(color: Color(0xFF864300), fontSize: 12)),
                          ),
                        ),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          separatorBuilder: (context, index) => const SizedBox(height: 8),
                          itemBuilder: (context, index) {
                            return CharacterItem(data: otherCharacter[index]);
                          },
                          itemCount: otherCharacter.length,
                        ),
                        const SizedBox(height: 48),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Center _loading() {
    return const Center(
      child: SizedBox(
        width: 200,
        child: LinearProgressIndicator(
          color: Color(0xFF864300),
          backgroundColor: Color(0xFFFFC386),
        ),
      ),
    );
  }
}
