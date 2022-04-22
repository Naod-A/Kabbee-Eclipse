import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../profile_screen.dart';
import '../../../constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:quez_app/constants.dart';

AppBar QuizeAppbar(String iconUrl) {
  return AppBar(
    //backgroundColor: appbarColor,
    title: Center(
      child: CircleAvatar(child: SvgPicture.asset(iconUrl)),
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: defaultPadding / 2),
        child: InkWell(
            onTap: () {
              Get.to(ProfileScreen());
            },
            child: CircleAvatar(
              foregroundImage: AssetImage("assets/images/profile_pic_demo.jpg"),
            )),
      ),
    ],
  );
}
