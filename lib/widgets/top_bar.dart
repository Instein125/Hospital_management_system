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
  int doctorCount = 0;
  int patientCount = 0;
  int pharmacyCount = 0;

  Future<void> getDoctorCount() async {
    String uri = "http://localhost/hospital_MS_api/count_doctors.php";
    try {
      var response = await http.get(Uri.parse(uri));
      setState(() {
        List doctorsList = jsonDecode(response.body);

        doctorCount = int.parse(doctorsList[0]["0"]);
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> getPatientCount() async {
    String uri = "http://localhost/hospital_MS_api/count_patients.php";
    try {
      var response = await http.get(Uri.parse(uri));
      setState(() {
        List patientsList = jsonDecode(response.body);
        patientCount = int.parse(patientsList[0]["0"]);
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> getPharmacyCount() async {
    String uri = "http://localhost/hospital_MS_api/count_pharmacys.php";
    try {
      var response = await http.get(Uri.parse(uri));
      setState(() {
        List pharmacyList = jsonDecode(response.body);
        pharmacyCount = int.parse(pharmacyList[0]["0"]);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getDoctorCount();
    getPatientCount();
    getPharmacyCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: double.infinity,
      color: Theme.of(context).primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
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
                      "$doctorCount",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                const VerticalDivider(),
                Column(
                  children: [
                    const Text(
                      'Patients',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      "$patientCount",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                const VerticalDivider(),
                Column(
                  children: [
                    const Text(
                      'Pharmacy',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      "$pharmacyCount",
                      style: const TextStyle(color: Colors.white),
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
