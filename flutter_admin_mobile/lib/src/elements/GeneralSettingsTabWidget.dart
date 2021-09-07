import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../components/card.dart';
import '../controllers/user_controller.dart';
import '../models/Dropdown.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
import 'package:responsive_ui/responsive_ui.dart';




// ignore: must_be_immutable
class GeneraSettingsTabsWidget extends StatefulWidget {
  GeneraSettingsTabsWidget({Key key, this.con}) : super(key: key);
  UserController con;
  @override
  _GeneraSettingsTabsWidgetState createState() => _GeneraSettingsTabsWidgetState();
}


class _GeneraSettingsTabsWidgetState extends StateMVC<GeneraSettingsTabsWidget>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  String value;
  bool status = false;



  // ignore: non_constant_identifier_names
  bool smtp_status = false;
  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 4);

    widget.con.listenForDropdownNC('currency_method', 'currency_name');
    widget.con.adminPayment.currency = widget.con.settingDetails.payment.currency;
    widget.con.adminPayment.currencyPosition = widget.con.settingDetails.payment.currencyPosition;
    super.initState();
  }




  int checkedItem = 0;
  Widget checkbox(String title, bool boolValue) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Wrap(
          children: [
            Checkbox(
              value: boolValue,
              onChanged: (bool value) {
                /// manage the state of each value
                setState(() {
                  switch (title) {
                    case "Smtp Status":
                      smtp_status = value;
                      break;


                  }
                });
              },
            ),
            Padding(
              padding: EdgeInsets.only(top:13),
              child: Text(title,style:Theme.of(context).textTheme.bodyText1),
            ),

          ],
        )


      ],
    );
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
                child: Text(S.of(context).general_settings),
              ),
              Tab(
                child: Text(S.of(context).payment_settings),
              ),
              Tab(
                child: Text('Smtp Settings'),
              ),
              Tab(
                child: Text(S.of(context).delivery_settings),
              )

            ],
          ),
          SizedBox(
            height: 500,
            child: TabBarView(
              controller: _tabController,
              physics: NeverScrollableScrollPhysics(),
              children: [

                Container(
                    child:Form(key:widget.con.adminGeneralFormKey,
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

                                            child: TextFormField(
                                                textAlign: TextAlign.left,
                                                autocorrect: true,
                                                keyboardType: TextInputType.text,
                                                initialValue: widget.con.settingDetails.general.systemName,
                                                onSaved: (input) => widget.con.adminGeneral.systemName = input,
                                                validator: (input) =>  input.length < 1 ? S.of(context).please_enter_system_name : null,
                                                decoration: InputDecoration(
                                                  labelText: S.of(context).system_name,
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
                                                keyboardType: TextInputType.emailAddress,
                                                validator: (input) => !input.contains('@') ? S.of(context).should_be_valid_email : null,
                                                onSaved: (input) => widget.con.adminGeneral.email = input,
                                                initialValue: widget.con.settingDetails.general.email,
                                                decoration: InputDecoration(
                                                  labelText: S.of(context).system_email,

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
                                                validator: (input) =>  input.length < 1 ? S.of(context).please_enter_system_title : null,
                                                onSaved: (input) => widget.con.adminGeneral.systemTitle = input,
                                                initialValue: widget.con.settingDetails.general.systemTitle,
                                                decoration: InputDecoration(
                                                  labelText: 'S.of(context).systemtitle',
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
                                                validator: (input) =>  input.length < 1 ? S.of(context).please_enter_api : null,
                                                onSaved: (input) => widget.con.adminGeneral.api = input,
                                                initialValue: widget.con.settingDetails.general.api,
                                                decoration: InputDecoration(
                                                  labelText: S.of(context).google_map_api,
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
                                                validator: (input) =>  input.length < 1 ? S.of(context).please_enter_phone_number : null,
                                                onSaved: (input) => widget.con.adminGeneral.phone = input,
                                                inputFormatters: <TextInputFormatter>[
                                                  FilteringTextInputFormatter.digitsOnly
                                                ],
                                                initialValue: widget.con.settingDetails.general.phone,
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
                                        padding: EdgeInsets.only(top:20,left:20,right:20),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(6),
                                            color: Theme.of(context).dividerColor,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: TextFormField(

                                              maxLines: 5,
                                              validator: (input) =>  input.length < 1 ? 'S.of(context).please_enter_address' : null,
                                              onSaved: (input) => widget.con.adminGeneral.address = input,
                                              initialValue: widget.con.settingDetails.general.address,
                                              decoration: InputDecoration.collapsed(
                                                hintText: S.of(context).address,

                                                hintStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2
                                                    .merge(TextStyle(color: Colors.grey)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Div(
                                      colS: 12,
                                      colM:6,
                                      colL:6,
                                      child:Padding(
                                        padding: EdgeInsets.only(top:20,left:20,right:20),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(6),
                                            color: Theme.of(context).dividerColor,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: TextFormField(
                                              onSaved: (input) => widget.con.adminGeneral.description = input,
                                              initialValue: widget.con.settingDetails.general.description,
                                              maxLines: 5,
                                              decoration: InputDecoration.collapsed(
                                                hintText: 'S.of(context).shortdescription',
                                                hintStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2
                                                    .merge(TextStyle(color: Colors.grey)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),




                                  ]
                              ),

                              SizedBox(height:40),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                      onTap: () {

                                      },
                                      child: Container(

                                        padding:EdgeInsets.only(left:20),
                                        child: Container(
                                          width: 200,
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
                                             widget.con.generalDetailsUpdate();


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
                                ],
                              ),
                            ]
                        ),
                      ),)

                ),
                Container(child:Form( key:widget.con.paymentFormKey,child:SingleChildScrollView(
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
                                    child:Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children:[

                                          Text(S.of(context).currency),
                                          Container(
                                            width: double.infinity,

                                            child: DropdownButton(
                                                value: widget.con.settingDetails.payment.currency,
                                                isExpanded: true,
                                                focusColor: Theme.of(context).accentColor,
                                                underline: Container(
                                                  color: Colors.grey[300],
                                                  height: 1.0,
                                                ),
                                                items: widget.con.dropDownList.map((DropDownModel map) {
                                                  return new DropdownMenuItem(
                                                    value: map.id,
                                                    child: new Text(map.name, style: new TextStyle(color: Colors.black)),
                                                  );
                                                }).toList(),
                                                onChanged: (value) {
                                                  setState(() {
                                                    widget.con.settingDetails.payment.currency = value;
                                                    widget.con.adminPayment.currency = value;
                                                  });
                                                }),
                                          ),
                                        ]
                                    ),
                                  ),
                                ),
                                Div(
                                    colS: 12,
                                    colM:6,
                                    colL:6,
                                    child:Container(
                                      padding:EdgeInsets.only(top:10,left:20,right:20),
                                      child:Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [


                                          Padding(
                                            padding:EdgeInsets.only(top:20,),
                                            child:Wrap(
                                              children: [

                                                Padding(
                                                  padding:EdgeInsets.only(top:10,),
                                                  child:Text(S.of(context).show_currency_in_the_right_of_price),
                                                ),
                                                SizedBox(width:10),
                                                Container(
                                                  width:65,
                                                  child: GestureDetector(
                                                    onTap: () {},
                                                    child: Switch(
                                                      value:  widget.con.settingDetails.payment.currencyPosition,
                                                      onChanged: (value){
                                                        setState(() {
                                                          widget.con.settingDetails.payment.currencyPosition = value;
                                                          widget.con.adminPayment.currencyPosition = value;
                                                        });
                                                      },
                                                      activeTrackColor: Colors.lightGreenAccent,
                                                      activeColor: Colors.green,

                                                    ),
                                                  ),),
                                              ],
                                            ),
                                          ),


                                        ],
                                      ),
                                    )
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
                                            onSaved: (input) => widget.con.adminPayment.razorpay = input,
                                            initialValue: widget.con.settingDetails.payment.razorpay,
                                            validator: (input) =>  input.length < 1 ? S.of(context).please_enter_the_value : null,


                                            decoration: InputDecoration(
                                              labelText: S.of(context).razor_pay,
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
                                            validator: (input) =>  input.length < 1 ? S.of(context).please_enter_the_value : null,
                                            onSaved: (input) => widget.con.adminPayment.strip = input,
                                            initialValue: widget.con.settingDetails.payment.strip,
                                            decoration: InputDecoration(
                                              labelText: S.of(context).strip,
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
                                            keyboardType: TextInputType.number,
                                            validator: (input) =>  input.length < 1 ? S.of(context).please_enter_the_value : null,
                                            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                                            onSaved: (input) => widget.con.adminPayment.minimumPurchase = input,
                                           initialValue: widget.con.settingDetails.payment.minimumPurchase,
                                            decoration: InputDecoration(
                                              labelText: S.of(context).minimum_purchase,

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
                                            keyboardType: TextInputType.number,
                                            validator: (input) =>  input.length < 1 ? S.of(context).please_enter_the_value : null,
                                            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                                            onSaved: (input) => widget.con.adminPayment.driverCommission = input,
                                            initialValue: widget.con.settingDetails.payment.driverCommission,
                                            decoration: InputDecoration(
                                              labelText: S.of(context).delivery_boy_commission,

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
                                            keyboardType: TextInputType.number,
                                            validator: (input) =>  input.length < 1 ? S.of(context).please_enter_the_value : null,
                                            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                                            onSaved: (input) => widget.con.adminPayment.cancelTimer = input,
                                            initialValue: widget.con.settingDetails.payment.cancelTimer,
                                            decoration: InputDecoration(
                                              labelText: S.of(context).cancellation_time_limit_minutes,

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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                  onTap: () {},
                                  child: Container(

                                    padding:EdgeInsets.only(left:20),
                                    child: Container(
                                      width: 200,
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
                                            widget.con.paymentDetailsUpdate();

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
                            ],
                          ),
                        ]
                    )
                ),),

                ),
                Container(child:Form(key:widget.con.smtpFormKey,
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
                                        padding: EdgeInsets.only(top:10,right:20),
                                        child:  ListTile(
                                          leading: checkbox(
                                            "Smtp Status",
                                            smtp_status,
                                          ),
                                        ),
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
                                                onSaved: (input) => widget.con.smtp.host = input,
                                                validator: (input) =>  input.length < 1 ? S.of(context).please_enter_the_value : null,
                                                initialValue: widget.con.settingDetails.smtp.host,

                                                decoration: InputDecoration(
                                                  labelText: 'Smtp Host',
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
                                                validator: (input) =>  input.length < 1 ? S.of(context).please_enter_the_value : null,
                                                onSaved: (input) => widget.con.smtp.port = input,
                                                initialValue: widget.con.settingDetails.smtp.port,
                                                decoration: InputDecoration(
                                                  labelText: 'Smtp Port',
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
                                                initialValue: widget.con.settingDetails.smtp.user,
                                                validator: (input) =>  input.length < 1 ? S.of(context).please_enter_the_value : null,
                                                onSaved: (input) => widget.con.smtp.user = input,
                                                decoration: InputDecoration(
                                                  labelText: 'Smtp User',
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
                                                validator: (input) =>  input.length < 1 ? S.of(context).please_enter_the_password : null,
                                                onSaved: (input) => widget.con.smtp.password = input,
                                                initialValue: widget.con.settingDetails.smtp.password,
                                                obscureText: true,
                                                decoration: InputDecoration(
                                                  labelText: 'Smtp Password',
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                      onTap: () {},
                                      child: Container(

                                        padding:EdgeInsets.only(left:20),
                                        child: Container(
                                          width: 200,
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
                                          widget.con.smptDetailsUpdate();

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
                                ],
                              ),
                            ]
                        )
                    )),

                ),
                Container(
                  child:Form( key:widget.con.deliveryFormKey,child:SingleChildScrollView(
                      child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:[
                            Wrap(
                                children:[
                                  Div(
                                      colS: 12,
                                      colM:6,
                                      colL:6,
                                      child:Container(
                                        padding:EdgeInsets.only(top:10,left:20,right:20),
                                        child:Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [


                                            Padding(
                                              padding:EdgeInsets.only(top:20,),
                                              child:Wrap(
                                                children: [

                                                  Padding(
                                                    padding:EdgeInsets.only(top:10,),
                                                    child:Text(S.of(context).delivery_tips),
                                                  ),
                                                  SizedBox(width:10),
                                                  Container(
                                                    width:65,
                                                    child: GestureDetector(
                                                      onTap: () {},
                                                      child: Switch(
                                                        value:  widget.con.settingDetails.delivery.deliveryTips,
                                                        onChanged: (value){
                                                          setState(() {
                                                            widget.con.settingDetails.delivery.deliveryTips=value;
                                                            widget.con.delivery.deliveryTips = value;

                                                          });
                                                        },
                                                        activeTrackColor: Colors.lightGreenAccent,
                                                        activeColor: Colors.green,

                                                      ),
                                                    ),),
                                                ],
                                              ),
                                            ),


                                          ],
                                        ),
                                      )
                                  ),
                                  Div(
                                      colS: 12,
                                      colM:6,
                                      colL:6,
                                      child:Container(
                                        padding:EdgeInsets.only(top:10,left:20,right:20),
                                        child:Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [


                                            Padding(
                                              padding:EdgeInsets.only(top:20,),
                                              child:Wrap(
                                                children: [

                                                  Padding(
                                                    padding:EdgeInsets.only(top:10,),
                                                    child:Text(S.of(context).instance_delivery),
                                                  ),
                                                  SizedBox(width:10),
                                                  Container(
                                                    width:65,
                                                    child: GestureDetector(
                                                      onTap: () {},
                                                      child: Switch(
                                                        value:  widget.con.settingDetails.delivery.instantDelivery,
                                                        onChanged: (value){
                                                          setState(() {
                                                            widget.con.settingDetails.delivery.instantDelivery=value;
                                                            widget.con.delivery.instantDelivery = value;

                                                          });
                                                        },
                                                        activeTrackColor: Colors.lightGreenAccent,
                                                        activeColor: Colors.green,

                                                      ),
                                                    ),),
                                                ],
                                              ),
                                            ),


                                          ],
                                        ),
                                      )
                                  ),
                                  Div(
                                      colS: 12,
                                      colM:6,
                                      colL:6,
                                      child:Container(
                                        padding:EdgeInsets.only(top:10,left:20,right:20),
                                        child:Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [


                                            Padding(
                                              padding:EdgeInsets.only(top:20,),
                                              child:Wrap(
                                                children: [

                                                  Padding(
                                                    padding:EdgeInsets.only(top:10,),
                                                    child:Text(S.of(context).auto_assign),
                                                  ),
                                                  SizedBox(width:10),
                                                  Container(
                                                    width:65,
                                                    child: GestureDetector(
                                                      onTap: () {},
                                                      child: Switch(
                                                        value: widget.con.settingDetails.delivery.autoassing,
                                                        onChanged: (value){
                                                          setState(() {
                                                            widget.con.settingDetails.delivery.autoassing=value;
                                                            widget.con.delivery.autoassing = value;
                                                          });
                                                        },
                                                        activeTrackColor: Colors.lightGreenAccent,
                                                        activeColor: Colors.green,

                                                      ),
                                                    ),),
                                                ],
                                              ),
                                            ),


                                          ],
                                        ),
                                      )
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
                                              keyboardType: TextInputType.number,
                                              initialValue: widget.con.settingDetails.delivery.radius.toString(),
                                              validator: (input) =>  input.length < 1 ? S.of(context).please_enter_the_value : null,
                                              onSaved: (input) => widget.con.delivery.radius = double.parse(input) ,
                                              decoration: InputDecoration(
                                                labelText: S.of(context).coverage_radius,
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                    onTap: () {},
                                    child: Container(

                                      padding:EdgeInsets.only(left:20),
                                      child: Container(
                                        width: 200,
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
                                           widget.con.deliveryDetailsUpdate();

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
                              ],
                            ),
                          ]
                      )
                  ),),

                ),


              ],
            ),
          ),
        ],
      ),
    );
  }
}
