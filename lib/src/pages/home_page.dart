import 'package:flutter/material.dart';
import 'dart:async';
import 'package:api_rickandmorty/src/domain/models/characterRYM.dart';
import 'package:api_rickandmorty/src/providers/charactersProviders.dart';
import 'package:api_rickandmorty/src/search/search_delegate.dart';
import 'package:api_rickandmorty/src/widgets/listview_characters.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  
  final providers = CharactersProviders();
  bool? verificar;
  int i=0;
  int incrementar=10;
  @override
  Widget build(BuildContext context) {
    
    providers.getCharacters();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        actions: [
          IconButton(onPressed: () {
            showSearch(context: context, delegate: DataSearch());
          }, icon: const Icon(Icons.search)),
        ],
      ),
      body: _listview(),
    );
  }

  Widget _listview() {
    return StreamBuilder(
      stream: providers.charactersStream,
      builder: (BuildContext context, AsyncSnapshot<List<CharacterRYM>> snapshot) {
        verificar=snapshot.hasData;
        if (snapshot.hasData) {
          return ListviewCharacters(snapshot.data!,providers.getCharacters);
        }
        else if(snapshot.connectionState==ConnectionState.waiting){
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        }
        return Container();
      },
    );
  }
}
