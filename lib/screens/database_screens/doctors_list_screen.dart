import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DoctorsList extends StatefulWidget {
  const DoctorsList({Key? key}) : super(key: key);

  @override
  State<DoctorsList> createState() => _DoctorsListState();
}

class _DoctorsListState extends State<DoctorsList> {
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
    print("I am doctor list");
  }

  Widget build(BuildContext context) {
    return ListView(controller: ScrollController(), children: [
      DataTable(
        border: TableBorder(
            horizontalInside:
                BorderSide(color: Theme.of(context).primaryColor)),
        columns: const [
          DataColumn(
              label: Text(
            "Doctor_SSN",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          )),
          DataColumn(
              label: Text(
            "Name",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          )),
          DataColumn(
              label: Text(
            "Speciality",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          )),
          DataColumn(
              label: Text(
            "Experience(in years)",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          )),
          DataColumn(
              label: Text(
            "Options",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          )),
        ],
        rows: doctorsList.map((e) => CreateDataRow(e)).toList(),
      ),
    ]);
  }

  DataRow CreateDataRow(doctor) {
    return DataRow(cells: [
      DataCell(Text(doctor["Doc_SSN"])),
      DataCell(Text(doctor['Name'])),
      DataCell(Text(doctor['Speciality'])),
      DataCell(Text(doctor['Experience'])),
      DataCell(
        Row(
          children: [
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.edit),
                hoverColor: const Color.fromRGBO(97, 230, 103, 0.498)),
            SizedBox(
              width: 40,
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
              hoverColor: const Color.fromRGBO(244, 67, 54, 0.5),
            ),
          ],
        ),
      )
    ]);
  }
}
