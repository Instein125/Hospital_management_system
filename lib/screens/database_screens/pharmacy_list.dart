// ignore_for_file: unnecessary_this, non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '/screens/pharmacy_screen.dart';
import '/screens/database_screens/update_record_dialog.dart';

class PharmacyList extends StatefulWidget {
  const PharmacyList({Key? key}) : super(key: key);

  @override
  State<PharmacyList> createState() => _PharmacyListState();
}

class _PharmacyListState extends State<PharmacyList> {
  List pharmacysList = [];
  int? sortColumnIndex;
  bool isAscending = false;

  Future<void> deleteRecord(String id) async {
    String uri = "http://localhost/hospital_MS_api/delete_pharmacy.php";
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
    String uri = "http://localhost/hospital_MS_api/view_pharmacy_list.php";
    try {
      var response = await http.get(Uri.parse(uri));
      setState(() {
        pharmacysList = jsonDecode(response.body);
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateRecord(String primaryKey, List<Map> controllers) async {
    TextEditingController nameController = controllers[0]['Name :'];
    TextEditingController addressController = controllers[1]['Address :'];
    TextEditingController phnumberController = controllers[2]['Phone number :'];
    try {
      String uri = "http://localhost/hospital_MS_api/update_pharmacy.php";
      var res = await http.post(Uri.parse(uri), body: {
        "Phar_ID": primaryKey,
        "name": nameController.text,
        "address": addressController.text,
        "Ph_number": phnumberController.text,
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
        pageBuilder: (_, __, ___) => PharmacyScreen(3),
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
                "Pharmacy ID",
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
                "Phone number",
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
        rows: pharmacysList.map((e) => CreateDataRow(e)).toList(),
      ),
    ]);
  }

  void onSort(int columnIndex, bool ascending) {
    if (columnIndex == 1) {
      pharmacysList.sort((user1, user2) =>
          compareString(ascending, user1['Name'], user2['Name']));
    } else if (columnIndex == 0) {
      pharmacysList.sort((user1, user2) =>
          compareString(ascending, user1['Phar_ID'], user2['Phar_ID']));
    }
    setState(() {
      this.sortColumnIndex = columnIndex;
      this.isAscending = ascending;
    });
  }

  int compareString(bool ascending, String value1, String value2) =>
      ascending ? value1.compareTo(value2) : value2.compareTo(value1);

  DataRow CreateDataRow(pharmacy) {
    var nameController = TextEditingController();
    var addressController = TextEditingController();
    var phnumberController = TextEditingController();
    return DataRow(cells: [
      DataCell(Text(pharmacy["Phar_ID"])),
      DataCell(Text(pharmacy['Name'])),
      DataCell(Text(pharmacy['Address'])),
      DataCell(Text(pharmacy['Ph_number'])),
      DataCell(
        Row(
          children: [
            IconButton(
                onPressed: () {
                  nameController.text = pharmacy['Name'];
                  addressController.text = pharmacy['Address'];
                  phnumberController.text = pharmacy['Ph_number'];
                  updateRecordDialog(
                      context,
                      [
                        {"Name :": nameController},
                        {"Address :": addressController},
                        {"Phone number :": phnumberController},
                      ],
                      pharmacy['Phar_ID'],
                      updateRecord);
                },
                icon: const Icon(Icons.edit),
                hoverColor: const Color.fromRGBO(97, 230, 103, 0.498)),
            const SizedBox(
              width: 20,
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.sell,
                color: Colors.green,
              ),
              hoverColor: const Color.fromRGBO(97, 230, 103, 0.498),
            ),
            const SizedBox(
              width: 20,
            ),
            IconButton(
              onPressed: () {
                deleteRecord(pharmacy["Phar_ID"]);
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
