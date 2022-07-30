// ignore_for_file: use_key_in_widget_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '/screens/database_screens/drugs_store.dart';
import '/screens/database_screens/add_screen.dart';
import '/screens/database_screens/drugs_list.dart';
import '/widgets/side_menu.dart';
import '/widgets/top_bar.dart';
import '../widgets/my_tab_bar.dart';

class DrugsScreen extends StatefulWidget {
  static const routeName = '/drugs_screen';
  final int selectedIndex;

  const DrugsScreen(this.selectedIndex);

  @override
  State<DrugsScreen> createState() => _DrugsScreenState();
}

class _DrugsScreenState extends State<DrugsScreen> {
  final tradenameController = TextEditingController();

  final formulaController = TextEditingController();

  Future<void> insertRecord(context) async {
    if (tradenameController.text == '' || formulaController.text == '') {
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
      try {
        String uri = "http://localhost/hospital_MS_api/insert_drug.php";

        await http.post(Uri.parse(uri), body: {
          "Trade_name": tradenameController.text,
          "Formula": formulaController.text,
        });
        setState(() {
          tradenameController.text = '';
          formulaController.text = '';
        });
      } catch (e) {
        print(e);
      }
    }
  }

  dynamic cancelButton() => Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => DrugsScreen(5),
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
                  const TopBar('Drugs'),
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
                          'Drugs list',
                          'Add drug',
                          'Store'
                        ], [
                          DrugsList(),
                          AddScreen(
                            [
                              {'Trade Name : ': tradenameController},
                              {'Formula : ': formulaController},
                            ],
                            '',
                            '',
                            insertRecord,
                            cancelButton,
                          ),
                          const DrugsStore(),
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
