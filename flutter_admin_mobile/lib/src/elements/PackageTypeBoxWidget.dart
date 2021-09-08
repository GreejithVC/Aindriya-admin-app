import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:login_and_signup_web/src/models/packagetype.dart';
import '../models/shoptype.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';

// ignore: must_be_immutable
class PackageTypeBoxWidget extends StatefulWidget {
  PackageTypeBoxWidget({Key key, this.packageTypeData,}) : super(key: key);
  PackageTypeModel packageTypeData;
  @override
  _PackageTypeBoxWidgetState createState() => _PackageTypeBoxWidgetState();
}

class _PackageTypeBoxWidgetState extends StateMVC<PackageTypeBoxWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.packageTypeData.packageName);
  }
}
