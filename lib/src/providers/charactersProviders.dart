import 'dart:async';
import 'dart:convert';

import 'package:api_rickandmorty/src/domain/enums/status_characters.dart';
import 'package:api_rickandmorty/src/domain/models/characterRYM.dart';
import 'package:http/http.dart' as http;

class CharactersProviders {
  int _count = 0;
  final _streamController = StreamController<List<CharacterRYM>>.broadcast();

  Function(List<CharacterRYM>) get charactersSink => _streamController.sink.add;

  Stream<List<CharacterRYM>> get charactersStream => _streamController.stream;
  List<CharacterRYM> _character = [];

  bool _cargando = false;

  int cuenta = 0;
  final _busquedaEnum = StreamController<List<CharacterRYM>>.broadcast();
  Function(List<CharacterRYM>) get enumSink => _busquedaEnum.sink.add;
  Stream<List<CharacterRYM>> get enumStream => _busquedaEnum.stream;
  List<CharacterRYM> charactersEnum = [];
  void dispose() {
    _streamController.close();
    _busquedaEnum.close();
  }

  Future<List<CharacterRYM>> getCharacters() async {
    _count++;
    if (_cargando) return [];
    _cargando = true;

    try {
      final response = await http.get(
          Uri.parse('https://rickandmortyapi.com/api/character/?page=$_count'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        List<CharacterRYM> characters = [];
        (data['results'] as List).map((e) {
          final character = CharacterRYM.fromJson(e);
          characters.add(character);
        }).toList();
        _character.addAll(characters);
        charactersSink(_character);
        _cargando = false;
        return _character;
      } else {}
    } on Exception catch (e) {
      print(e);
    }
    return [];
  }

  Future<List<CharacterRYM>> getBuscados(String query) async {
    List<CharacterRYM> characters = [];
    final response = await http.get(
        Uri.parse('https://rickandmortyapi.com/api/character/?name=$query'));
    final data = json.decode(response.body);

    (data['results'] as List).map((e) {
      final character = CharacterRYM.fromJson(e);
      characters.add(character);
    }).toList();
    return characters;
  }

  Future<List<CharacterRYM>> getBusquedaEnum(Status status) async {
    cuenta++;
    List<CharacterRYM> characters = [];
    final response = await http.get(Uri.parse(
        'https://rickandmortyapi.com/api/character/?page=${cuenta}&status=${status.name}'));
    final data = json.decode(response.body);

    (data['results'] as List).map((e) {
      final characterEnum = CharacterRYM.fromJson(e);
      characters.add(characterEnum);
    }).toList();
    charactersEnum.addAll(characters);
    enumSink(charactersEnum);
    return characters;
  }
}
