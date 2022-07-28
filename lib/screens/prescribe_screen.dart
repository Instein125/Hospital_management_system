// ignore_for_file: use_key_in_widget_constructors

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '/screens/database_screens/prescribe_list_screen.dart';
import '/widgets/side_menu.dart';
import '/widgets/top_bar.dart';
import '/widgets/my_tab_bar.dart';

class PrescribeScreen extends StatefulWidget {
  static const routeName = '/prescribe_screen';
  final int selectedIndex;
  final String docSSN;

  PrescribeScreen(this.selectedIndex, this.docSSN);

  @override
  State<PrescribeScreen> createState() => _PrescribeScreenState();
}

class _PrescribeScreenState extends State<PrescribeScreen> {
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
                  const TopBar('Manage your patients'),
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
                        MyTabBar(1, const [
                          'Your Patients'
                        ], [
                          PrescribeList(widget.docSSN),
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
