// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:visitor_management/allbuttons.dart';
import 'package:visitor_management/checkin.dart';
import 'package:visitor_management/checkout.dart';
import 'package:visitor_management/day_off.dart';
import 'package:visitor_management/header.dart';
import 'package:visitor_management/other.dart';
import 'package:visitor_management/template.dart';

class Actionselector extends StatelessWidget {
  const Actionselector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Divide(0.33),
          Headline('PLEASE SELECT ONE OF THE FOLLOW OPTION', 10.0),
          Nbtn('CHECK IN', 350, 50, 13, Template(checkin())),
          SizedBox(height: 35.0),
          Nbtn('CHECK OUT', 350, 50, 13, Template(checkout())),
          SizedBox(height: 35.0),
          Nbtn('REQUEST DAY OFF', 350, 50, 13, Template(Dayoff())),
          SizedBox(height: 35.0),
          Nbtn('OTHER', 350, 50, 13, Template(Other())),
        ],
      ),
    );
  }
}
