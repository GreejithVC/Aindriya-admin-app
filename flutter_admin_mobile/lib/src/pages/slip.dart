import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../models/checkout.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';



import 'dart:async';

// ignore: must_be_immutable
class Slip extends StatelessWidget {
  Checkout con;
  Slip({
    this.con
  });


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Print')),
        body: PdfPreview(
          build: (format) => _generatePdf(format, 'hello'),
        ),
      ),
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format, String title) async {
    final pdf = pw.Document();

    pdf.addPage(pw.Page(

        pageFormat: PdfPageFormat.roll57,
        build: (pw.Context context) {

          return pw.ListView(

              children: [
                pw.Column(

                  children: [

                    pw.Text('SHOP NAME',style: pw.TextStyle(fontWeight:pw.FontWeight.bold,fontSize: 16),),
                    pw.SizedBox(height:5),
                    pw.Text('Shop address',style: pw.TextStyle(fontSize:14)),
                    pw.SizedBox(height:10),
                    pw.Text('Shop site',style: pw.TextStyle(fontWeight:pw.FontWeight.bold)),
                  ],
                ),
                pw.SizedBox(height:10),
                /**  pw.Container(
                    decoration:pw.BoxDecoration(
                    border:pw.Border(
                    bottom: pw.BorderSide(
                    width:1,
                    color:grey,
                    )
                    )
                    )
                    ), */
                pw.SizedBox(height:20),
                pw.Row(
                  children: [
                    pw.Expanded(
                        child:pw.Container(
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [

                              pw.Text('Guccei Bamboo iwueb eiwu eiowrh e eiue weoiufh ',
                                  style:pw.TextStyle(fontSize:7),
                                  maxLines:1
                              ),
                              pw.SizedBox(height:4),
                              pw.Text('Prada Candy  eiuwf',  maxLines:1, style:pw.TextStyle(fontSize:7),),
                              pw.SizedBox(height:4),
                              pw.Text('Theri mulger angle ewiu eweiowh e',  maxLines:1, style:pw.TextStyle(fontSize:7),),



                            ],
                          ),
                        )
                    ),
                    pw.SizedBox(width: 20),
                    pw.Container(
                      child:pw.Column(

                        children: [

                          pw.Text('90.00',style:pw.TextStyle(fontSize:7)),
                          pw.SizedBox(height:4),
                          pw.Text('87.00',style:pw.TextStyle(fontSize:7)),
                          pw.SizedBox(height:4),
                          pw.Text('80.00',style:pw.TextStyle(fontSize:7)),


                        ],
                      ),
                    ),


                  ],
                ),
                pw.SizedBox(height:20),
                /**pw.Container(
                    decoration:pw.BoxDecoration(
                    border:pw.Border(
                    bottom: pw.BorderSide(
                    width:1,
                    color:grey,
                    )
                    )
                    )
                    ), */
                pw.SizedBox(height:20),
                pw.Row(
                  children: [
                    pw.Expanded(
                        child:pw.Container(
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [

                              pw.Text('Sub total',),
                              pw.SizedBox(height:4),
                              pw.Text('Tax'),
                              pw.SizedBox(height:4),
                              pw.Text('Discount'),
                              pw.SizedBox(height:10),
                              pw.Text('Total',style: pw.TextStyle(fontWeight:pw.FontWeight.bold)),


                            ],
                          ),
                        )
                    ),
                    pw.Container(
                      child:pw.Column(

                        children: [

                          pw.Text('257.00',),
                          pw.SizedBox(height:4),
                          pw.Text('0.00'),
                          pw.SizedBox(height:4),
                          pw.Text('-0.00'),
                          pw.SizedBox(height:10),
                          pw.Text('257.00',style: pw.TextStyle(fontWeight:pw.FontWeight.bold)),

                        ],
                      ),
                    ),


                  ],
                ),
                pw.SizedBox(height:20),
                /**  pw.Container(
                    decoration:pw.BoxDecoration(
                    border:pw.Border(
                    bottom: pw.BorderSide(
                    width:1,
                    color:grey,
                    )
                    )
                    )
                    ), */
                pw.SizedBox(height:10),
                pw.Row(
                  children: [
                    pw.Expanded(
                        child:pw.Container(
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [

                              pw.Text('27/4/2021'),



                            ],
                          ),
                        )
                    ),
                    pw.Container(
                      child:pw.Column(

                        children: [

                          pw.Text('11:45:10 PM',),

                        ],
                      ),
                    ),


                  ],
                ),

                pw.SizedBox(height:20),
                // pw.Image(pw.MemoryImage(imageJpg),width: 170,height: 50),
                pw.SizedBox(height:10),
                /**  pw.Container(
                    decoration:pw.BoxDecoration(
                    border:pw.Border(
                    bottom: pw.BorderSide(
                    width:1,
                    color:grey,
                    )
                    )
                    )
                    ), */
                pw.SizedBox(height:10),
                pw.Text('Thank you for your purchases!',
                    style: pw.TextStyle(fontWeight:pw.FontWeight.bold,fontSize: 16),
                    textAlign: pw.TextAlign.center
                ),

                /*pw.SvgImage(
                       width: 200,
                       height:40,
                       svg:imageSvg,),*/


              ]
          );

        }
    )
    ); // Page

    return pdf.save();
  }


}