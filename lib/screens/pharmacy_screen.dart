// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

import '/screens/database_screens/add_screen.dart';
import '/screens/database_screens/pharmacy_list.dart';
import '/widgets/side_menu.dart';
import '/widgets/top_bar.dart';
import '../widgets/my_tab_bar.dart';

class PharmacyScreen extends StatelessWidget {
  static const routeName = '/pharmacy_screen';
  final int selectedIndex;
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final phnumberController = TextEditingController();
  PharmacyScreen(this.selectedIndex);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            SideMenu(selectedIndex),
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  const TopBar('Pharmacy'),
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
                          'Pharmacies list',
                          'Add Pharmacy',
                        ], [
                          PharmacyList(),
                          AddScreen([
                            {'Name : ': nameController},
                            {'Address : ': addressController},
                            {'Phone number :': phnumberController}
                          ], 'Pharmacy ID :', 'PH001'),
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
