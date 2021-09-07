import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../generated/l10n.dart';
import '../controllers/primaryuser_controller.dart';
import '../models/vendor.dart';
import '../pages/profile_view.dart';
import 'package:responsive_ui/responsive_ui.dart';

class VendorBoxWidget extends StatefulWidget {
  final PrimaryUserController con;
  final VendorModel details;
  final int type;
  const VendorBoxWidget({Key key, this.details, this.con, this.type}) : super(key: key);
  @override
  _VendorBoxWidgetState createState() => _VendorBoxWidgetState();
}

class _VendorBoxWidgetState extends State<VendorBoxWidget> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child:Div(
        colS: 12,
        colM: 12,
        colL: 4,

        child:  Container(
          decoration: BoxDecoration(
              color:Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5.0,
                  spreadRadius: 1.0,
                ),
              ]),
          margin: EdgeInsets.only(left:15,right:15, top: 10.0,bottom:10),

          child:Column(
              children:[
                Stack(
                    children:[
                      ClipRRect(
                        //borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft:Radius.circular(0),
                            bottomRight:Radius.circular(0),

                          ),
                          child:Image(image: widget.details.coverImage =='no_image' && widget.type==1? AssetImage('assets/img/grocerydefaultbg.jpg'):
                          widget.details.coverImage =='no_image' && widget.type==2?AssetImage('assets/img/resturentdefaultbg.jpg'):
                          widget.details.coverImage =='no_image' && widget.type==3?AssetImage('assets/img/pharmacydefaultbg.jpg'):NetworkImage(widget.details.coverImage),
                              width:double.infinity,
                              height:150,
                              fit:BoxFit.fill
                          )
                      ),

                      ClipRRect(
                        //borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft:Radius.circular(0),
                          bottomRight:Radius.circular(0),

                        ),
                        child:Container(
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                            Container(
                              height:150,
                              width: double.infinity,
                              child: Stack(
                                  children:[
                                    Container(
                                      alignment: Alignment.bottomLeft,

                                      /* background black light to dark gradient color */
                                      decoration: BoxDecoration(
                                        gradient: new LinearGradient(
                                          begin: const Alignment(0.0, -1.0),
                                          end: const Alignment(0.0, 0.6),
                                          colors: <Color>[
                                            const Color(0x8A000000).withOpacity(0.0),
                                            const Color(0x8A000000).withOpacity(0.9),
                                          ],
                                        ),
                                      ),

                                    ),

                                    Positioned(
                                        bottom:10,left:10,right:10,
                                        child:Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children:[
                                              Text(widget.details.general.subTitle,style:TextStyle(color:Colors.white)),
                                            ]
                                        )
                                    )
                                  ]
                              ),
                            ),
                          ]
                          ),
                        ),
                      ),
                    ]
                ),

                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                      Padding(
                          padding:EdgeInsets.only(left:10,right:10,top:10,bottom:10),
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [

                              Container(
                                height: 45,
                                width: 45,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: widget.details.image=='no_image'?AssetImage("assets/img/food.png"):NetworkImage(widget.details.image),
                                      fit: BoxFit.fill
                                  ),
                                  shape: BoxShape.circle, color: Colors.white, boxShadow:
                                [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 5.0,
                                  ),
                                ],

                                ),
                              ),
                              SizedBox(width:10),

                              Text('ID ${widget.details.shopId} - ${widget.details.shopName.toUpperCase()}'),

                            ],
                          )
                      ),
                      Padding(
                          padding:EdgeInsets.only(left:15,right:15,bottom:10),
                          child:Wrap(
                              children:[
                                Icon(Icons.phone,size:15,color:Colors.grey),
                                SizedBox(width:5),
                                Text(widget.details.general.phone,style:TextStyle(color:Colors.grey)),
                              ]
                          )
                      ),
                      Padding(
                          padding:EdgeInsets.only(left:15,right:15,bottom:10),
                          child:Row(
                              children:[
                                Icon(Icons.add_location,size:15,color:Colors.grey),
                                SizedBox(width:5),
                                Expanded(
                                  child:Text(widget.details.general.address,style:TextStyle(color:Colors.grey)),
                                )

                              ]
                          )
                      ),
                      ClipRRect(
                        //borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(0),
                          bottomLeft:Radius.circular(10),
                          bottomRight:Radius.circular(10),

                        ),
                        child:Container(
                          color:Theme.of(context).dividerColor,
                          width:double.infinity,
                          padding:EdgeInsets.only(bottom:10,top:10,left:15,right:15,),
                          child:Wrap(
                              children:[
                                Div(
                                  colS:4,
                                  colM:4,
                                  colL:4,
                                  child:Padding(
                                    padding:EdgeInsets.only(top:5),
                                    // ignore: deprecated_member_use
                                    child:FlatButton(
                                      onPressed: () {
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfileView(type: widget.type,coverImage: widget.details.coverImage, shopId: widget.details.shopId,shopName: widget.details.shopName,)));
                                      },
                                      color:Colors.blue,
                                      splashColor:Colors.blue,
                                      textColor:Colors.white,
                                      child:Text(S.of(context).view_more,style:Theme.of(context).textTheme.bodyText2.merge(TextStyle(color:Colors.white))),
                                    ),
                                  ),
                                ),
                                Div(
                                  colS:4,
                                  colM:4,
                                  colL:4,
                                  child:GestureDetector(
                                    onTap: () {},
                                    child: Center(
                                      child: Switch(
                                        value: widget.details.status,

                                        onChanged: (value){
                                          setState(() {
                                            isSwitched=value;
                                            print(isSwitched);
                                          });
                                        },
                                        activeTrackColor: Colors.lightGreenAccent,
                                        activeColor: Colors.green,

                                      ),
                                    ),

                                  ),
                                ),
                                Div(
                                  colS:4,
                                  colM:4,
                                  colL:3,
                                  child:Padding(
                                      padding:EdgeInsets.only(top:10),
                                      child:Wrap(
                                          alignment: WrapAlignment.end,
                                          children:[
                                            Icon(Icons.star,size:17,color:Colors.orangeAccent),
                                            SizedBox(width:3),
                                            Padding(
                                                padding:EdgeInsets.only(top:2),child:Text(widget.details.rating.toString()))
                                          ]
                                      )
                                  ),
                                )

                              ]
                          ),
                        ),
                      ),

                    ]
                )
              ]
          ),
        ),
      ),
    );
  }
}
