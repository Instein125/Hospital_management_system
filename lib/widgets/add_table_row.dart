// ignore_for_file: use_key_in_widget_constructors, avoid_print, avoid_function_literals_in_foreach_calls, deprecated_member_use, non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class AddTableRow extends StatefulWidget {
  List controllers;
  final String primaryKey;
  final String primaryValue;
  Function insertRecord;
  Function cancelButton;

  AddTableRow(this.controllers, this.primaryKey, this.primaryValue,
      this.insertRecord, this.cancelButton);

  @override
  State<AddTableRow> createState() => _AddTableRowState();
}

class _AddTableRowState extends State<AddTableRow> {
  late List SSN = [];
  late List docName = [];
  int index = 0;
  String? value;

  late String title;

  Future<void> getSSN() async {
    String uri = "http://localhost/hospital_MS_api/doc_ssn_list.php";
    try {
      var response = await http.get(Uri.parse(uri));
      setState(() {
        List doctorsSSN = jsonDecode(response.body);
        for (int i = 0; i < doctorsSSN.length; i++) {
          SSN.add(doctorsSSN[i]["Doc_SSN"]);
          docName.add(doctorsSSN[i]["Name"]);
        }
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getSSN();
    super.initState();
  }

  TableRow addTableRow(Map controller) {
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
              child: title != 'Doctor_SSN : '
                  ? TextField(
                      controller: controller[title] as TextEditingController,
                      decoration: const InputDecoration(isDense: true),
                      textAlign: TextAlign.center,
                    )
                  : DropdownButton<dynamic>(
                      focusColor: Colors.transparent,
                      dropdownColor: Colors.green[300],
                      isExpanded: true,
                      value: value,
                      items: SSN.map((e) {
                        if (index >= docName.length) {
                          index = 0;
                        }
                        return buildMenuItem(e, docName[index]);
                      }).toList(),
                      onChanged: (value) => setState(() {
                            TextEditingController temp =
                                controller[title] as TextEditingController;
                            this.value = value;

                            temp.text = value;
                          })),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    List listWidgets = widget.controllers.map((e) => addTableRow(e)).toList();
    listWidgets.insert(0, primaryKeyRow());

    return Column(
      children: [
        Table(
          columnWidths: const {
            0: FlexColumnWidth(1),
            1: FlexColumnWidth(4),
          },
          border: TableBorder.all(
            color: Colors.transparent,
          ),
          children: listWidgets as List<TableRow>,
        ),
        const SizedBox(
          height: 50,
        ),
        optionWidget(context),
      ],
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
                widget.primaryKey,
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
                widget.primaryValue,
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

  DropdownMenuItem buildMenuItem(String item, String name) {
    index = index + 1;
    return DropdownMenuItem(
        value: item,
        child: Container(
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.white54)),
          ),
          width: 300,
          child: Text(
            "$name  ($item)",
            textAlign: TextAlign.center,
          ),
        ));
  }

  Row optionWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RaisedButton(
          onPressed: (() {
            value = null;
            widget.insertRecord(context);
          }),
          color: Theme.of(context).accentColor,
          hoverColor: Theme.of(context).primaryColor,
          child: const Text(
            'Insert',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        RaisedButton(
          onPressed: () => widget.cancelButton(),
          color: Theme.of(context).accentColor,
          hoverColor: Theme.of(context).primaryColor,
          child: const Text(
            'Cancel',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
