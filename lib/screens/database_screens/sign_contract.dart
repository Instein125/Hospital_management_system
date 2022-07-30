// ignore_for_file: deprecated_member_use, must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/material.dart';

import '/widgets/add_contract_row.dart';

class SignContract extends StatefulWidget {
  // const SignContract({Key? key}) : super(key: key);
  List controllers;
  final String primaryKey;
  String primaryValue;

  Function signContract;
  Function cancelButton;

  SignContract(this.controllers, this.primaryKey, this.primaryValue,
      this.signContract, this.cancelButton);

  @override
  State<SignContract> createState() => _SignContractState();
}

class _SignContractState extends State<SignContract> {
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
            AddContractRow(widget.controllers, widget.primaryKey,
                widget.primaryValue, widget.signContract, widget.cancelButton),
          ],
        ),
      ),
    );
  }
}
