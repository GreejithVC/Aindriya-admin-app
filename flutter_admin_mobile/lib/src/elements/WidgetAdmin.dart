import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../controllers/user_controller.dart';
import '../repository/user_repository.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'CardWidget.dart';
import '../../generated/l10n.dart';

// ignore: must_be_immutable
class ProfileTweetsAdmin extends StatefulWidget {
  ProfileTweetsAdmin({this.con});
  @override
  _ProfileTweetsAdminState createState() => _ProfileTweetsAdminState();
  UserController con;
}

class _ProfileTweetsAdminState extends State<ProfileTweetsAdmin>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {

    _tabController = TabController(vsync: this, length: 2);

    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AppCard(
      margin:EdgeInsets.only(left:15,right:15,bottom:25),
      padding: EdgeInsets.only(bottom: 20),
      child: widget.con.profileDetails.general?.email ==''?Container():Column(

        children: [
          TabBar(
            controller: _tabController,
            indicatorColor: Color(0xFF5e078e),
            unselectedLabelColor: Colors.grey,
            //labelColor: Colors.black,
            labelStyle: Theme.of(context).textTheme.bodyText1,
            tabs: [
              Tab(
                child: Text(S.of(context).general_details),
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
            child:Form(
                  key: widget.con.generalFormKey,
                  child:SingleChildScrollView(
                    child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[

                          Wrap(
                              children:[
                                Div(
                                  colS: 12,
                                  colM:6,
                                  colL:6,
                                  child:Padding(
                                    padding: EdgeInsets.only(top:10,left:20,right:20),
                                    child: Container(
                                        width: double.infinity,

                                        child:  TextFormField(
                                            onSaved: (input) => widget.con.userData.name = input,
                                            initialValue: currentUser.value.name,
                                            validator: (input) =>  input.length<= 1 ? S.of(context).provide_your_name : null,
                                            textAlign: TextAlign.left,
                                            autocorrect: true,
                                            keyboardType: TextInputType.text,
                                            decoration: InputDecoration(
                                              labelText: S.of(context).name,
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

                                        child: TextFormField(

                                            onSaved: (input) => widget.con.userData.email = input,
                                            initialValue: currentUser.value.email,
                                            validator: (input) => !input.contains('@') ? S.of(context).should_be_valid_email : null,
                                            textAlign: TextAlign.left,
                                            autocorrect: true,
                                            keyboardType: TextInputType.text,
                                            enabled: false,
                                            decoration: InputDecoration(
                                              labelText: S.of(context).email,
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

                                        child:  TextFormField(
                                            onSaved: (input) =>   widget.con.userData.phone = input,
                                            initialValue: currentUser.value.phone,
                                            validator: (input) =>  input.length<= 1 ? S.of(context).please_provide_subtitle : null,

                                            textAlign: TextAlign.left,
                                            autocorrect: true,
                                            keyboardType: TextInputType.text,

                                            decoration: InputDecoration(
                                              labelText: S.of(context).phone,
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

                                        child:  TextFormField(
                                            onSaved: (input) =>   widget.con.userData.address = input,
                                            initialValue: currentUser.value.address,
                                            textAlign: TextAlign.left,
                                            autocorrect: true,
                                            keyboardType: TextInputType.text,

                                            decoration: InputDecoration(
                                              labelText: S.of(context).address,
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
                             SizedBox(height:40),
                          InkWell(
                              onTap: () {


                              },
                              child: Container(

                                padding:EdgeInsets.only(left:size.width * 0.16,right:size.width * 0.16),
                                child: Container(
                                  width: double.infinity,
                                  height: 45.0,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).accentColor,
                                    borderRadius: BorderRadius.circular(30),
                                    /*borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  topRight: Radius.circular(40))*/
                                  ),
                                  // ignore: deprecated_member_use
                                  child: FlatButton(
                                    onPressed: () {
                                      widget.con.updateProfileAdmin();
                                    },
                                    child: Center(
                                        child: Text(
                                          S.of(context).submit,
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )),
                                  ),
                                ),
                              ))

                        ]
                    ),
                  ),
                  ),
                ),

                Container(
                    child:SingleChildScrollView(
                      child:Form(
                        key: widget.con.loginFormKey,
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

                                            child: TextFormField(
                                                textAlign: TextAlign.left,
                                                autocorrect: true,
                                                obscureText: true,
                                                onSaved: (input) => widget.con.prePassword = input,
                                                validator: (input) => input.length < 1 ? 'Please enter your current password' : null,
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

                                            child: TextFormField(
                                                textAlign: TextAlign.left,
                                                autocorrect: true,
                                                keyboardType: TextInputType.text,
                                                obscureText: true,

                                                validator: (input) => input.length < 1 ? 'Please enter your new password' : null,
                                                onSaved: (input) => widget.con.password = input,
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

                                            child: TextFormField(
                                                textAlign: TextAlign.left,
                                                autocorrect: true,
                                                keyboardType: TextInputType.text,
                                                obscureText: true,
                                                onSaved: (input) => widget.con.rePassword = input,
                                                validator: (input) => input.length < 1 ? 'Please enter your confirm password' : null,
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

                              SizedBox(height:40),


                              Container(
                                padding:EdgeInsets.only(left:size.width * 0.16,right:size.width * 0.16),
                                child: Container(
                                  width: double.infinity,
                                  height: 45.0,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).accentColor,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  // ignore: deprecated_member_use
                                  child: FlatButton(
                                    onPressed: () {
                                      widget.con.passwordUpdate();
                                    },
                                    child: Center(
                                        child: Text(
                                          S.of(context).submit,
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )),
                                  ),
                                ),
                              )

                            ]
                        ),
                      ),
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
