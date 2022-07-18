// ignore_for_file: use_key_in_widget_constructors, deprecated_member_use

import 'package:flutter/material.dart';

import '/screens/companies_screen.dart';
import '/screens/drugs_screen.dart';
import '/screens/patients_screen.dart';
import '/screens/pharmacy_screen.dart';
import '/screens/supervisors_screen.dart';
import '/widgets/dashboaed_item.dart';
import '/widgets/top_bar.dart';
import '/widgets/side_menu.dart';
import './doctors_screen.dart';

class MainScreen extends StatelessWidget {
  final int selectedIndex;
  const MainScreen(
    this.selectedIndex,
  );
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
                  const TopBar('Dashboard'),
                  Container(
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(59, 123, 202, 0.5)),
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
                          child: GridView(
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 350,
                              childAspectRatio: 3 / 2,
                              crossAxisSpacing: 50,
                              mainAxisSpacing: 20,
                            ),
                            padding: const EdgeInsets.all(35),
                            children: [
                              DashboardItem(
                                  Icons.abc, 'assets/icons/doctor.png', () {
                                Navigator.of(context).pushReplacement(
                                  PageRouteBuilder(
                                    pageBuilder: (_, __, ___) =>
                                        DoctorsScreen(1),
                                    transitionDuration:
                                        const Duration(seconds: 0),
                                  ),
                                );
                              }, 'Doctors'),
                              DashboardItem(
                                  Icons.abc, 'assets/icons/patient.png', () {
                                Navigator.of(context).pushReplacement(
                                  PageRouteBuilder(
                                    pageBuilder: (_, __, ___) =>
                                        PatientsScreen(2),
                                    transitionDuration:
                                        const Duration(seconds: 0),
                                  ),
                                );
                              }, 'Patients'),
                              DashboardItem(Icons.local_pharmacy_outlined,
                                  'assets/icons/doctor.png', () {
                                Navigator.of(context).pushReplacement(
                                  PageRouteBuilder(
                                    pageBuilder: (_, __, ___) =>
                                        PharmacyScreen(3),
                                    transitionDuration:
                                        const Duration(seconds: 0),
                                  ),
                                );
                              }, 'Pharmacy'),
                              DashboardItem(Icons.factory_outlined,
                                  'assets/icons/doctor.png', () {
                                Navigator.of(context).pushReplacement(
                                  PageRouteBuilder(
                                    pageBuilder: (_, __, ___) =>
                                        CompaniesScreen(4),
                                    transitionDuration:
                                        const Duration(seconds: 0),
                                  ),
                                );
                              }, 'Companies'),
                              DashboardItem(
                                  Icons.abc, 'assets/icons/medicine.png', () {
                                Navigator.of(context).pushReplacement(
                                  PageRouteBuilder(
                                    pageBuilder: (_, __, ___) => DrugsScreen(5),
                                    transitionDuration:
                                        const Duration(seconds: 0),
                                  ),
                                );
                              }, 'Drugs'),
                              DashboardItem(Icons.supervisor_account_outlined,
                                  'assets/icons/doctor.png', () {
                                Navigator.of(context).pushReplacement(
                                  PageRouteBuilder(
                                    pageBuilder: (_, __, ___) =>
                                        SupervisorScreen(6),
                                    transitionDuration:
                                        const Duration(seconds: 0),
                                  ),
                                );
                              }, 'Supervisor'),
                            ],
                          ),
                        ),
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
