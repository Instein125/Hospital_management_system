// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  String id;
  String idname;
  TextEditingController primaryKey = TextEditingController();
  TextEditingController name = TextEditingController();
  Function screenController;
  LoginScreen(
      {required this.id,
      required this.idname,
      required this.primaryKey,
      required this.name,
      required this.screenController});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 200, left: 400, right: 400),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: TextField(
                controller: primaryKey,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: id,
                ),
                style: const TextStyle(height: 0.5)),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: TextField(
                controller: name,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: idname,
                ),
                style: const TextStyle(height: 0.5)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(0,
                              60)), //El ancho de deja en 0 porque el "expanded" lo define.
                      onPressed: () {
                        screenController(context);
                      },
                      child: const Text("Log In",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold))),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
