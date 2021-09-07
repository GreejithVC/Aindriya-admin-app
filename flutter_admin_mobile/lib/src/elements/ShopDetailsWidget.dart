import 'dart:io';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../controllers/secondary_controller.dart';
import '../models/Dropdown.dart';
import '../models/shoptype.dart';
import '../repository/product_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';
import '../../generated/l10n.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
// ignore: must_be_immutable
class ShopDetailsWidget extends StatefulWidget{
  SecondaryController con;
  Function callback;
  ShopTypeModel shopType;
  String pageType;
  // create some values





  ShopDetailsWidget({Key key, this.con,this.callback, this.shopType, this.pageType}) : super(key: key);
  @override
  _ShopDetailsWidgetState createState() => _ShopDetailsWidgetState();
}

class _ShopDetailsWidgetState extends StateMVC<ShopDetailsWidget> {

  String test;

  Color pickerColor ;
  Color currentColor ;
  void changeColor(Color color) {
    setState(() => currentColor = color);
     widget.con.shopTypeData.colorCode = color.value.toRadixString(16);

  }
  List<DropDownModel> dropDownList = <DropDownModel>[];
  var code = '443a49';
  String _value ;
  @override
  void initState() {

    // TODO: implement initState
    super.initState();
   widget.callback();
   if(widget.pageType=='add') {

     pickerColor = Color(0xff443a49);
     currentColor = Color(0xff443a49);
     widget.con.shopTypeData.colorCode = '#$code';
   } else {
     _value =  widget.shopType.shopTypeId;
     widget.con.shopTypeData.shopTypeId = widget.shopType.shopTypeId;
     widget.con.shopTypeData.colorCode = widget.shopType.colorCode;

     pickerColor = HexColor(widget.shopType.colorCode);
     currentColor = HexColor(widget.shopType.colorCode);
   }
    listenForDropdown('shop_type', 'type', 'status', 'success');
  }
  Future<void> listenForDropdown(table, select, column, para1) async {
    dropDownList.clear();
    final Stream<DropDownModel> stream = await getDropdownDataSC(table, select, column, para1);

    stream.listen((DropDownModel _list) {


      setState(() => dropDownList.add(_list));

    }, onError: (a) {
      print(a);
    }, onDone: () {

    });
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
        alignment: Alignment.center,
        child:Div(
          colS:12,
          colM:8,
          colL:6,


          child:Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16)
            ),

            elevation: 0,
            backgroundColor: Colors.transparent,

