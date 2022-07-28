// ignore_for_file: deprecated_member_use, non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class PrescribeList extends StatefulWidget {
  final String docSSN;

  PrescribeList(this.docSSN);

  @override
  State<PrescribeList> createState() => _PrescribeListState();
}

class _PrescribeListState extends State<PrescribeList> {
  late List tradeNames = [];
  List patientsList = [];
  int? sortColumnIndex;

  bool isAscending = false;
  static int decision = 0;

  Future<void> getRecord() async {
    String uri = "http://localhost/hospital_MS_api/prescribe.php";
    try {
      var response =
          await http.post(Uri.parse(uri), body: {"Doc_SSN": widget.docSSN});
      setState(() {
        patientsList = jsonDecode(response.body);
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> prescribeRecord(
      {String? ssn,
      String? doc_ssn,
      String? trade_name,
      String? quantity,
      String? date}) async {
    try {
      String uri = "http://localhost/hospital_MS_api/update_prescribe.php";
      var res = await http.post(Uri.parse(uri), body: {
        "SSN": ssn,
        "Doc_SSN": doc_ssn,
        "Trade_name": trade_name,
        "Prescribe_date": date,
        "Quantity": quantity,
      });
      var response = jsonDecode(res.body);
      if (response["success"] == "true") {
        print("Updated");
      } else {
        print("some issues");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color.fromARGB(126, 175, 79, 76)),
          child: const Text(
            "Drug is not available currently!!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
            ),
          ),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        duration: const Duration(milliseconds: 1500),
      ));
    }
    setState(() {
      getRecord();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
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
        columns: const [
          DataColumn(
              label: Text(
            "Patient SSN",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          )),
          DataColumn(
              label: Text(
            "Select Drug",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          )),
          DataColumn(
              onSort: null,
              label: Text(
                "Quantity",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              )),
          DataColumn(
              onSort: null,
              label: Text(
                "Prescribed Date",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              )),
          DataColumn(
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
        rows: patientsList.map((e) {
          return CreateDataRow(e);
        }).toList(),
      ),
    ]);
  }

  DataRow CreateDataRow(patient) {
    TextEditingController quantityController = TextEditingController();
    TextEditingController drugController = TextEditingController();

    quantityController.text = patient['Quantity'] ?? "";
    drugController.text = patient['Trade_name'] ?? "";
    return DataRow(cells: [
      DataCell(Text(patient["SSN"])),
      DataCell(
        TextField(
          controller: drugController,
          textAlign: TextAlign.left,
          decoration: const InputDecoration(isDense: true),
        ),
      ),
      DataCell(
        TextField(
          controller: quantityController,
          textAlign: TextAlign.left,
          decoration: const InputDecoration(isDense: true),
        ),
      ),
      patient['Prescribe_date'] == null
          ? const DataCell(Text(""))
          : DataCell(Text(patient["Prescribe_date"])),
      DataCell(
        Row(
          children: [
            RaisedButton(
              onPressed: () {
                var now = DateTime.now();
                var formatter = DateFormat('yyyy-MM-dd');
                String todayDate = formatter.format(now);

                prescribeRecord(
                    ssn: patient['SSN'],
                    doc_ssn: widget.docSSN,
                    quantity: quantityController.text,
                    trade_name: drugController.text,
                    date: todayDate);
              },
              color: Colors.green,
              child: const Text(
                "Prescribe",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
          ],
        ),
      )
    ]);
  }
}
