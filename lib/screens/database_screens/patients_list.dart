import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '/screens/database_screens/update_record_dialog.dart';
import '/screens/patients_screen.dart';

class PatientsList extends StatefulWidget {
  const PatientsList({Key? key}) : super(key: key);

  @override
  State<PatientsList> createState() => _PatientsListState();
}

class _PatientsListState extends State<PatientsList> {
  List patientsList = [];
  int? sortColumnIndex;
  bool isAscending = false;

  Future<void> deleteRecord(String ssn) async {
    String uri = "http://localhost/hospital_MS_api/delete_patient.php";
    try {
      var res = await http.post(Uri.parse(uri), body: {'id': ssn});
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
    String uri = "http://localhost/hospital_MS_api/view_patient_list.php";
    try {
      var response = await http.get(Uri.parse(uri));
      setState(() {
        patientsList = jsonDecode(response.body);
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateRecord(String primaryKey, List<Map> controllers) async {
    TextEditingController nameController = controllers[0]['Name :'];
    TextEditingController addressController = controllers[1]['Address :'];
    TextEditingController ageController = controllers[2]['Age :'];
    try {
      String uri = "http://localhost/hospital_MS_api/update_patient.php";
      var res = await http.post(Uri.parse(uri), body: {
        "SSN": primaryKey,
        "name": nameController.text,
        "address": addressController.text,
        "age": ageController.text,
      });
      var response = jsonDecode(res.body);
      if (response["success"] == "true") {
        print("Updated");
      } else {
        print("some issues");
      }
    } catch (e) {
      print(e);
    }
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => PatientsScreen(2),
        transitionDuration: const Duration(seconds: 0),
      ),
    );
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
                "Patient_SSN",
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
                "Address",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              )),
          const DataColumn(
              onSort: null,
              label: Text(
                "Age",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              )),
          const DataColumn(
              onSort: null,
              label: Text(
                "Appointed to",
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
        rows: patientsList.map((e) => CreateDataRow(e)).toList(),
      ),
    ]);
  }

  void onSort(int columnIndex, bool ascending) {
    if (columnIndex == 1) {
      patientsList.sort((user1, user2) =>
          compareString(ascending, user1['Name'], user2['Name']));
    } else if (columnIndex == 0) {
      patientsList.sort((user1, user2) =>
          compareString(ascending, user1['SSN'], user2['SSN']));
    }
    setState(() {
      this.sortColumnIndex = columnIndex;
      this.isAscending = ascending;
    });
  }

  int compareString(bool ascending, String value1, String value2) =>
      ascending ? value1.compareTo(value2) : value2.compareTo(value1);

  DataRow CreateDataRow(patient) {
    var nameController = TextEditingController();
    var addressController = TextEditingController();
    var ageController = TextEditingController();
    return DataRow(cells: [
      DataCell(Text(patient["SSN"])),
      DataCell(Text(patient['Name'])),
      DataCell(Text(patient['Address'])),
      DataCell(Text(patient['Age'])),
      DataCell(Text(patient['Doc_SSN'])),
      DataCell(
        Row(
          children: [
            IconButton(
                onPressed: () {
                  nameController.text = patient['Name'];
                  addressController.text = patient['Address'];
                  ageController.text = patient['Age'];
                  updateRecordDialog(
                      context,
                      [
                        {"Name :": nameController},
                        {"Address :": addressController},
                        {"Age :": ageController},
                      ],
                      patient['SSN'],
                      updateRecord);
                },
                icon: const Icon(Icons.edit),
                hoverColor: const Color.fromRGBO(97, 230, 103, 0.498)),
            const SizedBox(
              width: 40,
            ),
            IconButton(
              onPressed: () {
                deleteRecord(patient["SSN"]);
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
