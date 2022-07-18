import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '/screens/database_screens/update_record_dialog.dart';
import '/screens/supervisors_screen.dart';

class SupervisorsList extends StatefulWidget {
  const SupervisorsList({Key? key}) : super(key: key);

  @override
  State<SupervisorsList> createState() => _SupervisorsListState();
}

class _SupervisorsListState extends State<SupervisorsList> {
  List supervisorsList = [];
  int? sortColumnIndex;
  bool isAscending = false;

  Future<void> deleteRecord(String id) async {
    String uri = "http://localhost/hospital_MS_api/delete_supervisor.php";
    try {
      var res = await http.post(Uri.parse(uri), body: {'id': id});
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
    String uri = "http://localhost/hospital_MS_api/view_supervisor_list.php";
    try {
      var response = await http.get(Uri.parse(uri));
      setState(() {
        supervisorsList = jsonDecode(response.body);
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateRecord(String primaryKey, List<Map> controllers) async {
    TextEditingController nameController = controllers[0]['Name :'];
    TextEditingController addressController = controllers[1]['Address :'];
    try {
      String uri = "http://localhost/hospital_MS_api/update_supervisor.php";
      var res = await http.post(Uri.parse(uri), body: {
        "Supervisor_ID": primaryKey,
        "name": nameController.text,
        "address": addressController.text,
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
        pageBuilder: (_, __, ___) => SupervisorScreen(6),
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
                "Supervisor ID",
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
                "Options",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              )),
        ],
        rows: supervisorsList.map((e) => CreateDataRow(e)).toList(),
      ),
    ]);
  }

  void onSort(int columnIndex, bool ascending) {
    if (columnIndex == 1) {
      supervisorsList.sort((user1, user2) =>
          compareString(ascending, user1['Name'], user2['Name']));
    } else if (columnIndex == 0) {
      supervisorsList.sort((user1, user2) => compareString(
          ascending, user1['supervisor_ID'], user2['supervisor_ID']));
    }
    setState(() {
      this.sortColumnIndex = columnIndex;
      this.isAscending = ascending;
    });
  }

  int compareString(bool ascending, String value1, String value2) =>
      ascending ? value1.compareTo(value2) : value2.compareTo(value1);

  DataRow CreateDataRow(supervisor) {
    var nameController = TextEditingController();
    var addressController = TextEditingController();
    return DataRow(cells: [
      DataCell(Text(supervisor["supervisor_ID"])),
      DataCell(Text(supervisor['Name'])),
      DataCell(Text(supervisor['Address'])),
      DataCell(
        Row(
          children: [
            IconButton(
                onPressed: () {
                  nameController.text = supervisor['Name'];
                  addressController.text = supervisor['Address'];
                  updateRecordDialog(
                      context,
                      [
                        {"Name :": nameController},
                        {"Address :": addressController},
                      ],
                      supervisor['supervisor_ID'],
                      updateRecord);
                },
                icon: const Icon(Icons.edit),
                hoverColor: const Color.fromRGBO(97, 230, 103, 0.498)),
            const SizedBox(
              width: 40,
            ),
            IconButton(
              onPressed: () {
                deleteRecord(supervisor["supervisor_ID"]);
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
