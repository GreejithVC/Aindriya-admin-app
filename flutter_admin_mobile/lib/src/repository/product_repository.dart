import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../helpers/custom_trace.dart';
import '../helpers/helper.dart';
import '../models/Dropdown.dart';
import 'user_repository.dart';

Future<Stream<DropDownModel>> getDropdownDataNC(table, select) async {

 Uri uri = Helper.getUri('Api_admin/globaldropdown/$table/$select/${currentUser.value.id}');
 Map<String, dynamic> _queryParams = {};

 _queryParams['api_token'] = currentUser.value.apiToken;
 uri = uri.replace(queryParameters: _queryParams);
 print(uri);
 try {
  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', uri));

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => Helper.getData(data))
      .expand((data) => (data as List))
      .map((data) => DropDownModel.fromJSON(data));
 } catch (e) {

  print(e);
  print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
  return new Stream.value(new DropDownModel.fromJSON({}));
 }
}



Future<Stream<DropDownModel>> getDropdownDataSC(table, select, column, para1) async {

 Uri uri = Helper.getUri('Api_admin/globaldropdownsc/$table/$select/$column/$para1/${currentUser.value.id}');
 Map<String, dynamic> _queryParams = {};

 _queryParams['api_token'] = currentUser.value.apiToken;
 uri = uri.replace(queryParameters: _queryParams);
 try {
  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', uri));
  print('tester');
  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => Helper.getData(data))
      .expand((data) => (data as List))
      .map((data) => DropDownModel.fromJSON(data));
 } catch (e) {

  print(e);
  print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
  return new Stream.value(new DropDownModel.fromJSON({}));
 }
}






Future<bool> updateProductStatus(productId,status) async {
 Uri uri = Helper.getUri('Api_vendor/product/product_status/$productId/$status');
print(uri);
 final client = new http.Client();
 final response = await client.post(
  uri,
  headers: {HttpHeaders.contentTypeHeader: 'application/json'},
  body: json.encode(''),
 );


 if (response.statusCode == 200) {
  return true;
 } else {
  return false;
 }
}