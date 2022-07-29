// ignore_for_file: use_key_in_widget_constructors
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '/screens/pharmacy_screen.dart';
import '/screens/database_screens/contracts_list.dart';
import '/screens/database_screens/sign_contract.dart';
import '/widgets/side_menu.dart';
import '/widgets/top_bar.dart';
import '/widgets/my_tab_bar.dart';

class ContractScreen extends StatefulWidget {
  static const routeName = '/contracts_screen';
  final int selectedIndex;
  final String pharId;

  const ContractScreen(this.selectedIndex, this.pharId);

  @override
  State<ContractScreen> createState() => _ContractScreenState();
}

class _ContractScreenState extends State<ContractScreen> {
  late var companyController = TextEditingController();

  late var supervisorController = TextEditingController();

  late var durationController = TextEditingController();

  late var startDateController = TextEditingController();

  late var endDateController = TextEditingController();
  final String primaryKey = 'Pharmacy ID :';

  Future<void> signContract(context) async {
    if (companyController.text == '' ||
        supervisorController.text == '' ||
        durationController.text == '' ||
        startDateController.text == '') {
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
        DateTime tempDate =
            DateFormat("yyyy-MM-dd").parse(startDateController.text);
        print(tempDate);
        var endDate = DateTime(
            tempDate.year + int.parse(durationController.text),
            tempDate.month,
            tempDate.second);
        var formatter = DateFormat('yyyy-MM-dd');
        endDateController.text = formatter.format(endDate);

        String uri = "http://localhost/hospital_MS_api/insert_contract.php";

        var res = await http.post(Uri.parse(uri), body: {
          "Phar_ID": widget.pharId,
          "Company_name": companyController.text,
          "supervisor_ID": supervisorController.text,
          "start_date": startDateController.text,
          "end_date": endDateController.text,
        });
        setState(() {
          durationController.text = "";
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
          pageBuilder: (_, __, ___) => PharmacyScreen(3),
          transitionDuration: const Duration(seconds: 0),
        ),
      );

  Widget build(BuildContext context) {
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    startDateController.text = formatter.format(now);

    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            SideMenu(widget.selectedIndex),
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  const TopBar('Manage your Contracts'),
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
                          'Your Contracts',
                          'Sign Contract'
                        ], [
                          ContractsList(),
                          SignContract([
                            {'Company Name : ': companyController},
                            {'Supervisor : ': supervisorController},
                            {'Duration(in years) : ': durationController},
                            {'Start Date : ': startDateController},
                          ], primaryKey, widget.pharId, signContract,
                              cancelButton),
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
