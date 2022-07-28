// ignore_for_file: unnecessary_this, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '/screens/companies_screen.dart';
import 'update_record_dialog.dart';

class CompaniesList extends StatefulWidget {
  const CompaniesList({Key? key}) : super(key: key);

  @override
  State<CompaniesList> createState() => _CompaniesListState();
}

class _CompaniesListState extends State<CompaniesList> {
  List companiesList = [];
  int? sortColumnIndex;
  bool isAscending = false;

  Future<void> deleteRecord(String id) async {
    String uri = "http://localhost/hospital_MS_api/delete_company.php";
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
    String uri = "http://localhost/hospital_MS_api/view_company_list.php";
    try {
      var response = await http.get(Uri.parse(uri));
      setState(() {
        companiesList = jsonDecode(response.body);
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateRecord(String primaryKey, List<Map> controllers) async {
    TextEditingController nameController = controllers[0]['Company name :'];
    TextEditingController phnumberController = controllers[1]['Phone number :'];

    try {
      String uri = "http://localhost/hospital_MS_api/update_company.php";
      var res = await http.post(Uri.parse(uri), body: {
        "name": nameController.text,
        "Ph_number": phnumberController.text,
        "oldName": primaryKey,
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
        pageBuilder: (_, __, ___) => CompaniesScreen(4),
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
                "Company name",
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
        rows: companiesList.map((e) => CreateDataRow(e)).toList(),
      ),
    ]);
  }

  void onSort(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      companiesList.sort((user1, user2) => compareString(
          ascending, user1['Company_name'], user2['Company_name']));
    }
    setState(() {
      this.sortColumnIndex = columnIndex;
      this.isAscending = ascending;
    });
  }

  int compareString(bool ascending, String value1, String value2) =>
      ascending ? value1.compareTo(value2) : value2.compareTo(value1);

  DataRow CreateDataRow(company) {
    var nameController = TextEditingController();
    var phnumberController = TextEditingController();

    return DataRow(cells: [
      DataCell(Text(company['Company_name'])),
      DataCell(Text(company['Ph_number'])),
      DataCell(
        Row(
          children: [
            IconButton(
                onPressed: () {
                  nameController.text = company['Company_name'];
                  phnumberController.text = company['Ph_number'];

                  updateRecordDialog(
                      context,
                      [
                        {"Company name :": nameController},
                        {"Phone number :": phnumberController},
                      ],
                      company['Company_name'],
                      updateRecord);
                },
                icon: const Icon(Icons.edit),
                hoverColor: const Color.fromRGBO(97, 230, 103, 0.498)),
            const SizedBox(
              width: 40,
            ),
            IconButton(
              onPressed: () {
                deleteRecord(company["Company_name"]);
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
