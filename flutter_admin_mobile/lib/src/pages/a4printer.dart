// ignore_for_file: public_member_api_docs

import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../models/cart_responce.dart';
import '../models/checkout.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:async';


const PdfColor grey = PdfColor.fromInt(0x696969);
const PdfColor lightGreen = PdfColor.fromInt(0xffcdf1e7);
const PdfColor black = PdfColor.fromInt(0xFF000000);
const PdfColor white = PdfColor.fromInt(0xffffff);
const sep = 120.0;
// ignore: must_be_immutable
class A4printer extends StatefulWidget {
  Checkout con;
  A4printer({
    this.heading = 20,
    this.title =15,
    this.con
  });

  final double heading;
  final double title;
  @override
  _A4printerState createState() => _A4printerState();
}

class _A4printerState extends State<A4printer> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('#${widget.con.saleCode}')),

      body: PdfPreview(
        build: (format) => _generatePdf(format,),
      ),
    );
  }


  pw.Widget _contentTable(pw.Context context, List<CartResponce> productDetails) {
    const tableHeaders = [
      'no',
      'Item',
      'Price',
      'Quantity',
      'Total'
    ];
    const tableContent = [
      '1',
      'Pringles Sour Cream & Onion Flavour Chips  (107 g) kiue ewiu wei weiu lisdf oie ewiu eief ',
      '130',
      '2',
      '260',
    ];

    return pw.Table.fromTextArray(
      border: null,
      cellAlignment: pw.Alignment.centerLeft,

      headerHeight: 25,
      cellHeight: 40,
      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.centerLeft,
        2: pw.Alignment.centerRight,
        3: pw.Alignment.center,
        4: pw.Alignment.centerRight,
      },
      headerStyle: pw.TextStyle(
        color: lightGreen,
        fontSize: 10,
        fontWeight: pw.FontWeight.bold,
      ),
      cellStyle: const pw.TextStyle(
        color: grey,
        fontSize: 10,
      ),

      headers: List<String>.generate(
        5,
            (col) => tableHeaders[col],
      ),
      data: List<List<String>>.generate(
        widget.con.productDetails.length,
            (row) => List<String>.generate(
          tableHeaders.length,
              (col) => tableContent[col],
        ),
      ),
    );
  }
  Future<Uint8List> _generatePdf(PdfPageFormat format,) async {
    //final imageJpg = (await rootBundle.load('assets/promakelogo.png')).buffer.asUint8List();
    final size = MediaQuery.of(context).size;
    final doc = pw.Document();

    doc.addPage(pw.Page(

        pageFormat: PdfPageFormat.a4,

        build: (pw.Context context) {

          return pw.ListView(

              children: [
                pw.Text('PROMAKE',style:pw.TextStyle(fontSize:21,fontWeight: pw.FontWeight.bold)),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('Invoice',style: pw.TextStyle(fontSize:18)),
                    pw.Text('#${widget.con.saleCode}',style: pw.TextStyle(fontSize:15))
                  ],
                ),

                pw.SizedBox(height:20),
                pw.Row(
                  children: [
                    pw.Expanded(
                        child:pw.Container(
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [

                              pw.Text('Billded to',),
                              pw.SizedBox(height:4),
                              pw.Text(widget.con.addressShop.username),
                              pw.SizedBox(height:4),
                              pw.Text(widget.con.addressShop.phone),
                              pw.SizedBox(height:4),
                              pw.Text(widget.con.addressShop.addressSelect),
                              pw.SizedBox(height:4),



                            ],
                          ),
                        )
                    ),
                    pw.SizedBox(width:size.width *0.1),
                    pw.Expanded(
                      child: pw.Container(
                        child:pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.end,
                          children: [

                            pw.Text('Shipped to',textAlign: pw.TextAlign.right),
                            pw.SizedBox(height:4),
                            pw.Text(widget.con.addressUser.username,textAlign: pw.TextAlign.right),
                            pw.SizedBox(height:4),
                            pw.Text(widget.con.addressUser.phone,textAlign: pw.TextAlign.right),
                            pw.SizedBox(height:4),
                            pw.Text(widget.con.addressUser.addressSelect,textAlign: pw.TextAlign.right),
                            pw.SizedBox(height:4),



                          ],
                        ),
                      ),
                    ),



                  ],
                ),
                pw.SizedBox(height:20),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Expanded(
                          child:pw.Container(
                            child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [

                                pw.Text('Payment Method',style: pw.TextStyle(fontSize:18)),
                                pw.SizedBox(height:4),
                                pw.Text('Visa ending ****5685'),
                                pw.SizedBox(height:4),
                                pw.Text('test@example.com'),



                              ],
                            ),
                          )
                      ),

                      pw.Container(
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [

                            pw.Text('Order Dare'),
                            pw.SizedBox(height:4),
                            pw.Text(widget.con.orderDate),


                          ],
                        ),
                      )
                    ]
                ),

                pw.SizedBox(height:10),
                pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text('Order Summary',style: pw.TextStyle(fontSize:18)),
                          pw.SizedBox(height:5),
                          pw.Text('All Itmes here cannot be deleted',style: pw.TextStyle(color:grey)),

                        ],
                      ),
                    ]
                ),
                pw.SizedBox(height:20),

                _contentTable(context,widget.con.productDetails),
                pw.SizedBox(height:20),

                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children:[
                            pw.Text('Payment Method',style: pw.TextStyle(fontSize:18)),
                            pw.SizedBox(height:10),
                            pw.Container(
                              width: 250,
                              child: pw.Text('The payment method that we provide is to make it easier for you to invoices',style: pw.TextStyle(color:grey)),
                            ),

                          ]
                      ),
                      pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.end,
                          children:[
                            pw.Text('Subtotal',style:pw.TextStyle(color:grey)),
                            pw.SizedBox(height:10),
                            pw.Text('\$647',style: pw.TextStyle(fontSize:18,)),
                            pw.SizedBox(height:10),
                            pw.Text('Shipping',style:pw.TextStyle(color:grey)),
                            pw.SizedBox(height:10),
                            pw.Text('\$1',style: pw.TextStyle(fontSize:18)),
                            pw.SizedBox(height:10),
                            pw.Text('Total',style:pw.TextStyle(color:grey)),
                            pw.SizedBox(height:10),
                            pw.Text('\$648',style: pw.TextStyle(fontSize:18)),
                          ]
                      ),

                    ]
                )

              ]
          );

        }
    )
    ); // Page

    return doc.save();
  }
}