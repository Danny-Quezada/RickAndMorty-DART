
import 'package:flutter/material.dart';

import 'package:api_rickandmorty/src/domain/models/characterRYM.dart';
import 'package:api_rickandmorty/src/widgets/contain_characters_widget.dart';


class ListviewCharacters extends StatelessWidget {
  
  final _controller=ScrollController();


  List<CharacterRYM> characters;
  final Function next;
  ListviewCharacters(this.characters,this.next);

  @override
  Widget build(BuildContext context) {
    _controller.addListener(() {
      if(_controller.position.pixels>=(_controller.position.maxScrollExtent-200))
      {
        next();
      }
    });
    return Scrollbar(
      child: ListView.builder(
        controller: _controller,
        itemCount: characters.length,
        itemBuilder: (BuildContext context, int index) {
          return containWidget(characters[index]);
        },
      ),
    );
  }
}