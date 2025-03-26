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

          return ListView.builder(
            itemBuilder: (context, index) => SizedBox(
              height: 40,
              width: 40,
              child: Image.network(
                data[index].image,
              ),
            ),
            itemCount: data.length,
            scrollDirection: Axis.horizontal,
          );
        },
      ),
    );
  }
}
