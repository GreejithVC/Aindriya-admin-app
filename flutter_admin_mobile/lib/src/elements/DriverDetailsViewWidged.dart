import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../components/padding_constants.dart';
import '../models/driver.dart';

// ignore: must_be_immutable
class DriverDetailsViewWidged extends StatefulWidget {
  DriverModel driverData;
  DriverDetailsViewWidged({Key key, this.driverData}) : super(key: key);

  @override
  _DriverDetailsViewWidgedState createState() => _DriverDetailsViewWidgedState();
}

class _DriverDetailsViewWidgedState extends State<DriverDetailsViewWidged> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(PaddingConstants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }
  contentBox(context){
    var size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Container(
          height: 450,

          padding: EdgeInsets.only(left: PaddingConstants.padding,top: PaddingConstants.avatarRadius
              + PaddingConstants.padding, right: PaddingConstants.padding,bottom: PaddingConstants.padding
          ),
          margin: EdgeInsets.only(top:PaddingConstants.avatarRadius,left:size.width >670 ? size.width * 0.27: PaddingConstants.padding,right:size.width >670 ? size.width * 0.27: PaddingConstants.padding),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(PaddingConstants.padding),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5.0,
                  spreadRadius: 1.0,
                ),
              ]
          ),
          child:SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[
                  Text('Name',style:Theme.of(context).textTheme.subtitle1),
                  Container(
                      width:size.width > 670 ? size.width * 0.2: 140,
                    alignment: Alignment.topRight,
                    child:Text(widget.driverData.userName,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style:Theme.of(context).textTheme.subtitle1)
                  ),

                ]
              ),
              SizedBox(height:5),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
                    Text('Last Name',style:Theme.of(context).textTheme.subtitle1),
                    Container(
                        width:size.width > 670 ? size.width * 0.2: 140,
                        alignment: Alignment.topRight,
                        child:Text(widget.driverData.last_name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style:Theme.of(context).textTheme.subtitle1)
                    ),

                  ]
              ),
              SizedBox(height:5),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
                    Text('Email',style:Theme.of(context).textTheme.subtitle1),
                    Container(
                        width:size.width > 670 ? size.width * 0.2: 140,
                        alignment: Alignment.topRight,
                        child:Text(widget.driverData.email,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style:Theme.of(context).textTheme.subtitle1)
                    ),

                  ]
              ),
              SizedBox(height:5),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
                    Text('Phone number',style:Theme.of(context).textTheme.subtitle1),
                    Container(
                        width:size.width > 670 ? size.width * 0.2: 140,
                        alignment: Alignment.topRight,
                        child:Text(widget.driverData.phone,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style:Theme.of(context).textTheme.subtitle1)
                    ),

                  ]
              ),
              SizedBox(height:5),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
                    Text('Gender',style:Theme.of(context).textTheme.subtitle1),
                    Container(
                        width:size.width > 670 ? size.width * 0.2: 140,
                        alignment: Alignment.topRight,
                        child:Text(widget.driverData.gender,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style:Theme.of(context).textTheme.subtitle1)
                    ),

                  ]
              ),
              SizedBox(height:5),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
                    Text('Age:',style:Theme.of(context).textTheme.subtitle1),
                    Container(
                        width:size.width > 670 ? size.width * 0.27: 140,
                        alignment: Alignment.topRight,
                        child:Text(widget.driverData.age.toString(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style:Theme.of(context).textTheme.subtitle1)
                    ),
                  ]
              ),
              SizedBox(height:5),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
                    Text('Address',style:Theme.of(context).textTheme.subtitle1),
                    Container(
                        width:size.width > 670 ? size.width * 0.2: 140,
                        alignment: Alignment.topRight,
                        child:Text(widget.driverData.address,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            textAlign: TextAlign.right,
                            style:Theme.of(context).textTheme.subtitle1)
                    ),

                  ]
              ),
              SizedBox(height:5),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
                    Text('Proof',style:Theme.of(context).textTheme.subtitle1),
                    Container(
                        width:size.width > 670 ? size.width * 0.2: 140,
                        alignment: Alignment.topRight,
                        child:Text('df',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style:Theme.of(context).textTheme.subtitle1)
                    ),
                  ]
              ),
              SizedBox(height:5),

              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
                    Text('Live Status',style:Theme.of(context).textTheme.subtitle1),
                    Container(
                        width:size.width > 670 ? size.width * 0.2: 140,
                        alignment: Alignment.topRight,
                        child:Text('Success',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style:Theme.of(context).textTheme.subtitle1)
                    ),
                  ]
              ),
              SizedBox(height:5),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
                    Text('Status',style:Theme.of(context).textTheme.subtitle1),
                    Container(
                        width:size.width > 670 ? size.width * 0.2: 140,
                        alignment: Alignment.topRight,
                        child:Text(widget.driverData.status,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style:Theme.of(context).textTheme.subtitle1)
                    ),
                  ]
              ),
              SizedBox(height:5),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
                    Text('Driving Mode',style:Theme.of(context).textTheme.subtitle1),
                    Container(
                        width:size.width > 670 ? size.width * 0.2: 140,
                        alignment: Alignment.topRight,
                        child:Text(widget.driverData.mode,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style:Theme.of(context).textTheme.subtitle1)
                    ),
                  ]
              ),
              SizedBox(height:5),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
                    Text('Store Id',style:Theme.of(context).textTheme.subtitle1),
                    Container(
                        width:size.width > 670 ? size.width * 0.2: 140,
                        alignment: Alignment.topRight,
                        child:Text('#127700',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style:Theme.of(context).textTheme.subtitle1)
                    ),
                  ]
              ),
              SizedBox(height:5),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
                    Text('Created Date',style:Theme.of(context).textTheme.subtitle1),
                    Container(
                        width:size.width > 670 ? size.width * 0.2: 140,
                        alignment: Alignment.topRight,
                        child:Text('13/07/2021',
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.right,
                            maxLines: 1,
                            style:Theme.of(context).textTheme.subtitle1)
                    ),
                  ]
              ),
              SizedBox(height:10),

             Align(
                alignment: Alignment.center,
               // ignore: deprecated_member_use
               child: FlatButton(
                 onPressed: () {
                   Navigator.pop(context);
                   },
                 padding: EdgeInsets.only(top:15,bottom:15,left:40,right:40),
                 color: Theme.of(context).accentColor.withOpacity(1),
                 shape: StadiumBorder(),
                 child: Text(
                   'Close',
                   style: Theme.of(context).textTheme.headline6.merge(
                       TextStyle(
                           color: Theme.of(context)
                               .primaryColorLight)),
                 ),
               ),
              ),
            ],
          ),
    ),
        ),
        Positioned(
          left: PaddingConstants.padding,
            right: PaddingConstants.padding,
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: PaddingConstants.avatarRadius,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(PaddingConstants.avatarRadius)),
                  child: widget.driverData.image=='no_image'?Image.asset("assets/img/userImage.png"):
                  Image.network(widget.driverData.image)
              ),
            ),
        ),
      ],
    );
  }
}
