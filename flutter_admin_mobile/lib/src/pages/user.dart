import 'package:flutter/material.dart';
import '../controllers/primaryuser_controller.dart';
import '../elements/EmptyOrdersWidget.dart';
import '../elements/UserBoxWidget.dart';
import '../models/user_model.dart';
import 'searchbox_user.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:url_launcher/url_launcher.dart';
import '../repository/user_repository.dart';
import '../../generated/l10n.dart';
import 'package:responsive_ui/responsive_ui.dart';

class User extends StatefulWidget {
  @override
  _UserState createState() => _UserState();
}

class _UserState extends StateMVC<User> {
  PrimaryUserController _con;

  _UserState() : super(PrimaryUserController()) {
    _con = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _con.listenForUser();
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
                                        S.of(context).manage_users,
                                        style: Theme.of(context).textTheme.headline4,
                                      ),
                                      SizedBox(width:10),
                                      InkWell(
                                        onTap:() async {
                                          // ignore: deprecated_member_use
                                          var url = '${GlobalConfiguration().getString('api_base_url')}api_admin/export_action/user/${currentUser.value.id}';

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
                                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchBoxUser(searchType: 'category',userList: _con.userList,)));
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


                    SizedBox(height: 20),
                    _con.userList.isEmpty?EmptyOrdersWidget():Container(
                      margin: EdgeInsets.only(left:20, right: 20,bottom:30),
                      child: Wrap(
                        children: List.generate(_con.userList.length, (index) {
                          UserModel _userData = _con.userList.elementAt(index);
                          return UserBoxWidget(userData: _userData,);
                        }
                        ),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
