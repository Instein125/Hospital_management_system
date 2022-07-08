// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:flutter/services.dart';

import '/widgets/add_table_row.dart';
import '../../models/primary_value_jsonfile.dart';

class AddScreen extends StatefulWidget {
  // const AddScreen({Key? key}) : super(key: key);
  List controllers;
  final String primaryKey;
  String primaryValue;

  Function insertRecord;

  AddScreen(
      this.controllers, this.primaryKey, this.primaryValue, this.insertRecord);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  late int primaryIndex;

  Widget build(BuildContext context) {
    // readJson();
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromRGBO(129, 199, 132, 1),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            AddTableRow(widget.controllers, widget.primaryKey,
                widget.primaryValue, widget.insertRecord),
          ],
        ),
      ),
    );
  }
}
