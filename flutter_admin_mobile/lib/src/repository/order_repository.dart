import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:global_configuration/global_configuration.dart';
import 'package:login_and_signup_web/src/models/driver_status.dart';
import 'package:login_and_signup_web/src/models/order_list.dart';
import '../helpers/custom_trace.dart';
import '../helpers/helper.dart';
import '../models/checkout.dart';
import '../models/invoice.dart';

import '../models/summary_report.dart';
import 'user_repository.dart';

Future<Stream<OrderList>> getOrderList(String status) async {
 Uri uri = Helper.getUri('Api_admin/Order/list/${currentUser.value.id}/$status');
 print(uri);
 try {
  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', uri));
  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => Helper.getData(data))
      .expand((data) => (data as List))
      .map((data) => OrderList.fromJSON(data));
 } catch (e) {

  print(e);
  print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
  return new Stream.value(new OrderList.fromJSON({}));
 }
}

// ignore: missing_return
Future<Stream<Map<String, dynamic>>> getInvoiceReport() async {
  Uri uri = Helper.getUri('Api_admin/payment/paymenylist/');

  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));
    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .expand((data) => (data as List))
        .map((data) => data);
  } catch (e) {

    print(e);
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
   // return new Stream.value(new PaymentReport.fromJSON({}));
  }
}


Future<InvoiceModel> getInvoice(orderID) async {
  // ignore: deprecated_member_use
  final String url = '${GlobalConfiguration().getString('api_base_url')}Api_vendor/Order/invoicefull/$orderID';
  InvoiceModel res;
  final client = new http.Client();
  final response = await client.post(
      Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(''),
  );


  if (response.statusCode == 200) {


      res = InvoiceModel.fromJSON(json.decode(response.body)['data']);

    return res;
  } else {
    throw new Exception(response.body);
  }
}


Future<Checkout> getInvoiceDetails(orderID) async {
  // ignore: deprecated_member_use
  final String url = '${GlobalConfiguration().getString('api_base_url')}Api_vendor/Order/invoiceView/$orderID';
  print(url);
  Checkout res;
  final client = new http.Client();
  final response = await client.post(
      Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(''),
  );


  if (response.statusCode == 200) {


    res = Checkout.fromJSON(json.decode(response.body)['data']);

    return res;
  } else {
    throw new Exception(response.body);
  }
}


Future<SummaryReport> getSummaryReport(vendorID) async {
  // ignore: deprecated_member_use
  final String url = '${GlobalConfiguration().getString('api_base_url')}Api_admin/payment/summaryReport/$vendorID';
  print(url);
  SummaryReport res;
  final client = new http.Client();
  final response = await client.post(
      Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(''),
  );
  print('out');
print(json.decode(response.body)['data']);

  if (response.statusCode == 200) {


      res = SummaryReport.fromJSON(json.decode(response.body)['data']);

    return res;
  } else {
    throw new Exception(response.body);
  }
}


// ignore: missing_return
Future<DriverStatus> orderStatusUpdateStep2 (type, driverState, orderID,vendorId) async {
  final String _apiToken = 'api_token=${currentUser.value.apiToken}';
  // ignore: deprecated_member_use
  final String url = '${GlobalConfiguration().getString('api_base_url')}Api_admin/orderAssign/$type/$driverState/$orderID/${currentUser.value.id}/$vendorId?$_apiToken';
  print(url);
  final client = new http.Client();
  final response = await client.post(
    Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(''),
  );

  print(url);
  if (response.statusCode == 200) {
    print(json.decode(response.body)['data']);

    return DriverStatus.fromJSON(json.decode(response.body)['data']);
  } else {
    throw new Exception(response.body);
  }
}

// ignore: missing_return
Future<DriverStatus> manualStatusUpdate (orderID, id) async {
  // ignore: deprecated_member_use
  final String url = '${GlobalConfiguration().getString('api_base_url')}Api_vendor/orderAssign/update/$id/$orderID';
  print(url);
  final client = new http.Client();
  final response = await client.post(
    Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(''),
  );


  if (response.statusCode == 200) {

    return DriverStatus.fromJSON(json.decode(response.body)['data']);
  } else {
    throw new Exception(response.body);
  }
}



Future<bool> orderStatusUpdate (orderID, status) async {

  final String _apiToken = 'api_token=${currentUser.value.apiToken}';
  // ignore: deprecated_member_use
  final String url = '${GlobalConfiguration().getString('api_base_url')}Api_admin/Order/statusUpdate/$orderID/$status/${currentUser.value.id}?$_apiToken';


  final client = new http.Client();
  final response = await client.post(
    Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(''),
  );


  if (response.statusCode == 200) {
    bool res;
    print(response.statusCode);

    res =  true;
    return res;
  } else {
    throw new Exception(response.body);
  }
}



