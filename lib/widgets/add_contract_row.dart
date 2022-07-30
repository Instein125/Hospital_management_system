// ignore_for_file: use_key_in_widget_constructors, avoid_print, avoid_function_literals_in_foreach_calls, deprecated_member_use, non_constant_identifier_names, unnecessary_this

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class AddContractRow extends StatefulWidget {
  List controllers;
  final String primaryKey;
  final String primaryValue;
  Function signContract;
  Function cancelButton;

  AddContractRow(this.controllers, this.primaryKey, this.primaryValue,
      this.signContract, this.cancelButton);

  @override
  State<AddContractRow> createState() => _AddContractRowState();
}

class _AddContractRowState extends State<AddContractRow> {
  late List companies = [];
  late List supervisorsID = [];
  late List supervisorsName = [];
  int index = 0;
  String? valueC;
  String? valueS;

  late String title;

  Future<void> getCompanies() async {
    String uri = "http://localhost/hospital_MS_api/companies_list.php";
    try {
      var response = await http.post(Uri.parse(uri), body: {
        "phar_id": widget.primaryValue,
      });
      setState(() {
        List companiesData = jsonDecode(response.body);
        for (int i = 0; i < companiesData.length; i++) {
          companies.add(companiesData[i]["company_name"]);
        }
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> getSupervisor() async {
    String uri = "http://localhost/hospital_MS_api/supervisor_list.php";
    try {
      var response = await http.get(Uri.parse(uri));
      setState(() {
        List supervisorData = jsonDecode(response.body);
        for (int i = 0; i < supervisorData.length; i++) {
          supervisorsID.add(supervisorData[i]["supervisor_id"]);
          supervisorsName.add(supervisorData[i]["name"]);
        }
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getCompanies();
    getSupervisor();
    super.initState();
  }

  TableRow AddContractRow(Map controller) {
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
                child: title != 'Company Name : ' && title != 'Supervisor : '
                    ? TextField(
                        controller: controller[title] as TextEditingController,
                        decoration: const InputDecoration(isDense: true),
                        textAlign: TextAlign.center,
                      )
                    : title == 'Company Name : '
                        ? DropdownButton<dynamic>(
                            focusColor: Colors.transparent,
                            dropdownColor: Colors.green[300],
                            isExpanded: true,
                            value: valueC,
                            items: companies.map((e) {
                              return buildCompaniesMenuItem(e);
                            }).toList(),
                            onChanged: (valueC) => setState(() {
                                  TextEditingController temp =
                                      controller["Company Name : "]
                                          as TextEditingController;
                                  this.valueC = valueC;

                                  temp.text = valueC;
                                }))
                        : DropdownButton<dynamic>(
                            focusColor: Colors.transparent,
                            dropdownColor: Colors.green[300],
                            isExpanded: true,
                            value: valueS,
                            items: supervisorsID.map((e) {
                              if (index >= supervisorsName.length) {
                                index = 0;
                              }
                              return buildSupervisorMenuItem(
                                  e, supervisorsName[index]);
                            }).toList(),
                            onChanged: (value) => setState(() {
                                  TextEditingController temp =
                                      controller["Supervisor : "]
                                          as TextEditingController;
                                  this.valueS = value;

                                  temp.text = value;
                                }))),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    List listWidgets =
        widget.controllers.map((e) => AddContractRow(e)).toList();
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

  DropdownMenuItem buildCompaniesMenuItem(String item) {
    index = index + 1;
    return DropdownMenuItem(
        value: item,
        child: Container(
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.white54)),
          ),
          width: 300,
          child: Text(
            item,
            textAlign: TextAlign.center,
          ),
        ));
  }

  DropdownMenuItem buildSupervisorMenuItem(String item, String name) {
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
          onPressed: (() => widget.signContract(context)),
          color: Theme.of(context).accentColor,
          hoverColor: Theme.of(context).primaryColor,
          child: const Text(
            'Sign',
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
