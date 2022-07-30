// ignore_for_file: use_build_context_synchronously, unnecessary_this, non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hospital_system/screens/drugs_screen.dart';
import 'package:http/http.dart' as http;

import 'update_record_dialog.dart';

class DrugsList extends StatefulWidget {
  const DrugsList({Key? key}) : super(key: key);

  @override
  State<DrugsList> createState() => _DrugsListState();
}

class _DrugsListState extends State<DrugsList> {
  List drugsList = [];
  int? sortColumnIndex;
  bool isAscending = false;

  Future<void> deleteRecord(String id) async {
    String uri = "http://localhost/hospital_MS_api/delete_drug.php";
    try {
      var res = await http.post(Uri.parse(uri), body: {'id': id});
      var response = jsonDecode(res.body);
      if (response['success'] == 'true') {
        getRecord();
      } else {}
    } catch (e) {
      print(e);
    }
  }

  Future<void> getRecord() async {
    String uri = "http://localhost/hospital_MS_api/view_drug_list.php";
    try {
      var response = await http.get(Uri.parse(uri));
      setState(() {
        drugsList = jsonDecode(response.body);
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateRecord(String primaryKey, List<Map> controllers) async {
    TextEditingController tradenameController = controllers[0]['Trade name :'];
    TextEditingController formulaController = controllers[1]['Formula :'];

    try {
      String uri = "http://localhost/hospital_MS_api/update_drug.php";
      await http.post(Uri.parse(uri), body: {
        "Trade_name": tradenameController.text,
        "Formula": formulaController.text,
        "oldName": primaryKey,
      });
    } catch (e) {
      print(e);
    }
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => DrugsScreen(5),
        transitionDuration: const Duration(seconds: 0),
      ),
    );
  }

  @override
  void initState() {
    getRecord();
    super.initState();
  }

  @override
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
                "Trade name",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              )),
          const DataColumn(
              onSort: null,
              label: Text(
                "Formula",
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
        rows: drugsList.map((e) => CreateDataRow(e)).toList(),
      ),
    ]);
  }

  void onSort(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      drugsList.sort((user1, user2) =>
          compareString(ascending, user1['Trade_name'], user2['Trade_name']));
    }
    setState(() {
      this.sortColumnIndex = columnIndex;
      this.isAscending = ascending;
    });
  }

  int compareString(bool ascending, String value1, String value2) =>
      ascending ? value1.compareTo(value2) : value2.compareTo(value1);

  DataRow CreateDataRow(drug) {
    var tradenameController = TextEditingController();
    var formulaController = TextEditingController();

    return DataRow(cells: [
      DataCell(Text(drug['Trade_name'])),
      DataCell(Text(drug['Formula'])),
      DataCell(
        Row(
          children: [
            IconButton(
                onPressed: () {
                  tradenameController.text = drug['Trade_name'];
                  formulaController.text = drug['Formula'];

                  updateRecordDialog(
                      context,
                      [
                        {"Trade name :": tradenameController},
                        {"Formula :": formulaController},
                      ],
                      drug['Trade_name'],
                      updateRecord);
                },
                icon: const Icon(Icons.edit),
                hoverColor: const Color.fromRGBO(97, 230, 103, 0.498)),
            const SizedBox(
              width: 40,
            ),
            IconButton(
              onPressed: () {
                deleteRecord(drug["Trade_name"]);
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
