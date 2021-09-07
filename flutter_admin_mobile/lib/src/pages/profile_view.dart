import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import '../controllers/user_controller.dart';
import '../elements/EmptyOrdersWidget.dart';
import '../elements/VendorDetailsWidget.dart';
import 'user_card.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';

class ProfileView extends StatefulWidget {
  final String coverImage;
  final int type;
  final int shopId;
  final String shopName;
  const ProfileView({Key key, this.type, this.coverImage, this.shopId, this.shopName}) : super(key: key);
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends StateMVC<ProfileView> {
  UserController _con;

  _ProfileViewState() : super(UserController()) {
    _con = controller;
  }
  ScrollController _customScrollViewController;
  ScrollController _singleChildScrollViewController;

  final _sliverAppBarExpandedHeight = 300.0;
  final _gap = 20.0;

  @override
  void initState() {
    _customScrollViewController = ScrollController();
    _singleChildScrollViewController = ScrollController();

    _singleChildScrollViewController.addListener(() {
      if (_singleChildScrollViewController.offset <
          _sliverAppBarExpandedHeight) {
        _customScrollViewController
            .jumpTo(_singleChildScrollViewController.offset);
      }
    });
    _con.getVendorProfileDetailData(widget.shopId);
    super.initState();

    print(widget.coverImage);
  }

  @override
  Widget build(BuildContext context) {
    return  Stack(
        children: [
        CustomScrollView(
              physics: NeverScrollableScrollPhysics(),
              controller: _customScrollViewController,
              slivers: [
                SliverAppBar(
                  pinned:true,
                  automaticallyImplyLeading: false,
                  expandedHeight: _sliverAppBarExpandedHeight,
                  flexibleSpace: FlexibleSpaceBar(
                    background: widget.coverImage =='no_image' && widget.type==1? Image.asset(
                        'assets/img/grocerydefaultbg.jpg',
                        fit: BoxFit.cover,
                        height:200
                    ):
                    widget.coverImage =='no_image' && widget.type==2?Image.asset(
                        'assets/img/resturentdefaultbg.jpg',
                        fit: BoxFit.cover,
                        height:200
                    ):
                    widget.coverImage =='no_image' && widget.type==3?Image.asset(
                        'assets/img/pharmacydefaultbg.jpg',
                        fit: BoxFit.cover,
                        height:200
                    ): Image.network(
                        widget.coverImage,
                        fit: BoxFit.cover,
                        height:200
                    ),
                  ),
                ),
                SliverFillRemaining(),
              ],
            ),


    Scrollbar(
    isAlwaysShown: true,
     //controller: _controller,
     child:SingleChildScrollView(
            //controller: _singleChildScrollViewController,
           child:Column(
             children:[
               Align(
                 alignment: Alignment.topLeft,
               child:Padding(
                 padding: EdgeInsets.only(top:20,right:20,),
                 child:Container(
                   width:40,height:40,
                   decoration: BoxDecoration(shape: BoxShape.circle,
                       color:Colors.black.withOpacity(0.5)
                   ),
                   child:IconButton(
                     onPressed: (){
                       Navigator.pop(context);
                     },
                     icon:Icon(Icons.arrow_back),
                     color: Theme.of(context).primaryColorLight,
                   ),
                 ),
               ),
               ),
               Align(
                 alignment: Alignment.topRight,
                 child:Padding(
                     padding: EdgeInsets.only(top:40,right:40,),
                     child:  Badge(
                       toAnimate: false,
                       shape: BadgeShape.square,
                       badgeColor: Colors.blue,
                       borderRadius: BorderRadius.circular(8),
                       badgeContent: Text('WAITING', style: TextStyle(color: Colors.white)),
                     ),

                 ),
               ),
               Container(
                 margin: EdgeInsets.only(top: _sliverAppBarExpandedHeight - 110),
                 padding: EdgeInsets.symmetric(horizontal:0),
                 child: Align(

                   child:Responsive(
                       children:[
                         Wrap(
                             children:[
                               Div(
                                   colS: 12,
                                   colM:6,
                                   colL:4,
                                   child: Column(
                                       children:[
                                         _con.loaderData ?UserCard(gap: _gap, con:_con , title:widget.shopName,):EmptyOrdersWidget(),
                                         SizedBox(
                                           height: 15,
                                         ),

                                       ]
                                   )
                               ),
                               Div(
                                   colS: 12,
                                   colM:6,
                                   colL:8,
                                   child: Padding(
                                     padding: EdgeInsets.only(top:0),
                                     child:_con.loaderData ?VendorDetailsWidget(con: _con):EmptyOrdersWidget(),
                                   )
                               ),


                             ]
                         ),
                       ]
                   ),


                 ),
               ),
             ]
           ),

          ),),
        ],
      );
  }
}

