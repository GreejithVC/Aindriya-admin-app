import 'dart:io';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_and_signup_web/src/models/packagetype.dart';
import '../controllers/secondary_controller.dart';
import '../models/Dropdown.dart';
import '../models/shoptype.dart';
import '../repository/product_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';
import '../../generated/l10n.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

// ignore: must_be_immutable
class PackageDetailsWidget extends StatefulWidget {
  SecondaryController con;
  Function callback;
  PackageTypeModel packageType;
  String pageType;

  // create some values

  PackageDetailsWidget(
      {Key key, this.con, this.callback, this.packageType, this.pageType})
      : super(key: key);

  @override
  _PackageDetailsWidgetState createState() => _PackageDetailsWidgetState();
}

class _PackageDetailsWidgetState extends StateMVC<PackageDetailsWidget> {
  String test;

  Color pickerColor;

  Color currentColor;

  void changeColor(Color color) {
    setState(() => currentColor = color);
    widget.con.shopTypeData.colorCode = color.value.toRadixString(16);
  }

  List<DropDownModel> dropDownList = <DropDownModel>[];
  var code = '443a49';
  String _value;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.callback();
    if (widget.pageType == 'add') {
      pickerColor = Color(0xff443a49);
      currentColor = Color(0xff443a49);
      // widget.con.shopTypeData.colorCode = '#$code';
    } else {
      _value = widget.packageType.id;
      widget.con.shopTypeData.shopTypeId = widget.packageType.id;
      // widget.con.shopTypeData.colorCode = widget.packageType.colorCode;

      // pickerColor = HexColor(widget.packageType.colorCode);
      // currentColor = HexColor(widget.packageType.colorCode);
    }
    listenForDropdown('shop_type', 'type', 'status', 'success');
  }

  Future<void> listenForDropdown(table, select, column, para1) async {
    dropDownList.clear();
    final Stream<DropDownModel> stream =
        await getDropdownDataSC(table, select, column, para1);

    stream.listen((DropDownModel _list) {
      setState(() => dropDownList.add(_list));
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
        alignment: Alignment.center,
        child: Div(
          colS: 12,
          colM: 8,
          colL: 6,
          child: Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 0,
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.1,
              left: MediaQuery.of(context).size.width * 0.09,
              right: MediaQuery.of(context).size.width * 0.09,
              bottom: MediaQuery.of(context).size.height * 0.05,
            ),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      child: Container(
                    child: Scrollbar(
                      isAlwaysShown: true,
                      child: SingleChildScrollView(
                        child: Column(children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.close),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                )
                              ]),
                          Text(S.of(context).add_package_type,
                              style: Theme.of(context).textTheme.headline4),
                          Form(
                            key: widget.con.generalFormKey,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 40, left: 40),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Container(
                                          width: double.infinity,
                                          child: TextFormField(
                                              textAlign: TextAlign.left,
                                              autocorrect: true,
                                              initialValue: widget
                                                  .packageType.packageName,
                                              onSaved: (input) => widget
                                                  .con
                                                  .packageTypeData
                                                  .packageName = input,
                                              validator: (input) =>
                                                  input.length < 1
                                                      ? S
                                                          .of(context)
                                                          .field_required
                                                      : null,
                                              keyboardType: TextInputType.text,
                                              decoration: InputDecoration(
                                                labelText: S
                                                    .of(context)
                                                    .package_Type_name,
                                                labelStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2
                                                    .merge(TextStyle(
                                                        color: Colors.grey)),
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.grey,
                                                    width: 1.0,
                                                  ),
                                                ),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Theme.of(context)
                                                        .accentColor,
                                                    width: 1.0,
                                                  ),
                                                ),
                                              ))),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Container(
                                          width: double.infinity,
                                          child: TextFormField(
                                              textAlign: TextAlign.left,
                                              autocorrect: true,
                                              initialValue: widget.packageType
                                                  .maxProductSupported,
                                              onSaved: (input) => widget
                                                  .con
                                                  .packageTypeData
                                                  .maxProductSupported = input,
                                              validator: (input) =>
                                                  input.length < 1
                                                      ? S
                                                          .of(context)
                                                          .field_required
                                                      : null,
                                              keyboardType: TextInputType
                                                  .numberWithOptions(
                                                      decimal: false),
                                              decoration: InputDecoration(
                                                labelText: S
                                                    .of(context)
                                                    .max_product_supported,
                                                labelStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2
                                                    .merge(TextStyle(
                                                        color: Colors.grey)),
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.grey,
                                                    width: 1.0,
                                                  ),
                                                ),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Theme.of(context)
                                                        .accentColor,
                                                    width: 1.0,
                                                  ),
                                                ),
                                              ))),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Container(
                                          width: double.infinity,
                                          child: TextFormField(
                                              textAlign: TextAlign.left,
                                              autocorrect: true,
                                              initialValue: widget.packageType
                                                  .maxCategorySupported,
                                              onSaved: (input) => widget
                                                  .con
                                                  .packageTypeData
                                                  .maxCategorySupported = input,
                                              validator: (input) =>
                                                  input.length < 1
                                                      ? S
                                                          .of(context)
                                                          .field_required
                                                      : null,
                                              keyboardType: TextInputType
                                                  .numberWithOptions(
                                                      decimal: false),
                                              decoration: InputDecoration(
                                                labelText: S
                                                    .of(context)
                                                    .max_category_supported,
                                                labelStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2
                                                    .merge(TextStyle(
                                                        color: Colors.grey)),
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.grey,
                                                    width: 1.0,
                                                  ),
                                                ),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Theme.of(context)
                                                        .accentColor,
                                                    width: 1.0,
                                                  ),
                                                ),
                                              ))),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Container(
                                          width: double.infinity,
                                          child: TextFormField(
                                              textAlign: TextAlign.left,
                                              autocorrect: true,
                                              initialValue: widget
                                                  .packageType.monthlyRate,
                                              onSaved: (input) => widget
                                                  .con
                                                  .packageTypeData
                                                  .monthlyRate = input,
                                              validator: (input) =>
                                                  input.length < 1
                                                      ? S
                                                          .of(context)
                                                          .field_required
                                                      : null,
                                              keyboardType: TextInputType
                                                  .numberWithOptions(),
                                              decoration: InputDecoration(
                                                labelText:
                                                    S.of(context).monthly_rate,
                                                labelStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2
                                                    .merge(TextStyle(
                                                        color: Colors.grey)),
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.grey,
                                                    width: 1.0,
                                                  ),
                                                ),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Theme.of(context)
                                                        .accentColor,
                                                    width: 1.0,
                                                  ),
                                                ),
                                              ))),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Container(
                                          width: double.infinity,
                                          child: TextFormField(
                                              textAlign: TextAlign.left,
                                              autocorrect: true,
                                              initialValue: widget
                                                  .packageType.yearlyRate,
                                              onSaved: (input) => widget
                                                  .con
                                                  .packageTypeData
                                                  .yearlyRate = input,
                                              validator: (input) =>
                                                  input.length < 1
                                                      ? S
                                                          .of(context)
                                                          .field_required
                                                      : null,
                                              keyboardType: TextInputType
                                                  .numberWithOptions(),
                                              decoration: InputDecoration(
                                                labelText:
                                                    S.of(context).yearly_rate,
                                                labelStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2
                                                    .merge(TextStyle(
                                                        color: Colors.grey)),
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.grey,
                                                    width: 1.0,
                                                  ),
                                                ),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Theme.of(context)
                                                        .accentColor,
                                                    width: 1.0,
                                                  ),
                                                ),
                                              ))),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                              child: Text(
                                            S.of(context).feature_shop,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2
                                                .merge(TextStyle(
                                                    color: Colors.grey)),
                                          )),
                                          Switch(
                                            value: widget.con.packageTypeData
                                                    .isFeaturedShop ??
                                                false,
                                            onChanged: (value) {
                                              setState(() {
                                                widget.con.packageTypeData
                                                    .isFeaturedShop = value;
                                              });
                                            },
                                            activeTrackColor:
                                                Colors.lightGreenAccent,
                                            activeColor: Colors.green,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 30),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        // ignore: deprecated_member_use
                                        FlatButton(
                                          onPressed: () {
                                            widget.con.addPackageType(
                                                context, 'null', 'do_add');
                                          },
                                          padding: EdgeInsets.only(
                                              top: 15,
                                              bottom: 15,
                                              left: 40,
                                              right: 40),
                                          color: Theme.of(context)
                                              .accentColor
                                              .withOpacity(1),
                                          shape: StadiumBorder(),
                                          child: Text(
                                            S.of(context).submit,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6
                                                .merge(TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColorLight)),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 30),
                                  ]),
                            ),
                          ),
                        ]),
                      ),
                    ),
                  )),
                ],
              ),
            ),
          ),
        ));
  }
}
