// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  final String title;
  const TopBar(this.title);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: double.infinity,
      color: Theme.of(context).primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.white),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(15),
            alignment: Alignment.center,
            child: Row(
              children: [
                Column(
                  children: const [
                    Text(
                      'Doctors',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '15',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                const VerticalDivider(),
                Column(
                  children: const [
                    Text(
                      'Patients',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      '15',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                const VerticalDivider(),
                Column(
                  children: const [
                    Text(
                      'Pharmacy',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      '15',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
