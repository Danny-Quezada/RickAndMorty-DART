import 'package:api_rickandmorty/src/pages/home_page.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (_)=>HomePage()
    },
  ));
}