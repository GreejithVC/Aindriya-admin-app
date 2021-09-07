import 'package:flutter/material.dart';
import '../controllers/secondary_controller.dart';
import '../elements/BannerPopupWidget.dart';
import '../elements/BannerWidget.dart';
import '../../generated/l10n.dart';
import '../models/banner.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';

class Banners extends StatefulWidget {
  @override
  _BannersState createState() => _BannersState();
}

class _BannersState extends StateMVC<Banners>  with SingleTickerProviderStateMixin {

  SecondaryController _con;

  _BannersState() : super(SecondaryController()) {
    _con = controller;
  }

  TabController _tabController;
  bool isSwitched = false;

  bool status = false;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top:0),
      child:Column(
        children: [

          Container(
            //color:Colors.white70,
            color:Theme.of(context).primaryColor.withOpacity(0.6),
            child:Container(
            margin: EdgeInsets.only(left: 20.0, top: 40.0, right: 20, bottom: 10.0),

            child:Wrap(
                alignment: WrapAlignment.spaceBetween,
                children:[
                  Div(
                      colS:6,
                      colM:6,
                      colL:6,
                      child:Wrap(
                          children:[
                            Padding(
                              padding: EdgeInsets.only(top:7),
                              child:Text(
                                S.of(context).banner,
                                style: Theme.of(context).textTheme.headline4,
                              ),
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
                                  AddBannerHelper.exit(context,_con,BannerModel(),'add');
                                },
                              ),
                            )
                          ]
                      )
                  ),
                ]
            ),
          ),
    ),

          Container(
            width: double.infinity,
            height: 45,
            decoration:BoxDecoration(
                color:Theme.of(context).primaryColor.withOpacity(0.6)
            ),
            child: TabBar(
              controller: _tabController,
              // give the indicator a decoration (color and border radius)
              indicatorWeight: 2.0,
              isScrollable: true,
              indicatorColor: Color(0xFF5e078e),
              unselectedLabelColor: Colors.grey,
              labelColor: Colors.teal,
              tabs: [
                // first tab [you can add an icon using the icon property]
                Tab(
                  child:Container(
                   child: Text('Top Banner',style:TextStyle(fontWeight:FontWeight.w600)),
                  )
                ),

                // second tab [you can add an icon using the icon property]
                Tab(
                    child:Container(
                      child: Text('Offer Banner',style:TextStyle(fontWeight:FontWeight.w600)),
                    )
                ),
                Tab(
                    child:Container(
                      child: Text('Bottom Banner',style:TextStyle(fontWeight:FontWeight.w600)),
                    )
                ),

              ],
            ),
          ),
          // tab bar view here
          SizedBox(height:5),
          Expanded(

            child: TabBarView(
              controller: _tabController,
              children: [


                BannerWidget(typeID: 1, con: _con,),
                BannerWidget(typeID: 2,con: _con,),
                BannerWidget(typeID: 3,con: _con,),







              ],
            ),
          ),
        ],
      ),
    );


  }



}

class AddBannerHelper {

  static exit(context,con,details,pageType) => showDialog(context: context, builder: (context) =>  BannerPopup(con: con,details: details,pageType: pageType,));
}

