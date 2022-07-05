// ignore_for_file: use_key_in_widget_constructors, avoid_print, avoid_function_literals_in_foreach_calls

import 'dart:ui';

import 'package:flutter/material.dart';

class AddTableRow extends StatelessWidget {
  List controllers;
  final String primaryKey;
  final String primaryValue;

  TableRow addTableRow(Map controller) {
    late String title;
    for (String key in controller.keys) {
      title = key;
    }

    return TableRow(
      children: [
        Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: Text(title),
            ),
          ],
        ),
        Column(
          children: [
            SizedBox(
              width: 300,
              child: TextField(
                controller: controller[title] as TextEditingController,
                decoration: const InputDecoration(isDense: true),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ],
    );
  }

  AddTableRow(this.controllers, this.primaryKey, this.primaryValue);

  @override
  Widget build(BuildContext context) {
    List listWidgets = controllers.map((e) => addTableRow(e)).toList();
    listWidgets.insert(0, primaryKeyRow());
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(4),
      },
      border: TableBorder.all(
        color: Colors.transparent,
      ),
      children: listWidgets as List<TableRow>,
    );
  }

  TableRow primaryKeyRow() {
    return TableRow(
      children: [
        Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: Text(
                primaryKey,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: Text(
                primaryValue,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
