import 'package:flutter/material.dart';
import 'package:hospital_system/widgets/add_table_row.dart';

class AddScreen extends StatelessWidget {
  // const AddScreen({Key? key}) : super(key: key);
  List controllers;
  final String primaryKey;
  final String primaryValue;
  AddScreen(this.controllers, this.primaryKey, this.primaryValue);

  @override
  Widget build(BuildContext context) {
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
        child: AddTableRow(controllers, primaryKey, primaryValue),
      ),
    );
  }
}
