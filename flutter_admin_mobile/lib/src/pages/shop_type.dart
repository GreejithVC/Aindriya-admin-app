import 'package:flutter/material.dart';
import '../../generated/l10n.dart';
import '../controllers/secondary_controller.dart';
import '../elements/EmptyOrdersWidget.dart';
import '../elements/ShopTypeBoxWidget.dart';
import '../elements/ShopDetailsWidget.dart';
import '../models/shoptype.dart';
import 'package:mvc_pattern/mvc_pattern.dart';



import 'package:responsive_ui/responsive_ui.dart';

class ShopTypes extends StatefulWidget {
  @override
  _ShopTypesState createState() => _ShopTypesState();
}

class _ShopTypesState extends StateMVC<ShopTypes>  {
  SecondaryController _con;
  _ShopTypesState() : super(SecondaryController()) {
    _con = controller;
  }

  @override
  // ignore: must_call_super
  void initState()  {
    _con.listenForShopTypeList();
  }

  callback(){


  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color:Theme.of(context).primaryColor.withOpacity(0.6),
      child: SingleChildScrollView(
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Div(
                colS: 12,
                colM: 12,
                colL: 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    SizedBox(height: 20),
                    Container(
                      margin: EdgeInsets.only(left: 30.0, top: 25.0, right: 30, bottom: 10.0),
                      child:Wrap(
                          alignment: WrapAlignment.spaceBetween,
                          children:[
                            Div(
                                colS:6,
                                colM:6,
                                colL:6,
                                child:Wrap(
                                    children:[
                                      Text(
                                        S.of(context).manage_shop_type,
                                        style: Theme.of(context).textTheme.subtitle1,
                                      ),
                                      SizedBox(width:10),
                                      Container(
                                        height: 30.0,
                                        width: 30.0,
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          shape: BoxShape.circle,
                                        ),
                                        child: IconButton(
                                          padding: EdgeInsets.zero,
                                          color: Colors.white,
                                          icon: const Icon(Icons.add),
                                          iconSize: 30.0,
                                          //color: Palette.facebookBlue,
                                          onPressed: () {
                                            AddEdPopupHelper.exit(context, _con, this.callback, ShopTypeModel(), 'add');
                                          },
                                        ),
                                      ),

                                    ]
                                )
                            ),


                          ]
                      ),
                    ),


                    SizedBox(height: 20),
                    _con.shopTypeList.isEmpty?EmptyOrdersWidget():Container(
                      margin: EdgeInsets.only(left:20, right: 20,bottom:30),
                      child:  Wrap(
                        children: List.generate(_con.shopTypeList.length, (index) {
                          ShopTypeModel _shopTypeData = _con.shopTypeList.elementAt(index);
                          return   InkWell(
                               onTap: () {
                                 Imagepickerbottomsheet(_con.shopTypeList[index].id, _con.shopTypeList[index]);
                               },
                            child:ShopTypeBoxWidget(shopTypeData: _shopTypeData,),
                                  );
                        }),),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );



  }

  // ignore: non_constant_identifier_names
  Imagepickerbottomsheet(id, Details) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                new ListTile(
                  leading: new Icon(Icons.adjust_sharp),
                  title: new Text('ID: $id'),
                  onTap: () => {
                    Navigator.pop(context),

                  },
                ),
                new ListTile(
                  leading: new Icon(Icons.edit),
                  title: new Text(S.of(context).edit),
                  onTap: () => {
                    Navigator.pop(context),
                  AddEdPopupHelper.exit(context,_con, this.callback, Details,'edit'),
                  },
                ),
                new ListTile(
                  leading: new Icon(Icons.delete),
                  title: new Text(S.of(context).delete),
                  onTap: ()  async{
                     await _con.delete('shopFocusType',id);

                    Navigator.pop(context);
                    setState(() {_con.shopTypeList.clear();});

                  },
                ),
              ],
            ),
          );
        });
  }
}




class AddEdPopupHelper {

  static exit(context,con, callback, details, pageType) => showDialog(context: context, builder: (context) =>  ShopDetailsWidget(con: con,callback: callback,shopType: details, pageType: pageType, ));
}