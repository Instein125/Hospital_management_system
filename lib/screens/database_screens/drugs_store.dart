import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DrugsStore extends StatefulWidget {
  const DrugsStore({Key? key}) : super(key: key);

  @override
  State<DrugsStore> createState() => _DrugsStoreState();
}

class _DrugsStoreState extends State<DrugsStore> {
  List drugsList = [];
  int? sortColumnIndex;
  bool isAscending = false;

  Future<void> getRecord() async {
    String uri = "http://localhost/hospital_MS_api/store_list.php";
    try {
      var response = await http.get(Uri.parse(uri));
      setState(() {
        drugsList = jsonDecode(response.body);
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
                "Trade name",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              )),
          DataColumn(
              onSort: onSort,
              label: const Text(
                "Quantity",
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
    } else if (columnIndex == 1) {
      drugsList.sort((user1, user2) => compareInt(
          ascending,
          int.parse(user1['SUM(Quantity)']),
          int.parse(user2['SUM(Quantity)'])));
    }
    setState(() {
      this.sortColumnIndex = columnIndex;
      this.isAscending = ascending;
    });
  }

  int compareString(bool ascending, String value1, String value2) =>
      ascending ? value1.compareTo(value2) : value2.compareTo(value1);
  int compareInt(bool ascending, int value1, int value2) =>
      ascending ? value1.compareTo(value2) : value2.compareTo(value1);

  DataRow CreateDataRow(drug) {
    return DataRow(cells: [
      DataCell(Text(drug['Trade_name'])),
      DataCell(Text(drug['SUM(Quantity)'])),
    ]);
  }
}
