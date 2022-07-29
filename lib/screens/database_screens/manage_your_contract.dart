// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '/screens/contract_sceen.dart';
import '/screens/login_screen.dart';

class ManageYourContracts extends StatelessWidget {
  final TextEditingController _primaryKey = TextEditingController();
  final TextEditingController _name = TextEditingController();

  Future login(BuildContext context) async {
    if (_primaryKey.text == '' || _name.text == '') {
      ScaffoldMessenger.of(context)
          .showSnackBar(errorMessage("Please fill all the fields!!"));
    } else {
      try {
        String uri = "http://localhost/hospital_MS_api/login_pharmacy.php";

        var res = await http.post(Uri.parse(uri), body: {
          "Phar_ID": _primaryKey.text,
          "name": _name.text,
        });
        var response = json.decode(res.body);
        if (response == "success") {
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => ContractScreen(3, _primaryKey.text),
              transitionDuration: const Duration(seconds: 1),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              errorMessage("Pharmacy ID and name combination doesn't exist!!"));
        }
      } catch (e) {
        print(e);
      }
    }
  }

  SnackBar errorMessage(String msg) {
    return SnackBar(
      content: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color.fromARGB(126, 175, 79, 76)),
        child: Text(
          msg,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 15,
          ),
        ),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
      duration: const Duration(milliseconds: 1500),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: LoginScreen(
      id: 'Pharmacy ID',
      idname: "Name",
      primaryKey: _primaryKey,
      name: _name,
      screenController: login,
    ));
  }
}
