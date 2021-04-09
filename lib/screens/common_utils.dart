import 'package:firebase_login/screens/size_config.dart';
import 'package:flutter/material.dart';

AppBar buildAppBar(String title) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    title: Text(
      title,
      style: TextStyle(color: Colors.black54),
    ),
    iconTheme: IconThemeData(color: Colors.black),
    centerTitle: true,
  );
}

var outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(42),
    borderSide: BorderSide(color: Colors.black54),
    gapPadding: 0);

var loadingForm = Container(
  child: GestureDetector(
    onTap: () {},
    child: Center(
      child: CircularProgressIndicator(),
    ),
  ),
);

var marginVerticalSmall = SizedBox(
  height: getProportionateScreenHeight(10),
);

var marginVerticalNormal = SizedBox(
  height: getProportionateScreenHeight(20),
);
var marginVerticalLong = SizedBox(
  height: getProportionateScreenHeight(40),
);
var marginHorizontalSmall = SizedBox(
  width: getProportionateScreenWidth(10),
);
var marginHorizontalNormal = SizedBox(
  width: getProportionateScreenWidth(20),
);
var marginHorizontalLong = SizedBox(
  width: getProportionateScreenWidth(40),
);
