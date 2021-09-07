import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../controllers/secondary_controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';

class AEDriverWidget extends StatefulWidget{
  @override
  _AEDriverWidgetState createState() => _AEDriverWidgetState();
}

class _AEDriverWidgetState extends StateMVC<AEDriverWidget> {


  SecondaryController _con;
  _AEDriverWidgetState() : super(SecondaryController()) {
    _con = controller;
  }

  @override
  Widget build(BuildContext context) {

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
                                   child:Scrollbar(
                                     isAlwaysShown: true,
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
                                 Text('Add Driver',
                                     style: Theme.of(context).textTheme.headline4
                                 ),

                                 Form(
                                     key: _con.bannerFormKey,
                                     child: Padding(
                                       padding: const EdgeInsets.only(right: 40, left:40),
                                       child:Column(
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           children:[

                                             Padding(
                                               padding: EdgeInsets.only(top:10),


                                               child: Container(
                                                   width: double.infinity,

                                                   child: TextFormField(
                                                       textAlign: TextAlign.left,
                                                       autocorrect: true,
                                                       keyboardType: TextInputType.text,
                                                       decoration: InputDecoration(
                                                         labelText: 'Name',
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

                                               Container(
                                                   width: double.infinity,

                                                   child: TextFormField(
                                                       textAlign: TextAlign.left,
                                                       autocorrect: true,
                                                       keyboardType: TextInputType.emailAddress,
                                                       decoration: InputDecoration(
                                                         labelText: 'Email',
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

                                             SizedBox(height: 10),

                                               Container(
                                                   width: double.infinity,

                                                   child: TextFormField(
                                                       textAlign: TextAlign.left,
                                                       autocorrect: true,
                                                       keyboardType: TextInputType.text,
                                                       obscureText: true,
                                                       decoration: InputDecoration(
                                                         labelText: 'Password',
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
                                             SizedBox(height: 10),
                                             Container(
                                                   width: double.infinity,

                                                   child: TextFormField(
                                                       textAlign: TextAlign.left,
                                                       autocorrect: true,
                                                       keyboardType: TextInputType.text,
                                                       decoration: InputDecoration(
                                                         labelText: 'Gender',
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
                                             SizedBox(height: 10),
                                            Container(
                                                   width: double.infinity,

                                                   child: TextFormField(
                                                       textAlign: TextAlign.left,
                                                       autocorrect: true,
                                                       keyboardType: TextInputType.text,
                                                       decoration: InputDecoration(
                                                         labelText: 'Age',
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
                                             SizedBox(height: 10),
                                             Container(
                                                   width: double.infinity,

                                                   child: TextFormField(
                                                       textAlign: TextAlign.left,
                                                       autocorrect: true,
                                                       keyboardType: TextInputType.number,
                                                       inputFormatters: <TextInputFormatter>[
                                                         FilteringTextInputFormatter.digitsOnly
                                                       ],
                                                       decoration: InputDecoration(
                                                         labelText: 'Phone',
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
                                             SizedBox(height: 20),

                                             Container(
                                               decoration: BoxDecoration(
                                                 borderRadius: BorderRadius.circular(6),
                                                 color: Theme.of(context).dividerColor,
                                               ),
                                               child: Padding(
                                                 padding: const EdgeInsets.all(10.0),
                                                 child: TextField(
                                                   maxLines: 5,
                                                   decoration: InputDecoration.collapsed(
                                                     hintText: 'Address',
                                                     hintStyle: Theme.of(context)
                                                         .textTheme
                                                         .bodyText2
                                                         .merge(TextStyle(color: Colors.grey)),
                                                   ),
                                                 ),
                                               ),
                                             ),
                                             SizedBox(height: 10),
                                             Text(
                                               'Proof image',
                                               style: Theme.of(context).textTheme.bodyText1,
                                             ),
                                             SizedBox(height: 10),

                                        Container(
                                          height: 90,
                                          width:110,
                                          child:GestureDetector(
                                       onTap: () {
                                         Imagepickerbottomsheet();
                                       },
                                             child:_image == null ?
                                             Image(image:AssetImage(''),):
                                             Image.network(_image.path,
                                               height: 90,
                                               width:110,
                                               fit: BoxFit.fitHeight,
                                             ),
                                        ),
                                   ),
                                             SizedBox(height: 10),
                                             Text(
                                               'Image',
                                               style: Theme.of(context).textTheme.bodyText1,
                                             ),
                                             SizedBox(height: 10),

                                             Container(
                                               height: 90,
                                               width:110,
                                               child:GestureDetector(
                                                 onTap: () {
                                                   Imagepickerbottomsheet();
                                                 },
                                                 child:_image == null ?
                                                 Image(image:AssetImage(''),):
                                                 Image.network(_image.path,
                                                   height: 90,
                                                   width:110,
                                                   fit: BoxFit.fitHeight,
                                                 ),
                                               ),
                                             ),

                                             /*Container(
                                               width: MediaQuery.of(context).size.width * 0.1,
                                               height: MediaQuery.of(context).size.height * 0.2,
                                               child: GestureDetector(
                                                 onTap: () {
                                                   Imagepickerbottomsheet();
                                                 },
                                                 child: _image == null?Image(image:AssetImage(''),
                                                   height: double.infinity,
                                                   width:double.infinity,
                                                   fit: BoxFit.fitHeight,
                                                 ): Image.network(_image.path),),
                                             ),*/
                                             SizedBox(height: 10),
                                             /*Text(
                                               'Image',
                                               style: Theme.of(context).textTheme.bodyText1,
                                             ),
                                             SizedBox(height: 10),
                                             Container(
                                               width: MediaQuery.of(context).size.width * 0.1,
                                               height: MediaQuery.of(context).size.height * 0.2,
                                               child: GestureDetector(
                                                 onTap: () {
                                                   Imagepickerbottomsheet();
                                                 },
                                                 child: _image == null?Image(image:AssetImage(''),
                                                   height: double.infinity,
                                                   width:double.infinity,
                                                   fit: BoxFit.fitHeight,
                                                 ): Image.network(_image.path),),
                                             ),*/

                                             SizedBox(height:20),
                                             Row(
                                               mainAxisAlignment: MainAxisAlignment.center,
                                               children: [
                                                 // ignore: deprecated_member_use
                                                 FlatButton(
                                                   onPressed: () {
                                                   //  _con.addBanner();
                                                   },
                                                   padding: EdgeInsets.only(top:15,bottom:15,left:40,right:40),
                                                   color: Theme.of(context).accentColor.withOpacity(1),
                                                   shape: StadiumBorder(),
                                                   child: Text(
                                                     'SUBMIT',
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
                               ),),
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
                  title: new Text('Camera'),
                  onTap: () => getImage(),
                ),
                new ListTile(
                  leading: new Icon(Icons.image),
                  title: new Text('Gallery'),
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
        _con.bannerData.uploadImage = pickedFile;
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
        _con.bannerData.uploadImage = pickedFile;

        Navigator.of(context).pop();
      } else {
        print('No image selected.');
      }
    });
  }



}
