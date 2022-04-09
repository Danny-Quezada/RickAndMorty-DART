
import 'package:api_rickandmorty/src/domain/enums/status_characters.dart';
import 'package:flutter/material.dart';

import 'package:api_rickandmorty/src/domain/models/characterRYM.dart';
import 'package:api_rickandmorty/src/providers/charactersProviders.dart';

class DataSearch extends SearchDelegate {
  final providers=CharactersProviders();
     int _seleccionado=-1;
  @override
  List<Widget>? buildActions(BuildContext context) {
 
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.delete)),
      PopupMenuButton<int>(
          itemBuilder: (context) => [
                const PopupMenuItem<int>(
                  child: Text("Alive"),
                  value: 0,
                ),
                const PopupMenuItem<int>(
                  child: Text("dead"),
                  value: 1,
                ),
                const PopupMenuItem<int>(
                  child: Text("Unknown"),
                  value: 2,
                ),
              ],
              onSelected: (value) {
                  _seleccionado=value;
                  buildSuggestions(context);
                
              }),
          
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions

    if(query.isEmpty){
     
     if(_seleccionado>-1)
     {
    
       return FutureBuilder(
         future:providers.getBusquedaEnum(Status.values[_seleccionado]),
         builder: (BuildContext context, AsyncSnapshot<List<CharacterRYM>> snapshot) {
          if(snapshot.hasData){
             return _listview(snapshot);
          }
          else{
            return const Center(child: CircularProgressIndicator(),);
          }
         },

       );
     }
     else{
       return Container();
     }
    } 
    else {
    return FutureBuilder(
        future: CharactersProviders().getBuscados(query),
        builder:
            (BuildContext context, AsyncSnapshot<List<CharacterRYM>> snapshot) {
          if (snapshot.hasData) {
            return _listview(snapshot);
          }
          return Container();
        },
      );
    }
  }

  ListView _listview(AsyncSnapshot<List<CharacterRYM>> snapshot) {
    return ListView.builder(
      itemCount: snapshot.data!.length,
      itemBuilder: (BuildContext context, int index) {
        final character = snapshot.data![index];
        return _contenido(character);
      },
    );
  }

  ListTile _contenido(CharacterRYM character) {
    return ListTile(
      leading: FadeInImage(
        image: NetworkImage('${character.image}'),
        placeholder: const AssetImage('assets/jar-loading.gif'),
        alignment: Alignment.center,
        fit: BoxFit.fill,
        fadeInDuration: const Duration(milliseconds: 200),
      ),
      title: Text('${character.name}'),
      subtitle: Text('${character.status}'),
    );
  }
}
