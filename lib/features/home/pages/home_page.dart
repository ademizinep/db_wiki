import 'package:flutter/material.dart';

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

  final List<Color> colors = [
    Color(0xFF1ABC9C),
    Color(0xFF2ECC71),
    Color(0xFF3498DB),
    Color(0xFF9B59B6),
    Color(0xFFF1C40F),
    Color(0xFFE67E22),
    Color(0xFFE74C3C),
    Color(0xFF34495E),
    Color(0xFF16A085),
    Color(0xFF27AE60),
    Color(0xFF2980B9),
    Color(0xFF8E44AD),
    Color(0xFFF39C12),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Dragon Ball"),
      ),
      body: FutureBuilder(
        future: characters,
        builder: (context, snapshot) {
          final List<Character> data = snapshot.data?.characters ?? [];

          return Visibility(
            visible: data.isNotEmpty,
            child: Column(
              children: [
                SizedBox(
                  height: 180,
                  width: double.infinity,
                  child: ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => const SizedBox(width: 10),
                    itemBuilder: (context, index) {
                      final color = colors[index % colors.length];

                      return Stack(
                        children: [
                          Container(
                            width: 110,
                            height: 145,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: color,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: RotatedBox(
                              quarterTurns: 3,
                              child: Text(
                                data[index].name,
                                textDirection: TextDirection.rtl,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 40,
                            left: 10,
                            child: Image.network(
                              data[index].image,
                              width: 140,
                              height: 140,
                            ),
                          ),
                        ],
                      );
                    },
                    itemCount: 10,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data[index].name,
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text("Ki: ${data[index].ki}"),
                              Text("Raça: ${data[index].race}"),
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: data.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 10),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
