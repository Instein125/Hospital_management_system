// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class MyTabBar extends StatelessWidget {
  final int length;
  final List tabItems;
  final List<Widget> databaseScreens;

  const MyTabBar(this.length, this.tabItems, this.databaseScreens);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: length,
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 45,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(25.0)),
              child: TabBar(
                indicator: BoxDecoration(
                    color: Colors.green[300],
                    borderRadius: BorderRadius.circular(25.0)),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                tabs: tabItems
                    .map((e) => Tab(
                          child: Text(
                            e,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: databaseScreens.map((e) => e).toList(),
              ),
            )
          ],
        ),
      )),
    );
  }
}
