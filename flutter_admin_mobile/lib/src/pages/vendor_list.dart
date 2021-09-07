import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import '../controllers/primaryuser_controller.dart';
import '../elements/EmptyOrdersWidget.dart';
import '../elements/VendorTabsWidget.dart';
import '../models/vendorAll.dart';
import '../repository/user_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:responsive_ui/responsive_ui.dart';
import '../../generated/l10n.dart';

class VendorList extends StatefulWidget {
  @override
  _VendorListState createState() => _VendorListState();
}

class _VendorListState extends StateMVC<VendorList>  with SingleTickerProviderStateMixin{
  //TabController _tabController;

  PrimaryUserController _con;
  _VendorListState() : super(PrimaryUserController()) {
    _con = controller;
  }
  bool status = false;
  @override
  void initState() {
    //_tabController = TabController(length: 3, vsync: this);
    super.initState();
    _con.listenForVendor();
  }

  tabMaker() {
    // ignore: deprecated_member_use
    List<Tab> tabs = List();

    _con.vendorList.forEach((element) {
      tabs.add(Tab(
        text: element.shopType,
      ));
    });
    return tabs;
  }


  @override
  void dispose() {
    super.dispose();
    //_tabController.dispose();

  }
  @override
  Widget build(BuildContext context) {
    return _con.vendorList.isEmpty? EmptyOrdersWidget() : DefaultTabController(
    length:_con.vendorList.length,
     child: Padding(
      padding: EdgeInsets.only(top:0),
      child:Column(
        children: [
          // give the tab bar a height [can change hheight to preferred height]

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
                                    S.of(context).vendor_list,
                                  style: Theme.of(context).textTheme.headline4
                                ),
                              ),
                              SizedBox(width:10),

                              SizedBox(width:10),
                InkWell(
                    onTap:() async {
                      // ignore: deprecated_member_use
                      var url = '${GlobalConfiguration().getString('api_base_url')}api_admin/export_action/vendor/${currentUser.value.id}';

                      if (await canLaunch(url)) {
                        await launch(
                          url,
                          forceSafariVC: false,
                        );
                      }
                    },
                    child: Padding(
                                  padding:EdgeInsets.only(left:8,top:5),
                                  child:Image(image:AssetImage('assets/img/excel.png'),
                                      width:25,height:25
                                  )
                              ),
                ),
                            ]
                        )
                    ),
                    Div(
                      colS:6,
                      colM:6,
                      colL:6,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children:[
                            Padding(
                              padding:EdgeInsets.only(right:30),
                              child:IconButton(
                                onPressed:() async {
                                },
                                icon:Icon(Icons.search, color: Theme.of(context).accentColor),
                              ),
                            ),


                          ]
                      ),
                    ),

                  ]
              ),
            ),
          ),

          Container(
            width: double.infinity,
            height: 45,
            decoration:BoxDecoration(
              //color:Colors.white70,
                color:Theme.of(context).primaryColor.withOpacity(0.6)
            ),
            child: TabBar(
             // controller: _tabController,
              // give the indicator a decoration (color and border radius)
              indicatorWeight: 2.0,
              isScrollable: true,
              indicatorColor: Color(0xFF5e078e),
              unselectedLabelColor: Colors.grey,
              labelColor: Colors.teal,
              tabs: tabMaker()
            ),
          ),
          // tab bar view here
          SizedBox(height:5),
          Expanded(
            child: TabBarView(
             // controller: _tabController,
              children: List.generate(
                _con.vendorList.length,
                    (index) {
                  VendorAllModel _vendorDetails =_con.vendorList.elementAt(index);

                  return  VendorTabsWidget(type: 1,vendorList: _vendorDetails.vendor,con: _con,);
                },
              ),

            ),
          ),
        ],
      ),
     ),
    );



  }
}
