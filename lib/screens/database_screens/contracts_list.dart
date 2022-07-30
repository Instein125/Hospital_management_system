// ignore_for_file: non_constant_identifier_names, unnecessary_this, use_key_in_widget_constructors

import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../pharmacy_screen.dart';

class ContractsList extends StatefulWidget {
  final String pharID;
  const ContractsList(this.pharID);

  @override
  State<ContractsList> createState() => _ContractsListState();
}

class _ContractsListState extends State<ContractsList> {
  List contractsList = [];
  int? sortColumnIndex;
  bool isAscending = false;

  Future<void> getRecord() async {
    String uri = "http://localhost/hospital_MS_api/view_contract_list.php";
    try {
      var response = await http.post(Uri.parse(uri), body: {
        "Phar_ID": widget.pharID,
      });
      setState(() {
        contractsList = jsonDecode(response.body);
      });
    } catch (e) {
      print(e);
    }
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
                "Company Name",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              )),
          const DataColumn(
              label: Text(
            "Supervisor ID",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          )),
          const DataColumn(
              onSort: null,
              label: Text(
                "Start Date",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              )),
          const DataColumn(
              onSort: null,
              label: Text(
                "End Date",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              )),
        ],
        rows: contractsList.map((e) => CreateDataRow(e)).toList(),
      ),
      IconButton(
        onPressed: () {
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => PharmacyScreen(3),
              transitionDuration: const Duration(seconds: 0),
            ),
          );
        },
        icon: const Icon(
          Icons.logout,
          size: 32,
        ),
        color: Colors.red,
        hoverColor: Colors.red[200],
      ),
    ]);
  }

  void onSort(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      contractsList.sort((user1, user2) => compareString(
          ascending, user1['comapny_name'], user2['company_name']));
    }
    setState(() {
      this.sortColumnIndex = columnIndex;
      this.isAscending = ascending;
    });
  }

  int compareString(bool ascending, String value1, String value2) =>
      ascending ? value1.compareTo(value2) : value2.compareTo(value1);

  DataRow CreateDataRow(contract) {
    return DataRow(cells: [
      DataCell(Text(contract["Company_name"])),
      DataCell(Text(contract['supervisor_ID'])),
      DataCell(Text(contract['start_date'])),
      DataCell(Text(contract['end_date'])),
    ]);
  }
}
