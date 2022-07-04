// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class DashboardItem extends StatelessWidget {
  final VoidCallback selectedFunction;
  final String title;
  final IconData icon;
  final String image;

  const DashboardItem(this.icon, this.image, this.selectedFunction, this.title);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: selectedFunction,
      borderRadius: BorderRadius.circular(20),
      splashColor: Theme.of(context).primaryColor,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).accentColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon == Icons.abc
                ? Image.asset(
                    image,
                    color: Colors.white54,
                    height: 45,
                  )
                : Icon(
                    icon,
                    size: 50,
                    color: Colors.white54,
                  ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 35,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
