// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '/screens/prescribe_screen.dart';
import '/screens/login_screen.dart';

class ManageYourPatients extends StatelessWidget {
  final TextEditingController _primaryKey = TextEditingController();
  final TextEditingController _name = TextEditingController();

  Future login(BuildContext context) async {
    if (_primaryKey.text == '' || _name.text == '') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color.fromRGBO(76, 175, 80, 0.5),
          ),
          child: const Text(
            "Please fill up all the fields",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
            ),
          ),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        duration: const Duration(milliseconds: 1000),
      ));
    } else {
      try {
        String uri = "http://localhost/hospital_MS_api/login_doctor.php";

        var res = await http.post(Uri.parse(uri), body: {
          "doc_ssn": _primaryKey.text,
          "name": _name.text,
        });
        var response = json.decode(res.body);
        if (response == "success") {
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => PrescribeScreen(1, _primaryKey.text),
              transitionDuration: const Duration(seconds: 1),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(126, 175, 79, 76)),
              child: const Text(
                "Doctor SSN and Name combination doesn't exixt!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            elevation: 0,
            duration: const Duration(milliseconds: 1500),
          ));
        }
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: LoginScreen(
      id: 'Doctor SSN',
      idname: "Name",
      primaryKey: _primaryKey,
      name: _name,
      screenController: login,
    ));
  }
}
