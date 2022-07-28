// ignore_for_file: use_key_in_widget_constructors

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

import '/models/primary_value_jsonfile.dart';
import '/screens/database_screens/add_screen.dart';
import '/screens/database_screens/doctors_list_screen.dart';
import '/screens/database_screens/manage_your_patients.dart';
import '../widgets/my_tab_bar.dart';
import '/widgets/side_menu.dart';
import '/widgets/top_bar.dart';

class DoctorsScreen extends StatefulWidget {
  static const routeName = '/doctors_screen';
  final int selectedIndex;
  late String primaryValue = '';
  late int primaryIndex = 0;
  DoctorsScreen(this.selectedIndex);

  @override
  State<DoctorsScreen> createState() => _DoctorsScreenState();
}

class _DoctorsScreenState extends State<DoctorsScreen> {
  late var nameController = TextEditingController();

  late var specialityController = TextEditingController();

  late var experienceController = TextEditingController();

  final String primaryKey = 'Doctor SSN :';
  static int count = 0;

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('jsonfile/primary_values.json');

    final data = jsonDecode(response);

    var values = PrimaryValueJson.fromJson(data);
    setState(() {
      if (primaryKey == 'Doctor SSN :') {
        widget.primaryIndex = values.doc_ssn + count;
        if (widget.primaryIndex < 10) {
          widget.primaryValue = 'DC00${widget.primaryIndex}';
        } else if (widget.primaryIndex > 9 && widget.primaryIndex < 100) {
          widget.primaryValue = 'DC0${widget.primaryIndex}';
        } else if (widget.primaryIndex > 99 && widget.primaryIndex < 1000) {
          widget.primaryValue = 'DC${widget.primaryIndex}';
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
    final PrimaryValueJson doctor = PrimaryValueJson(
      doc_ssn: values.doc_ssn + count,
      phar_id: values.phar_id,
      ssn: values.ssn,
      super_id: values.super_id,
    );
    final update = doctor.toJson();
    path.writeAsStringSync(json.encode(update));

    nameController.text = '';
    specialityController.text = '';
    experienceController.text = '';
    widget.primaryIndex = doctor.doc_ssn;
    if (primaryKey == 'Doctor SSN :') {
      widget.primaryIndex = values.doc_ssn + count;
      if (widget.primaryIndex < 10) {
        widget.primaryValue = 'DC00${widget.primaryIndex}';
      } else if (widget.primaryIndex > 9 && widget.primaryIndex < 100) {
        widget.primaryValue = 'DC0${widget.primaryIndex}';
      } else if (widget.primaryIndex > 99 && widget.primaryIndex < 1000) {
        widget.primaryValue = 'DC${widget.primaryIndex}';
      }
    }
  }

  Future<void> insertRecord(context) async {
    print(nameController.text);
    print(specialityController.text);
    print(experienceController.text);
    print(widget.primaryValue);
    if (nameController.text == '' ||
        specialityController.text == '' ||
        experienceController.text == '') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color.fromARGB(126, 175, 79, 76)),
          child: const Text(
            "Please fill all the fileds!!",
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
    } else {
      count = count + 1;
      try {
        String uri = "http://localhost/hospital_MS_api/insert_doctor.php";

        var res = await http.post(Uri.parse(uri), body: {
          "Doc_SSN": widget.primaryValue,
          "name": nameController.text,
          "speciality": specialityController.text,
          "experience": experienceController.text,
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
          pageBuilder: (_, __, ___) => DoctorsScreen(1),
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
                  const TopBar('Doctors'),
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
                        MyTabBar(3, const [
                          'Doctors list',
                          'Add doctor',
                          'Manage your patients'
                        ], [
                          DoctorsList(),
                          AddScreen(
                            [
                              {'Name : ': nameController},
                              {'Speciality :': specialityController},
                              {'Experience :': experienceController}
                            ],
                            primaryKey,
                            widget.primaryValue,
                            insertRecord,
                            cancelButton,
                          ),
                          ManageYourPatients(),
                        ]),
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
