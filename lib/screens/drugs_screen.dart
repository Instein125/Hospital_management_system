// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

import '/screens/database_screens/add_screen.dart';
import '/screens/database_screens/drugs_list.dart';
import '/widgets/side_menu.dart';
import '/widgets/top_bar.dart';
import '../widgets/my_tab_bar.dart';

class DrugsScreen extends StatelessWidget {
  static const routeName = '/drugs_screen';
  final int selectedIndex;
  final tradenameController = TextEditingController();
  final formulaController = TextEditingController();
  DrugsScreen(this.selectedIndex);
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
                  const TopBar('Drugs'),
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
                          'Drugs list',
                          'Add drug',
                        ], [
                          DrugsList(),
                          AddScreen([
                            {'Trade Name : ': tradenameController},
                            {'Formula : ': formulaController},
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
