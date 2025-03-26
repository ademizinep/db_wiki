import 'package:flutter/material.dart';

import '../../../datasources/remote_datasource.dart';
import '../model/character_model.dart';
import '../model/characters_list_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

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
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: characters,
        builder: (context, snapshot) {
          final List<Character> data = snapshot.data?.characters ?? [];

          return Container(
            height: 200,
            color: Colors.red,
            width: double.infinity,
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                final color = colors[index % colors.length];

                return Stack(
                  children: [
                    Container(
                      width: 110,
                      height: 145,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(data[index].name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          )),
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
              itemCount: data.length,
              scrollDirection: Axis.horizontal,
            ),
          );
        },
      ),
    );
  }
}
