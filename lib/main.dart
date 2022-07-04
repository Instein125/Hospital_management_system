// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import '/screens/companies_screen.dart';
import '/screens/doctors_screen.dart';
import '/screens/drugs_screen.dart';
import '/screens/patients_screen.dart';
import '/screens/pharmacy_screen.dart';
import '/screens/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Hospital Management System",
      theme: ThemeData(
        primaryColor: const Color(0xff2DA95C),
        accentColor: const Color(0xff033B4A),
        disabledColor: Color.fromARGB(255, 99, 123, 130),
        //canvasColor: const Color(0xff9DABAF),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xff2DA95C),
        ),
        fontFamily: "OpenSans",
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MainScreen(0),
        // DoctorsScreen.routeName: (context) => DoctorsScreen(1),
        // PatientsScreen.routeName: (context) => PatientsScreen(2),
        // PharmacyScreen.routeName: (context) => PharmacyScreen(3),
        // CompaniesScreen.routeName: (context) => CompaniesScreen(4),
        // DrugsScreen.routeName: (context) => DrugsScreen(5),
      },
    );
  }
}
