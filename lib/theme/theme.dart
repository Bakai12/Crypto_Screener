import 'package:flutter/material.dart';

final darkTheme = ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 34, 32, 32),
        primarySwatch: Colors.yellow,
        dividerColor: Colors.white60,
        appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 34, 32, 32),
        titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 22,
        fontWeight: FontWeight.w700,
        ),
        ),
        listTileTheme: const ListTileThemeData(
        iconColor: Colors.white),
        textTheme: const TextTheme(

          bodyMedium: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 20,
          ),

          labelSmall: TextStyle(
            color: Color.fromARGB(255, 50, 219, 55),
            fontWeight: FontWeight.w700,
            fontSize: 17,
          ),
        ),
      );