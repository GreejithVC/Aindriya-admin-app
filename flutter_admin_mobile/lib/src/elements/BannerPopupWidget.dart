import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../controllers/secondary_controller.dart';
import '../models/banner.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';
import '../../generated/l10n.dart';
// ignore: must_be_immutable
class BannerPopup extends StatefulWidget{
  SecondaryController con;
  BannerModel details;
  String pageType;
  BannerPopup({Key key, this.con, this.details, this.pageType}) : super(key: key);
  @override
  _BannerPopupState createState() => _BannerPopupState();
}

class _BannerPopupState extends StateMVC<BannerPopup> {

  // ignore: non_constant_identifier_names
  String _Type;
  @override
  // ignore: must_call_super
  void initState() {
    if(widget.pageType=='add'){
      _Type = '1';
      widget.con.bannerData.type = '1';
    } else{
      _Type = widget.details.type;
      widget.con.bannerData.type = widget.details.type;
      widget.con.bannerData.uploadImage = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
        child:Div(
                     colS:12,
                     colM:8,
                     colL:6,


                       child:Dialog(
                         shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(16)
                         ),

                         elevation: 0,
                         backgroundColor: Colors.transparent,

                         insetPadding: EdgeInsets.only(top:MediaQuery.of(context).size.height * 0.1,
                           left:MediaQuery.of(context).size.width * 0.09,
                           right:MediaQuery.of(context).size.width * 0.09,
                           bottom:MediaQuery.of(context).size.height * 0.05,
                         ),
                         child:Container(
                           width: double.infinity,
                           decoration: BoxDecoration(
                               color:Theme.of(context).primaryColor,
                               shape: BoxShape.rectangle,
                               borderRadius: BorderRadius.all(Radius.circular(12))
                           ),

                           child: Column(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: <Widget>[
                               Expanded(
                                 child:Container(
                               child: SingleChildScrollView(
                               child: Column(
                               children: [
                                 Row(
                                     mainAxisAlignment: MainAxisAlignment.end,
                                     children:[
                                       IconButton(
                                         icon: Icon(Icons.close),
                                         onPressed: (){
                                           Navigator.pop(context);
                                         },
                                       )

                                     ]
                                 ),


                                 SizedBox(height:10),

                                 widget.pageType=='add'?Text(S.of(context).add_banner,
                                     style: Theme.of(context).textTheme.headline4
                                 ):Text('Edit Banner',
                                     style: Theme.of(context).textTheme.headline4
                                 ),

                                 Form(
                                     key: widget.con.bannerFormKey,
                                     child: Padding(
                                       padding: const EdgeInsets.only(right: 18, left:18),
                                       child:Column(
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           children:[
                                             Padding(
                                               padding: EdgeInsets.only(top:10),
                                               child:Container(
                                                 width: double.infinity,
                                                 child: DropdownButton(
                                                     value: _Type,
                                                     isExpanded: true,
                                                     focusColor: Theme.of(context).accentColor,
                                                     underline: Container(
                                                       color: Colors.grey[300],
                                                       height: 1.0,
                                                     ),
                                                     items: [
                                                       DropdownMenuItem(
                                                         child: Text("Top Banner"),
                                                         value: '1',
                                                       ),
                                                       DropdownMenuItem(
                                                         child: Text("Offer Banner"),
                                                         value: '2',
                                                       ),
                                                       DropdownMenuItem(child: Text("Bottom Banner"), value: '3'),
                                                     ],
                                                     onChanged: (value) {
                                                       setState(() {
                                                         _Type = value;
                                                         widget.con.bannerData.type = value;
                                                       });
                                                     }),
                                               ),
                                             ),
                                             Padding(
                                               padding: EdgeInsets.only(top:10),


                                               child: Container(
                                                   width: double.infinity,

                                                   child: TextFormField(
                                                       textAlign: TextAlign.left,
                                                       autocorrect: true,
                                                       initialValue: widget.details.title,
                                                       onSaved: (input) =>  widget.con.bannerData.title = input,
                                                       validator: (input) => input.length < 1 ? S.of(context).please_enter_your_category : null,
                                                       keyboardType: TextInputType.text,
                                                       decoration: InputDecoration(
                                                         labelText: S.of(context).title,
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

                                             SizedBox(height: 10),

                                             Padding(
                                               padding: EdgeInsets.only(top:10),
                                               child: Container(
                                                   width: double.infinity,

                                                   child: TextFormField(
                                                       textAlign: TextAlign.left,
                                                       autocorrect: true,
                                                       initialValue: widget.details.para,
                                                       onSaved: (input) =>  widget.con.bannerData.para = input,
                                                       validator: (input) => input.length < 1 ? S.of(context).please_enter_your_category : null,
                                                       keyboardType: TextInputType.text,
                                                       decoration: InputDecoration(
                                                         labelText: S.of(context).para,
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

                                             SizedBox(height: 20),

                                             Text(
                                               S.of(context).select_your_banner,
                                               style: Theme.of(context).textTheme.bodyText1,
                                             ),
                                             SizedBox(height: 10),
                                             widget.pageType=='add'?Container(
                                               width: size.width > 670 ? 180:200,
                                               height: size.height > 670 ? 180: 200,
                                               child: GestureDetector(
                                                 onTap: () {
                                                   Imagepickerbottomsheet();
                                                 },
                                                 child: _image == null?Image(image:AssetImage('assets/img/image_placeholder.png'),
                                                   height: double.infinity,
                                                   width:double.infinity,
                                                   fit: BoxFit.fill,
                                                 ):  Image.file(_image),),
                                             ):Container(
                                               color: Theme.of(context).primaryColor,
                                                 width: size.width > 670 ? 180:200,
                                                 height: size.height > 670 ? 180: 200,
                                               child: GestureDetector(
                                                 onTap: () {
                                                   Imagepickerbottomsheet();
                                                 },
                                                 child: _image == null?Image(image:NetworkImage(widget.details.uploadImage),
                                                   height: double.infinity,
                                                   width:double.infinity,
                                                   fit: BoxFit.fill,
                                                 ):  Image.file(_image),),
                                             ),

                                             SizedBox(height:20),
                                             Row(
                                               mainAxisAlignment: MainAxisAlignment.center,
                                               children: [
                                                 // ignore: deprecated_member_use
                                                 FlatButton(
                                                   onPressed: () {
                                                     widget.pageType=='add'?widget.con.addBanner(context,'do_add','null'):widget.con.addBanner(context,'update',widget.details.id);
                                                   },
                                                   padding: EdgeInsets.only(top:15,bottom:15,left:40,right:40),
                                                   color: Theme.of(context).accentColor.withOpacity(1),
                                                   shape: StadiumBorder(),
                                                   child: Text(
                                                       S.of(context).submit,
                                                     style: Theme.of(context).textTheme.headline6.merge(
                                                         TextStyle(
                                                             color: Theme.of(context)
                                                                 .primaryColorLight)),
                                                   ),
                                                 ),
                                               ],
                                             ),

                                         SizedBox(height:30),
                                       ]
                                   ),

                                 ),
                                 ),
                               ]
                               ),
                               ),
                                 )
                               ),




                             ],
                           ),
                       ),
                       ),

                   )

    );


  }





  // ignore: non_constant_identifier_names
  Imagepickerbottomsheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                new ListTile(
                  leading: new Icon(Icons.camera),
                  title: new Text(S.of(context).camera),
                  onTap: () => getImage(),
                ),
                new ListTile(
                  leading: new Icon(Icons.image),
                  title: new Text(S.of(context).gallery),
                  onTap: () => getImagegaller(),
                ),
              ],
            ),
          );
        });
  }

  File _image;
  int currStep = 0;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera, maxHeight: 480, maxWidth: 640);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        widget.con.bannerData.uploadImage = _image;
        Navigator.of(context).pop();
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImagegaller() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        widget.con.bannerData.uploadImage = pickedFile;

        Navigator.of(context).pop();
      } else {
        print('No image selected.');
      }
    });
  }



}
