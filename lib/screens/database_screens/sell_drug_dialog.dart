// ignore_for_file: avoid_unnecessary_containers, deprecated_member_use, prefer_typing_uninitialized_variables, sized_box_for_whitespace

import 'package:flutter/material.dart';

void sellDrugDialog(
    BuildContext context, String primaryKey, Function sellDrug) {
  TextEditingController drugController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  List<Map> controllers = [
    {"Drug name :": drugController},
    {"Price(in NRs) :": priceController},
    {"Quantity :": quantityController},
  ];
  List listWidgets = controllers.map((e) {
    return buildDialogContent(e);
  }).toList();
  listWidgets.add(buttonWidget(context, primaryKey, sellDrug, controllers));

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            width: 400,
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: listWidgets as List<Widget>,
            ),
          ),
        );
      });
}

Container buttonWidget(BuildContext context, String primaryKey,
    Function sellDrug, List<Map> controllers) {
  return Container(
    height: 50,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RaisedButton(
            onPressed: () {
              sellDrug(primaryKey, controllers);
            },
            color: const Color(0xff033B4A),
            hoverColor: const Color(0xff2DA95C),
            child: const Text(
              'Sell',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            )),
        const SizedBox(
          width: 50,
        ),
        RaisedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            color: const Color(0xff033B4A),
            hoverColor: const Color(0xff2DA95C),
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            )),
      ],
    ),
  );
}

Container buildDialogContent(Map controller) {
  var title;
  for (String key in controller.keys) {
    title = key;
  }

  return Container(
    height: 50,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          width: 250,
          child: TextField(
            controller: controller[title],
            decoration: const InputDecoration(isDense: true),
            textAlign: TextAlign.center,
          ),
        )
      ],
    ),
  );
  // const SizedBox(
  //   height: 30,
  // )
}
