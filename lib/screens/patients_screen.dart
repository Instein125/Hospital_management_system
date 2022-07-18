// ignore_for_file: use_key_in_widget_constructors

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../models/primary_value_jsonfile.dart';
import '/screens/database_screens/patients_list.dart';
import '/widgets/side_menu.dart';
import '/widgets/top_bar.dart';
import '/widgets/my_tab_bar.dart';
import './database_screens/add_screen.dart';

class PatientsScreen extends StatefulWidget {
  static const routeName = '/patients_screen';
  final int selectedIndex;
  late String primaryValue = '';
  late int primaryIndex = 0;

  PatientsScreen(this.selectedIndex);

  @override
  State<PatientsScreen> createState() => _PatientsScreenState();
}

class _PatientsScreenState extends State<PatientsScreen> {
  late var nameController = TextEditingController();

  late var addressController = TextEditingController();

  late var ageController = TextEditingController();

  late var docController = TextEditingController();
  final String primaryKey = 'Patient SSN :';
  static int count = 0;

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('jsonfile/primary_values.json');

    final data = jsonDecode(response);

    var values = PrimaryValueJson.fromJson(data);

    setState(() {
      if (primaryKey == 'Patient SSN :') {
        widget.primaryIndex = values.ssn + count;
        if (widget.primaryIndex < 10) {
          widget.primaryValue = 'PT00${widget.primaryIndex}';
        } else if (widget.primaryIndex > 9 && widget.primaryIndex < 100) {
          widget.primaryValue = 'PT0${widget.primaryIndex}';
        } else if (widget.primaryIndex > 99 && widget.primaryIndex < 1000) {
          widget.primaryValue = 'PT${widget.primaryIndex}';
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    readJson();
  }

  _writeJson(int count) async {
    String response =
        await rootBundle.loadString('jsonfile/primary_values.json');
    File path = File('jsonfile/primary_values.json');

    var data = jsonDecode(response);
    var values = PrimaryValueJson.fromJson(data);
    final PrimaryValueJson patient = PrimaryValueJson(
      doc_ssn: values.doc_ssn,
      phar_id: values.phar_id,
      ssn: values.ssn + count,
      super_id: values.super_id,
    );
    final update = patient.toJson();
    path.writeAsStringSync(json.encode(update));

    nameController.text = '';
    addressController.text = '';
    ageController.text = '';
    docController.text = '';
    widget.primaryIndex = patient.ssn;
    if (primaryKey == 'Patient SSN :') {
      widget.primaryIndex = values.ssn + count;
      if (widget.primaryIndex < 10) {
        widget.primaryValue = 'PT00${widget.primaryIndex}';
      } else if (widget.primaryIndex > 9 && widget.primaryIndex < 100) {
        widget.primaryValue = 'PT0${widget.primaryIndex}';
      } else if (widget.primaryIndex > 99 && widget.primaryIndex < 1000) {
        widget.primaryValue = 'PT${widget.primaryIndex}';
      }
    }
  }

  Future<void> insertRecord(context) async {
    print(nameController.text);
    print(addressController.text);
    print(ageController.text);
    print(docController.text);
    if (nameController.text == '' ||
        addressController.text == '' ||
        ageController.text == '' ||
        docController.text == '') {
      print("Please fill all fields");
    } else {
      count = count + 1;
      try {
        String uri = "http://localhost/hospital_MS_api/insert_patient.php";

        var res = await http.post(Uri.parse(uri), body: {
          "SSN": widget.primaryValue,
          "Doc_SSN": docController.text,
          "name": nameController.text,
          "address": addressController.text,
          "age": ageController.text,
        });
        setState(() {
          _writeJson(count);
        });

        var response = jsonDecode(res.body);
        if (response["success"] == "true") {
          print("Record Inserted");
        } else {
          print("Record not inserted");
        }
      } catch (e) {
        print(e);
      }
    }
  }

  dynamic cancelButton() => Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => PatientsScreen(2),
          transitionDuration: const Duration(seconds: 0),
        ),
      );

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            SideMenu(widget.selectedIndex),
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  const TopBar('Patients'),
                  Container(
                    decoration: const BoxDecoration(color: Color(0xff9DABAF)),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height - 70,
                    child: Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height - 90,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black, width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin: const EdgeInsets.all(20),
                        ),
                        MyTabBar(
                          2,
                          const [
                            'Patients list',
                            'Add Patient',
                          ],
                          [
                            PatientsList(),
                            AddScreen([
                              {'Name : ': nameController},
                              {'Address : ': addressController},
                              {'Age : ': ageController},
                              {'Doctor_SSN : ': docController},
                            ], primaryKey, widget.primaryValue, insertRecord,
                                cancelButton),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
