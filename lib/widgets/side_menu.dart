// ignore_for_file: use_key_in_widget_constructors, override_on_non_overriding_member, non_constant_identifier_names

import 'package:flutter/material.dart';

import '/screens/companies_screen.dart';
import '/screens/doctors_screen.dart';
import '/screens/drugs_screen.dart';
import '/screens/main_screen.dart';
import '/screens/patients_screen.dart';
import '/screens/pharmacy_screen.dart';

class SideMenu extends StatefulWidget {
  final int selectedIndex;
  const SideMenu(this.selectedIndex);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget BuildListTile(
      IconData icon, String title, VoidCallback tapHandler, bool select) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
        color: Colors.white54,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.white54,
        ),
      ),
      onTap: tapHandler,
      selected: select,
      selectedTileColor: const Color.fromRGBO(45, 169, 92, 1),
    );
  }

  Widget build(BuildContext context) {
    return Expanded(
      child: Drawer(
        backgroundColor: Theme.of(context).accentColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const DrawerHeader(
                child: Text(
                  'Hospital Management System',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
              BuildListTile(
                Icons.person_outline,
                "Dashboard",
                () {
                  Navigator.of(context).pushReplacement(
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => const MainScreen(0),
                      transitionDuration: const Duration(seconds: 0),
                    ),
                  );
                },
                widget.selectedIndex == 0,
              ),
              ListTile(
                leading: Image.asset(
                  'assets/icons/doctor.png',
                  color: Colors.white54,
                  height: 30,
                ),
                title: const Text(
                  'Doctors',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white54,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => const DoctorsScreen(1),
                      transitionDuration: const Duration(seconds: 0),
                    ),
                  );
                },
                selected: widget.selectedIndex == 1,
                selectedTileColor: const Color.fromRGBO(45, 169, 92, 1),
              ),
              ListTile(
                leading: Image.asset(
                  'assets/icons/patient.png',
                  color: Colors.white54,
                  height: 25,
                ),
                title: const Text(
                  'Patients',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white54,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => const PatientsScreen(2),
                      transitionDuration: const Duration(seconds: 0),
                    ),
                  );
                },
                selected: widget.selectedIndex == 2,
                selectedTileColor: const Color.fromRGBO(45, 169, 92, 1),
              ),
              BuildListTile(
                Icons.local_pharmacy_outlined,
                "Pharmacy",
                () {
                  Navigator.of(context).pushReplacement(
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => const PharmacyScreen(3),
                      transitionDuration: const Duration(seconds: 0),
                    ),
                  );
                },
                widget.selectedIndex == 3,
              ),
              BuildListTile(
                Icons.factory_outlined,
                "Comapanies",
                () {
                  Navigator.of(context).pushReplacement(
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => const CompaniesScreen(4),
                      transitionDuration: const Duration(seconds: 1),
                    ),
                  );
                },
                widget.selectedIndex == 4,
              ),
              ListTile(
                leading: Image.asset(
                  'assets/icons/medicine.png',
                  color: Colors.white54,
                  height: 27,
                ),
                title: const Text(
                  'Drugs',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white54,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => const DrugsScreen(5),
                      transitionDuration: const Duration(seconds: 0),
                    ),
                  );
                },
                selected: widget.selectedIndex == 5,
                selectedTileColor: const Color.fromRGBO(45, 169, 92, 1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
