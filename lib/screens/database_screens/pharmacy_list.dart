// ignore_for_file: unnecessary_this, non_constant_identifier_names, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '/screens/database_screens/sell_drug_dialog.dart';
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
        getRecord();
      } else {}
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
      await http.post(Uri.parse(uri), body: {
        "Phar_ID": primaryKey,
        "name": nameController.text,
        "address": addressController.text,
        "Ph_number": phnumberController.text,
      });
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

  Future<void> sellDrug(String primaryKey, List<Map> controllers) async {
    TextEditingController drugController = controllers[0]['Drug name :'];
    TextEditingController priceController = controllers[1]['Price(in NRs) :'];
    TextEditingController quantityController = controllers[2]['Quantity :'];
    if (drugController.text == '' ||
        priceController.text == '' ||
        priceController.text == '0' ||
        quantityController.text == '' ||
        quantityController.text == '0') {
      ScaffoldMessenger.of(context).showSnackBar(errorMessage(
          "Please fill up all fields. (Quantity and price can't be zero)!!"));
    } else {
      try {
        String uri = "http://localhost/hospital_MS_api/insert_sell.php";
        var res = await http.post(Uri.parse(uri), body: {
          "Phar_ID": primaryKey,
          "Trade_name": drugController.text,
          "Price": priceController.text,
          "Quantity": quantityController.text,
        });
        jsonDecode(res.body);
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
  }

  SnackBar errorMessage(String msg) {
    return SnackBar(
      content: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color.fromARGB(126, 175, 79, 76)),
        child: Text(
          msg,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 15,
          ),
        ),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
      duration: const Duration(milliseconds: 1500),
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
              onPressed: () {
                nameController.text = pharmacy['Name'];
                addressController.text = pharmacy['Address'];
                phnumberController.text = pharmacy['Ph_number'];
                sellDrugDialog(context, pharmacy['Phar_ID'], sellDrug);
              },
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
