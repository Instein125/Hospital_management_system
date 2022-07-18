import 'package:flutter/material.dart';

class PrimaryValueJson {
  int doc_ssn;
  int ssn;
  int phar_id;
  int super_id;
  // ignore: non_constant_identifier_names
  PrimaryValueJson(
      {required this.doc_ssn,
      required this.phar_id,
      required this.ssn,
      required this.super_id});

  factory PrimaryValueJson.fromJson(Map json) {
    return PrimaryValueJson(
      doc_ssn: json['doc_ssn'],
      phar_id: json['phar_id'],
      ssn: json['ssn'],
      super_id: json['super_id'],
    );
  }
  Map toJson() => {
        "doc_ssn": doc_ssn,
        "ssn": ssn,
        "phar_id": phar_id,
        "super_id": super_id,
      };
}
