// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

import '/screens/database_screens/add_screen.dart';
import '/screens/database_screens/companies_list.dart';
import '/widgets/side_menu.dart';
import '/widgets/top_bar.dart';
import '../widgets/my_tab_bar.dart';

class CompaniesScreen extends StatelessWidget {
  static const routeName = '/companies_screen';
  final int selectedIndex;
  final nameController = TextEditingController();
  final phnumberController = TextEditingController();
  CompaniesScreen(this.selectedIndex);
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
                  const TopBar('Pharmaceutical Companies'),
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
                          'Companies list',
                          'Add Company',
                        ], [
                          CompaniesList(),
                          AddScreen([
                            {'Company Name : ': nameController},
                            {'Phone number : ': phnumberController},
                          ], '', ''),
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
