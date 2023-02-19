import 'package:first_app/gsheet_credentials.dart';
import 'package:flutter/material.dart';
import 'package:gsheets/gsheets.dart';

import 'home_page.dart';

void main() async {
  GoogleSheetsApi().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
