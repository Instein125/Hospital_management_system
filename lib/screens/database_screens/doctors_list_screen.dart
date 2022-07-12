import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '/screens/database_screens/update_record.dart';

class DoctorsList extends StatefulWidget {
  const DoctorsList({Key? key}) : super(key: key);

  @override
  State<DoctorsList> createState() => _DoctorsListState();
}

class _DoctorsListState extends State<DoctorsList> {
  List doctorsList = [];
  int? sortColumnIndex;
  bool isAscending = false;

  Future<void> deleteRecord(String doc_ssn) async {
    String uri = "http://localhost/hospital_MS_api/delete_doctor.php";
    try {
      var res = await http.post(Uri.parse(uri), body: {'id': doc_ssn});
      var response = jsonDecode(res.body);
      if (response['success'] == 'true') {
        print("Record deleted");
        getRecord();
      } else {
        print("Not deleted");
      }
    } catch (e) {
      print(e);
    }
  }

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
    return ListView(controller: ScrollController(), children: [
      DataTable(
        border: TableBorder(
            horizontalInside:
                BorderSide(color: Theme.of(context).primaryColor)),
        sortColumnIndex: sortColumnIndex,
        sortAscending: isAscending,
        columns: [
          DataColumn(
              onSort: onSort,
              label: const Text(
                "Doctor_SSN",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              )),
          DataColumn(
              onSort: onSort,
              label: const Text(
                "Name",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              )),
          const DataColumn(
              onSort: null,
              label: Text(
                "Speciality",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              )),
          const DataColumn(
              onSort: null,
              label: Text(
                "Experience(in years)",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              )),
          const DataColumn(
              onSort: null,
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

  void onSort(int columnIndex, bool ascending) {
    if (columnIndex == 1) {
      doctorsList.sort((user1, user2) =>
          compareString(ascending, user1['Name'], user2['Name']));
    } else if (columnIndex == 0) {
      doctorsList.sort((user1, user2) =>
          compareString(ascending, user1['Doc_SSN'], user2['Doc_SSN']));
    }
    setState(() {
      this.sortColumnIndex = columnIndex;
      this.isAscending = ascending;
    });
  }

  int compareString(bool ascending, String value1, String value2) =>
      ascending ? value1.compareTo(value2) : value2.compareTo(value1);

  DataRow CreateDataRow(doctor) {
    var nameController = TextEditingController();
    var specialityController = TextEditingController();
    var experienceController = TextEditingController();
    return DataRow(cells: [
      DataCell(Text(doctor["Doc_SSN"])),
      DataCell(Text(doctor['Name'])),
      DataCell(Text(doctor['Speciality'])),
      DataCell(Text(doctor['Experience'])),
      DataCell(
        Row(
          children: [
            IconButton(
                onPressed: () {
                  updateRecord(context, [
                    {"Name :": nameController},
                    {"Speciality :": specialityController},
                    {"Experience :": experienceController},
                  ], [
                    doctor['Name'],
                    doctor['Speciality'],
                    doctor['Experience']
                  ]);
                },
                icon: const Icon(Icons.edit),
                hoverColor: const Color.fromRGBO(97, 230, 103, 0.498)),
            const SizedBox(
              width: 40,
            ),
            IconButton(
              onPressed: () {
                deleteRecord(doctor["Doc_SSN"]);
              },
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
