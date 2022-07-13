// ignore_for_file: use_key_in_widget_constructors
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../screens/main_screen.dart';

class TopBar extends StatefulWidget {
  final String title;
  const TopBar(this.title);

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  List doctorsList = [];

  Future<void> getRecord() async {
    String uri = "http://localhost/hospital_MS_api/view_doctor_list.php";
    try {
      var response = await http.get(Uri.parse(uri));
      setState(() {
        doctorsList = jsonDecode(response.body);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getRecord();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: double.infinity,
      color: Theme.of(context).primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              widget.title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.white),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(15),
            alignment: Alignment.center,
            child: Row(
              children: [
                Column(
                  children: [
                    const Text(
                      'Doctors',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "${doctorsList.length}",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                const VerticalDivider(),
                Column(
                  children: const [
                    Text(
                      'Patients',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      '15',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                const VerticalDivider(),
                Column(
                  children: const [
                    Text(
                      'Pharmacy',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      '15',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                const VerticalDivider(),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) => const MainScreen(0),
                          transitionDuration: const Duration(seconds: 0),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.refresh,
                      color: Colors.white,
                      size: 30,
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
