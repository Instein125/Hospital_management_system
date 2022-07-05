// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

import '/screens/database_screens/add_screen.dart';
import '/screens/database_screens/doctors_list_screen.dart';
import '/screens/database_screens/manage_your_patients.dart';
import '../widgets/my_tab_bar.dart';
import '/widgets/side_menu.dart';
import '/widgets/top_bar.dart';

class DoctorsScreen extends StatelessWidget {
  static const routeName = '/doctors_screen';
  final int selectedIndex;
  final nameController = TextEditingController();
  final specialityController = TextEditingController();
  final experienceController = TextEditingController();
  DoctorsScreen(this.selectedIndex);

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
                  const TopBar('Doctors'),
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
                        MyTabBar(3, const [
                          'Doctors list',
                          'Add doctors',
                          'Manage your patients'
                        ], [
                          DoctorsList(),
                          AddScreen([
                            {'Name : ': nameController},
                            {'Speciality : ': specialityController},
                            {'Experience :': experienceController}
                          ], 'Doctor SSN :', 'DC001'),
                          ManageYourPatients(),
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
