import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/helpers/helper.dart';
import 'package:login_and_signup_web/src/models/order_list.dart';
import 'package:toast/toast.dart';
import '../models/banner.dart';
import '../models/checkout.dart';
import '../models/invoice.dart';

import '../models/payment_report.dart';
import '../models/summary_report.dart';
import '../repository/order_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../repository/order_repository.dart' as repository;

class OrderController extends ControllerMVC {
  GlobalKey<FormState> bannerFormKey;
  BannerModel bannerData = new BannerModel();
  InvoiceModel invoiceData = new InvoiceModel();
  SummaryReport summaryData = new SummaryReport();
  // ignore: deprecated_member_use
  List<Map<String, dynamic>> originalSource = List<Map<String, dynamic>>();
  double totalPaid;
  double totalDue;
  OverlayEntry loader;
  List<OrderList> orderList = <OrderList>[];
  List<PaymentReport> invoiceList = <PaymentReport>[];
  Checkout invoiceDetailsData = new Checkout();
  // ignore: deprecated_member_use
  List<Map<String, dynamic>> source = List<Map<String, dynamic>>();
  bool isLoading = true;
  OrderController() {
    loader = Helper.overlayLoader(context);
    bannerFormKey = new GlobalKey<FormState>();
  }



  Future<void> listenForOrderList(String id) async {
    final Stream<OrderList> stream = await getOrderList(id);
    stream.listen((OrderList _list) {
      setState(() => orderList.add(_list));
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }

  Future<void> listenForInvoiceList() async {
    setState(() => isLoading = true);
    final Stream<Map<String, dynamic>> stream = await getInvoiceReport();
    stream.listen((Map<String, dynamic> _list) {
      setState(() => source.add(_list));
      setState(() => isLoading = false);
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }

  listenForInvoice(id){
    repository.getInvoice(id).then((value) {
      invoiceData = value;
    }).whenComplete(() {

    });
  }


  listenForInvoiceDetails(id){
    repository.getInvoiceDetails(id).then((value) {
      setState(() => invoiceDetailsData = value);
      print(invoiceDetailsData.addressUser.username);
    }).whenComplete(() {

    });
  }

  listenForSummary(id){
    repository.getSummaryReport(id).then((value) {
      setState((){
        summaryData = value;
        if(summaryData.totalPaidCommission==0){
          totalPaid =1;
        }
        if(summaryData.totalDueCommission==0){
          totalDue =1;
        }
      });


    }).whenComplete(() {

    });
  }

  manualDriverStatusUpdate(orderID, id,orderDetailsData, context){
    if(id!=null) {
      Overlay.of(context).insert(loader);
      repository.manualStatusUpdate(orderID, id).then((value) {
        FirebaseFirestore.instance
            .collection('orderDetails')
            .doc(orderID)
            .update({'orderId': orderID, 'status':  'Shipped', 'driverId': value.driverId, 'driverName': value.driverName,'driverPhone': value.phone,
          'driverLatitude': double.parse(value.latitude), 'driverLongitude': double.parse(value.longitude),'driverStatus':'Waiting'}).catchError((e) {
          print(e);
        });
        setState((){
          orderList.remove(orderDetailsData);
        });

      }).whenComplete(() {
        Helper.hideLoader(loader);
        Navigator.pop(context);
      });
    }else{
      showToastPopup("Select your driver", context, gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
    }
  }

  updateOrderStatusStep2(type, driverState, orderID, orderDetailsData,vendorId, context){

    repository.orderStatusUpdateStep2(type, driverState, orderID,vendorId).then((value) {
      showToast("Update Successfully", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
      FirebaseFirestore.instance
          .collection('orderDetails')
          .doc(orderID)
          .update({'orderId': orderID, 'status':  'Shipped', 'driverId': value.driverId, 'driverName': value.driverName,'driverPhone': value.phone,
        'driverLatitude':  double.parse(value.latitude), 'driverLongitude': double.parse(value.longitude),'driverStatus':'Waiting'}).catchError((e) {
        print(e);
      });

      setState((){
        orderList.remove(orderDetailsData);
      });

    }).whenComplete(() {
      Navigator.pop(context);
    });
  }



  updateOrderStatus(id, status,OrderList orderDetails){
    Overlay.of(context).insert(loader);
    repository.orderStatusUpdate(id, status).then((value) {

      // setState(() => invoiceDetailsData = value);
      // print(invoiceDetailsData.addressUser.username);
      showToast("Update Successfully", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
      FirebaseFirestore.instance
          .collection('orderDetails')
          .doc(id)
          .update({'orderId': id, 'status':  status}).catchError((e) {
        print(e);
      });

      setState((){
        orderList.remove(orderDetails);
      });

    }).whenComplete(() {
      Helper.hideLoader(loader);
    });
  }

  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity ,);
  }

  void showToastPopup(String msg, context,  {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity ,);
  }


}