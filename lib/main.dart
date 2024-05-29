import 'package:flutter/material.dart';
import 'package:flutter_app/pages/main_screen.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: const MainScreen(),
    ));
