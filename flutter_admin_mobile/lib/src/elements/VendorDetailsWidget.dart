import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../components/card.dart';
import '../controllers/user_controller.dart';
import 'package:responsive_ui/responsive_ui.dart';
import '../../generated/l10n.dart';

// ignore: must_be_immutable
class VendorDetailsWidget extends StatefulWidget {
  VendorDetailsWidget({this.con});
  UserController con;
  @override
  _VendorDetailsWidgetState createState() => _VendorDetailsWidgetState();
}

class _VendorDetailsWidgetState extends State<VendorDetailsWidget>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 3);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
      margin:EdgeInsets.only(bottom:25),
      padding: EdgeInsets.only(bottom: 20),
      child: Column(

        children: [
          TabBar(
            controller: _tabController,
            indicatorColor: Color(0xFF5e078e),
            unselectedLabelColor: Colors.grey,
            labelColor: Colors.black,
            tabs: [
              Tab(
                child: Text(S.of(context).general_details),
              ),
              Tab(
                child: Text(S.of(context).bank_details),
              ),
              Tab(
                child: Text(S.of(context).password_change),
              ),
            ],
          ),
          SizedBox(
            height: 500,
            child: TabBarView(
              controller: _tabController,
              physics: NeverScrollableScrollPhysics(),
              children: [
               Container(
               child:SingleChildScrollView(
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[

                    Wrap(
                      children:[
                        Div(
                          colS:4,
                          colM:4,
                          colL:3,
                          child:Padding(
                            padding: EdgeInsets.only(top:20,left:20,right:20,bottom:10),
                            child: Container(
                                width: double.infinity,
                                child:Text(S.of(context).name,style: Theme.of(context).textTheme.bodyText1,)
                                ),
                          ),
                        ),
                        Div(
                          colS:8,
                          colM:8,
                          colL:9,
                          child:Padding(
                            padding: EdgeInsets.only(top:20,left:20,right:20,bottom:10),
                            child: Container(
                                width: double.infinity,

                                child: Text(widget.con.profileDetails.general.name,style: Theme.of(context).textTheme.subtitle2,)
                            ),
                          ),
                        ),

                        Div(
                          colS:4,
                          colM:4,
                          colL:3,
                          child:Padding(
                            padding: EdgeInsets.only(top:12,left:20,right:20,bottom:10),
                            child: Container(
                                width: double.infinity,

                                child: Text(S.of(context).shop_name,style: Theme.of(context).textTheme.bodyText1,)),
                          ),
                        ),
                        Div(
                          colS:8,
                          colM:8,
                          colL:9,
                          child:Padding(
                            padding: EdgeInsets.only(top:12,left:20,right:20,bottom:10),
                            child: Container(
                                width: double.infinity,

                                child: Text(widget.con.profileDetails.general.shopName,style: Theme.of(context).textTheme.subtitle2,)),
                          ),
                        ),
                        Div(
                          colS:4,
                          colM:4,
                          colL:3,
                          child:Padding(
                            padding: EdgeInsets.only(top:12,left:20,right:20,bottom:10),
                            child: Container(
                                width: double.infinity,

                                child: Text(S.of(context).subtitle,style: Theme.of(context).textTheme.bodyText1,)),
                          ),
                        ),
                        Div(
                          colS:8,
                          colM:8,
                          colL:9,
                          child:Padding(
                            padding: EdgeInsets.only(top:12,left:20,right:20,bottom:10),
                            child: Container(
                                width: double.infinity,

                                child: Text(widget.con.profileDetails.general.subTitle,style: Theme.of(context).textTheme.subtitle2,)),
                          ),
                        ),
                        Div(
                          colS:4,
                          colM:4,
                          colL:3,
                          child:Padding(
                            padding: EdgeInsets.only(top:12,left:20,right:20,bottom:10),
                            child: Container(
                                width: double.infinity,

                                child: Text(S.of(context).email,style: Theme.of(context).textTheme.bodyText1,)),
                          ),
                        ),
                        Div(
                          colS:8,
                          colM:8,
                          colL:9,
                          child:Padding(
                            padding: EdgeInsets.only(top:12,left:20,right:20,bottom:10),
                            child: Container(
                                width: double.infinity,

                                child: Text(widget.con.profileDetails.general.email,style: Theme.of(context).textTheme.subtitle2,)),
                          ),
                        ),

                        Div(
                          colS:4,
                          colM:4,
                          colL:3,
                          child:Padding(
                            padding: EdgeInsets.only(top:12,left:20,right:20,bottom:10),
                            child: Container(
                                width: double.infinity,

                                child: Text(S.of(context).phone,style: Theme.of(context).textTheme.bodyText1,)),
                          ),
                        ),
                        Div(
                          colS:8,
                          colM:8,
                          colL:9,
                          child:Padding(
                            padding: EdgeInsets.only(top:12,left:20,right:20,bottom:10),
                            child: Container(
                                width: double.infinity,

                                child: Text('${widget.con.profileDetails.general.phone}',style: Theme.of(context).textTheme.subtitle2,)),
                          ),
                        ),
                        Div(
                          colS:4,
                          colM:4,
                          colL:3,
                          child:Padding(
                            padding: EdgeInsets.only(top:12,left:20,right:20,bottom:10),
                            child: Container(
                                width: double.infinity,

                                child: Text(S.of(context).alternative_mobile,style: Theme.of(context).textTheme.bodyText1,)),
                          ),
                        ),
                        Div(
                          colS:8,
                          colM:8,
                          colL:9,
                          child:Padding(
                            padding: EdgeInsets.only(top:12,left:20,right:20,bottom:10),
                            child: Container(
                                width: double.infinity,

                                child: Text(widget.con.profileDetails.general.alternativeMobile,style: Theme.of(context).textTheme.subtitle2,)),
                          ),
                        ),
                        Div(
                          colS:4,
                          colM:4,
                          colL:3,
                          child:Padding(
                            padding: EdgeInsets.only(top:12,left:20,right:20,bottom:10),
                            child: Container(
                                width: double.infinity,

                                child: Text(S.of(context).open_time,style: Theme.of(context).textTheme.bodyText1,)),
                          ),
                        ),
                        Div(
                          colS:8,
                          colM:8,
                          colL:9,
                          child:Padding(
                            padding: EdgeInsets.only(top:12,left:20,right:20,bottom:10),
                            child: Container(
                                width: double.infinity,

                                child: Text( widget.con.profileDetails.general.openTime,style: Theme.of(context).textTheme.subtitle2,)),
                          ),
                        ),
                        Div(
                          colS:4,
                          colM:4,
                          colL:3,
                          child:Padding(
                            padding: EdgeInsets.only(top:12,left:20,right:20,bottom:10),
                            child: Container(
                                width: double.infinity,

                                child: Text(S.of(context).close_time,style: Theme.of(context).textTheme.bodyText1,)),
                          ),
                        ),
                        Div(
                          colS:8,
                          colM:8,
                          colL:9,
                          child:Padding(
                            padding: EdgeInsets.only(top:12,left:20,right:20,bottom:10),
                            child: Container(
                                width: double.infinity,

                                child: Text(widget.con.profileDetails.general.closeTime,style: Theme.of(context).textTheme.subtitle2,)),
                          ),
                        ),
                        Div(
                          colS:4,
                          colM:4,
                          colL:3,
                          child:Padding(
                            padding: EdgeInsets.only(top:12,left:20,right:20,bottom:10),
                            child: Container(
                                width: double.infinity,

                                child: Text(S.of(context).started_year,style: Theme.of(context).textTheme.bodyText1,)),
                          ),
                        ),
                        Div(
                          colS:8,
                          colM:8,
                          colL:9,
                          child:Padding(
                            padding: EdgeInsets.only(top:12,left:20,right:20,bottom:10),
                            child: Container(
                                width: double.infinity,

                                child: Text( widget.con.profileDetails.general.startedYear,style: Theme.of(context).textTheme.subtitle2,)),
                          ),
                        ),
                        Div(
                          colS:4,
                          colM:4,
                          colL:3,
                          child:Padding(
                            padding: EdgeInsets.only(top:12,left:20,right:20,bottom:10),
                            child: Container(
                                width: double.infinity,

                                child: Text(S.of(context).description,style: Theme.of(context).textTheme.bodyText1,)),
                          ),
                        ),
                        Div(
                          colS:8,
                          colM:8,
                          colL:9,
                          child:Padding(
                            padding: EdgeInsets.only(top:12,left:20,right:20,bottom:10),
                            child: Container(
                                width: double.infinity,

                                child: Text(widget.con.profileDetails.general.description,style: Theme.of(context).textTheme.subtitle2,)),
                          ),
                        ),
                        Div(
                          colS:4,
                          colM:4,
                          colL:3,
                          child:Padding(
                            padding: EdgeInsets.only(top:12,left:20,right:20,bottom:10),
                            child: Container(
                                width: double.infinity,

                                child: Text(S.of(context).status
                                  ,style: Theme.of(context).textTheme.bodyText1,)),
                          ),
                        ),
                        Div(
                          colS:8,
                          colM:8,
                          colL:9,
                          child:Padding(
                            padding: EdgeInsets.only(top:12,left:20,right:20,bottom:10),
                            child: Container(
                                width: double.infinity,

                                child: Text('Success',style: Theme.of(context).textTheme.subtitle2,)),
                          ),
                        ),

                      ]
                    ),


                  ]
                ),
          ),
               ),
                Container(
                    child:SingleChildScrollView(
                      child:Column(
                        children:[
                          Wrap(
                              children:[
                                Div(
                                  colS:4,
                                  colM:4,
                                  colL:3,
                                  child:Padding(
                                    padding: EdgeInsets.only(top:20,left:20,right:20,bottom:10),
                                    child: Container(
                                        width: double.infinity,

                                        child: Text(S.of(context).bank_name,style: Theme.of(context).textTheme.bodyText1,)),
                                  ),
                                ),
                                Div(
                                  colS:8,
                                  colM:8,
                                  colL:9,
                                  child:Padding(
                                    padding: EdgeInsets.only(top:20,left:20,right:20,bottom:10),
                                    child: Container(
                                        width: double.infinity,

                                        child: Text(widget.con.profileDetails.bankDetails.bankName,style: Theme.of(context).textTheme.subtitle2,)),
                                  ),
                                ),
                                Div(
                                  colS:4,
                                  colM:4,
                                  colL:3,
                                  child:Padding(
                                    padding: EdgeInsets.only(top:12,left:20,right:20,bottom:10),
                                    child: Container(
                                        width: double.infinity,

                                        child: Text(S.of(context).account_number,style: Theme.of(context).textTheme.bodyText1,)),
                                  ),
                                ),
                                Div(
                                  colS:8,
                                  colM:8,
                                  colL:9,
                                  child:Padding(
                                    padding: EdgeInsets.only(top:12,left:20,right:20,bottom:10),
                                    child: Container(
                                        width: double.infinity,

                                        child: Text(widget.con.profileDetails.bankDetails.accountNo,style: Theme.of(context).textTheme.subtitle2,)),
                                  ),
                                ),
                                Div(
                                  colS:4,
                                  colM:4,
                                  colL:3,
                                  child:Padding(
                                    padding: EdgeInsets.only(top:12,left:20,right:20,bottom:10),
                                    child: Container(
                                        width: double.infinity,

                                        child: Text(S.of(context).swift_code,style: Theme.of(context).textTheme.bodyText1,)),
                                  ),
                                ),
                                Div(
                                  colS:8,
                                  colM:8,
                                  colL:9,
                                  child:Padding(
                                    padding: EdgeInsets.only(top:12,left:20,right:20,bottom:10),
                                    child: Container(
                                        width: double.infinity,

                                        child: Text(widget.con.profileDetails.bankDetails.swiftCode,style: Theme.of(context).textTheme.subtitle2,)),
                                  ),
                                ),



                              ]
                          ),
                        ]
                      )
                    )
                ),
                Container(
                    child:SingleChildScrollView(
                        child:Column(
                            children:[
                              Wrap(
                                  children:[
                                    Div(
                                      colS: 12,
                                      colM:12,
                                      colL:12,
                                      child:Padding(
                                        padding: EdgeInsets.only(top:10,left:20,right:20),
                                        child: Container(
                                            width: double.infinity,

                                            child: TextField(
                                                textAlign: TextAlign.left,
                                                autocorrect: true,
                                                obscureText: true,
                                                decoration: InputDecoration(
                                                  labelText: S.of(context).current_password,
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
                                    ),
                                    Div(
                                      colS: 12,
                                      colM:6,
                                      colL:6,
                                      child:Padding(
                                        padding: EdgeInsets.only(top:10,left:20,right:20),
                                        child: Container(
                                            width: double.infinity,

                                            child: TextField(
                                                textAlign: TextAlign.left,
                                                autocorrect: true,
                                                keyboardType: TextInputType.text,
                                                obscureText: true,
                                                decoration: InputDecoration(
                                                  labelText: S.of(context).new_password,
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
                                    ),

                                    Div(
                                      colS: 12,
                                      colM:6,
                                      colL:6,
                                      child:Padding(
                                        padding: EdgeInsets.only(top:10,left:20,right:20),
                                        child: Container(
                                            width: double.infinity,

                                            child: TextField(
                                                textAlign: TextAlign.left,
                                                autocorrect: true,
                                                keyboardType: TextInputType.text,
                                                obscureText: true,
                                                decoration: InputDecoration(
                                                  labelText: S.of(context).confirm_password,
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
                                    ),



                                  ]
                              ),
                            ]
                        )
                    )
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
