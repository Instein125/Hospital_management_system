// ignore_for_file: deprecated_member_use, must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/material.dart';

import '/widgets/add_table_row.dart';

class AddScreen extends StatefulWidget {
  // const AddScreen({Key? key}) : super(key: key);
  List controllers;
  final String primaryKey;
  String primaryValue;

  Function insertRecord;
  Function cancelButton;

  AddScreen(this.controllers, this.primaryKey, this.primaryValue,
      this.insertRecord, this.cancelButton);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  late int primaryIndex;

  @override
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
                widget.primaryValue, widget.insertRecord, widget.cancelButton),
          ],
        ),
      ),
    );
  }
}
