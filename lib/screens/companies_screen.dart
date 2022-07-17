// ignore_for_file: use_key_in_widget_constructors

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '/screens/database_screens/add_screen.dart';
import '/screens/database_screens/companies_list.dart';
import '/widgets/side_menu.dart';
import '/widgets/top_bar.dart';
import '../widgets/my_tab_bar.dart';

class CompaniesScreen extends StatefulWidget {
  static const routeName = '/companies_screen';
  final int selectedIndex;

  CompaniesScreen(this.selectedIndex);

  @override
  State<CompaniesScreen> createState() => _CompaniesScreenState();
}

class _CompaniesScreenState extends State<CompaniesScreen> {
  final nameController = TextEditingController();

  final phnumberController = TextEditingController();

  Future<void> insertRecord(context) async {
    if (nameController.text == '' || phnumberController.text == '') {
      print("Please fill all fields");
    } else {
      try {
        String uri = "http://localhost/hospital_MS_api/insert_company.php";

        var res = await http.post(Uri.parse(uri), body: {
          "name": nameController.text,
          "Ph_number": phnumberController.text,
        });
        setState(() {
          nameController.text = '';
          phnumberController.text = '';
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
          pageBuilder: (_, __, ___) => CompaniesScreen(4),
          transitionDuration: const Duration(seconds: 0),
        ),
      );

  @override
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
                  const TopBar('Pharmaceutical Companies'),
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
                        MyTabBar(2, const [
                          'Companies list',
                          'Add Company',
                        ], [
                          const CompaniesList(),
                          AddScreen(
                            [
                              {'Company Name : ': nameController},
                              {'Phone number : ': phnumberController},
                            ],
                            '',
                            '',
                            insertRecord,
                            cancelButton,
                          ),
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