            insetPadding: EdgeInsets.only(top:MediaQuery.of(context).size.height * 0.1,
              left:MediaQuery.of(context).size.width * 0.09,
              right:MediaQuery.of(context).size.width * 0.09,
              bottom:MediaQuery.of(context).size.height * 0.05,
            ),
            child:Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color:Theme.of(context).primaryColor,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(12))
              ),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      child:Container(
                        child:Scrollbar(
                          isAlwaysShown: true,
                          child: SingleChildScrollView(
                            child: Column(
                                children: [
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children:[
                                        IconButton(
                                          icon: Icon(Icons.close),
                                          onPressed: (){
                                            Navigator.pop(context);
                                          },
                                        )

                                      ]
                                  ),
                                  Text(S.of(context).add_shop_type,
                                      style: Theme.of(context).textTheme.headline4
                                  ),

                                  Form(
                                    key: widget.con.generalFormKey,
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 40, left:40),
                                      child:Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children:[

                                            Padding(
                                              padding: EdgeInsets.only(top:10),
                                              child: Container(
                                                  width: double.infinity,

                                                  child: TextFormField(
                                                      textAlign: TextAlign.left,
                                                      autocorrect: true,
                                                     initialValue: widget.shopType.focusTypeName,
                                                      onSaved: (input) =>widget.con.shopTypeData.focusTypeName = input,
                                                      validator: (input) => input.length < 1 ? S.of(context).please_enter_your_category : null,
                                                      keyboardType: TextInputType.text,
                                                      decoration: InputDecoration(
                                                        labelText: S.of(context).type_name,
                                                        labelStyle: Theme.of(context).textTheme.bodyText2.merge(TextStyle(color:Colors.grey)),
                                                        enabledBorder: UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                            color: Colors.grey,
                                                            width: 1.0,
                                                          ),
                                                        ),
                                                        focusedBorder: UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                            color:
                                                            Theme.of(context).accentColor,
                                                            width: 1.0,
                                                          ),
                                                        ),
                                                      ))),
                                            ),

                                            SizedBox(height: 15),
                                            Padding(
                                              padding: EdgeInsets.only(top:10),
                                              child: Container(
                                                  width: double.infinity,

                                                  child: TextFormField(
                                                      textAlign: TextAlign.left,
                                                      autocorrect: true,
                                                     initialValue: widget.shopType.commission,
                                                      onSaved: (input) =>widget.con.shopTypeData.commission = input,
                                                      validator: (input) => input.length < 1 ? S.of(context).please_enter_your_category : null,
                                                      keyboardType: TextInputType.text,
                                                      decoration: InputDecoration(
                                                        labelText: S.of(context).commission,
                                                        labelStyle: Theme.of(context).textTheme.bodyText2.merge(TextStyle(color:Colors.grey)),
                                                        enabledBorder: UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                            color: Colors.grey,
                                                            width: 1.0,
                                                          ),
                                                        ),
                                                        focusedBorder: UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                            color:
                                                            Theme.of(context).accentColor,
                                                            width: 1.0,
                                                          ),
                                                        ),
                                                      ))),
                                            ),

                                            SizedBox(height: 15),
                                            Text(S.of(context).select_your_type),
                                            Container(
                                              width: double.infinity,

                                              child: DropdownButtonFormField(
                                                  value: _value,
                                                  isExpanded: true,
                                                  validator: (value) => value == null ? S.of(context).please_select : null,
                                                  focusColor: Theme.of(context).accentColor,

                                                  items: dropDownList.map((DropDownModel map) {
                                                    return new DropdownMenuItem(
                                                      value: map.id,
                                                      child: new Text(map.name, style: new TextStyle(color: Colors.black)),
                                                    );
                                                  }).toList(),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      widget.con.shopTypeData.shopTypeId = value;
                                                      _value = value;
                                                    });
                                                  }),
                                            ),
                                            SizedBox(height: 20),

                                            // ignore: deprecated_member_use
                                            FlatButton(
                                              onPressed: (){
                                                showDialog(
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    return AlertDialog(
                                                      titlePadding: const EdgeInsets.all(0.0),
                                                      contentPadding: const EdgeInsets.all(0.0),
                                                      content: SingleChildScrollView(
                                                        child: ColorPicker(
                                                          pickerColor: currentColor,
                                                          onColorChanged: changeColor,
                                                          colorPickerWidth: 300.0,
                                                          pickerAreaHeightPercent: 0.7,
                                                          enableAlpha: true,
                                                          displayThumbColor: true,
                                                          showLabel: true,
                                                          paletteType: PaletteType.hsv,
                                                          pickerAreaBorderRadius: const BorderRadius.only(
                                                            topLeft: const Radius.circular(2.0),
                                                            topRight: const Radius.circular(2.0),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );

                                              },
                                              color:currentColor,
                                              child: Text(S.of(context).dashboard_color),
                                              textColor: Colors.white70,


                                            ),
                                            SizedBox(height: 20),

                                            Text(
                                              S.of(context).select_your_preview_icon,
                                              style: Theme.of(context).textTheme.bodyText1,
                                            ),
                                            SizedBox(height: 10),
                                            widget.pageType=='add'?Container(
                                              width: size.width > 670 ? 180:200,
                                              height: size.height > 670 ? 180: 200,
                                              child:  GestureDetector(
                                                onTap: () {
                                                  Imagepickerbottomsheet('type1');
                                                },
                                                child: _image == null?Image(image:AssetImage('assets/img/image_placeholder.png'),
                                                    height: double.infinity,
                                                    width:double.infinity,
                                                    fit:BoxFit.fill
                                                ):  Image.file(_image),
                                              ), ):Container(
                                              color: Theme.of(context).primaryColor,
                                              width: MediaQuery.of(context).size.width * 0.2,
                                              height: MediaQuery.of(context).size.width * 0.10,
                                              child: GestureDetector(
                                                onTap: () {
                                                  Imagepickerbottomsheet('type1');
                                                },
                                                child: _image == null?Image(image:NetworkImage(widget.shopType.previewImage),
                                                  height: double.infinity,
                                                  width:double.infinity,
                                                  fit: BoxFit.fill,
                                                ): Image.file(_image),),
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              S.of(context).select_your_preview_image,
                                              style: Theme.of(context).textTheme.bodyText1,
                                            ),
                                            SizedBox(height: 10),
                                            widget.pageType=='add'?Container(
                                              width: size.width > 670 ? 180:200,
                                              height: size.height > 670 ? 180: 200,
                                              child:  GestureDetector(
                                                onTap: () {
                                                  Imagepickerbottomsheet('type2');
                                                },
                                                child: _image2 == null?Image(image:AssetImage('assets/img/image_placeholder.png'),
                                                    height: double.infinity,
                                                    width:double.infinity,
                                                    fit:BoxFit.fill
                                                ):Image.file(_image2) ,
                                              ), ):Container(
                                              color: Theme.of(context).primaryColor,
                                              width: MediaQuery.of(context).size.width * 0.2,
                                              height: MediaQuery.of(context).size.width * 0.10,
                                              child: GestureDetector(
                                                onTap: () {
                                                  Imagepickerbottomsheet('type2');
                                                },
                                                child: _image == null?Image(image:NetworkImage(widget.shopType.previewImage),
                                                  height: double.infinity,
                                                  width:double.infinity,
                                                  fit: BoxFit.fill,
                                                ):Image.file(_image2) ,),
                                            ),

                                            SizedBox(height: 30),


                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                // ignore: deprecated_member_use
                                                FlatButton(
                                                  onPressed: () {

                                                    widget.pageType=='add'?widget.con.addEdFocusType(context,'null','do_add'):widget.con.addEdFocusType(context,widget.shopType.id,'update');


                                                  },
                                                  padding: EdgeInsets.only(top:15,bottom:15,left:40,right:40),
                                                  color: Theme.of(context).accentColor.withOpacity(1),
                                                  shape: StadiumBorder(),
                                                  child: Text(
                                                    S.of(context).submit,
                                                    style: Theme.of(context).textTheme.headline6.merge(
                                                        TextStyle(
                                                            color: Theme.of(context)
                                                                .primaryColorLight)),
                                                  ),
                                                ),
                                              ],
                                            ),

                                            SizedBox(height:30),
                                          ]
                                      ),

                                    ),
                                  ),
                                ]
                            ),
                          ),),
                      )
                  ),




                ],
              ),
            ),
          ),

        )

    );

  }



  // ignore: non_constant_identifier_names
  Imagepickerbottomsheet(type) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                new ListTile(
                  leading: new Icon(Icons.camera),
                  title: new Text(S.of(context).camera),
                  onTap: () => getImage(type),
                ),
                new ListTile(
                  leading: new Icon(Icons.image),
                  title: new Text(S.of(context).gallery),
                  onTap: () => getImagegaller(type),
                ),
              ],
            ),
          );
        });
  }

  File _image;
  File _image2;
  int currStep = 0;
  final picker = ImagePicker();

  Future getImage(type) async {
    final pickedFile = await picker.getImage(source: ImageSource.camera, maxHeight: 480, maxWidth: 640);
    setState(() {
      if (pickedFile != null) {
        if(type=='type1') {
          _image = File(pickedFile.path);
          widget.con.shopTypeData.previewImage = _image;
        }else{
          _image2 = File(pickedFile.path);
          widget.con.shopTypeData.coverImage = _image2;
        }

        Navigator.of(context).pop();
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImagegaller(type) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        if(type=='type1') {
          _image = File(pickedFile.path);
          widget.con.shopTypeData.previewImage = _image;
        }else{
          _image2 = File(pickedFile.path);
          widget.con.shopTypeData.coverImage = _image2;
        }
       // widget.con.categoryData.uploadImage = pickedFile;

        Navigator.of(context).pop();
      } else {
        print('No image selected.');
      }
    });
  }



}
