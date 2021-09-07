import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:global_configuration/global_configuration.dart';
import 'package:login_and_signup_web/src/models/driver_details.dart';
import '../helpers/custom_trace.dart';
import '../helpers/helper.dart';
import '../models/Currency.dart';
import '../models/banner.dart';
import '../models/deliveryFees.dart';
import '../models/deliveryTips.dart';
import '../models/pushnotification.dart';
import '../models/shoptype.dart';
import '../models/user.dart';
import 'user_repository.dart';

 addBannerData(BannerModel itemData, id,type) async {
User _user = currentUser.value;

 final String _apiToken = 'api_token=${_user.apiToken}';
  // ignore: deprecated_member_use
  final uri = Uri.parse("${GlobalConfiguration().getString('base_url')}Api_admin/banner/$type/${currentUser.value.id}/$id/${currentUser.value.id}?$_apiToken");


  try {

   var request = http.MultipartRequest('POST', uri);
   if( itemData.uploadImage!=null) {
    Uint8List data = await itemData.uploadImage.readAsBytes();
    List<int> list = data.cast();

    var pic = http.MultipartFile.fromBytes('image', list, filename: 'myFile.png');
    request.files.add(pic);
   }

   request.fields['title'] = itemData.title;
   request.fields['para'] = itemData.para;
   request.fields['type'] = itemData.type;

   var response = await request.send();

   if (response.statusCode == 200) {
    response.stream.bytesToString().asStream().listen((event) {


     print(response.statusCode);
     //It's done...
    });
   } else {}
  }catch (e) {

   print(e);

  }
}



Future<Stream<BannerModel>> getBanner(id) async {
 Uri uri = Helper.getUri('Api_admin/banner/list/$id/${currentUser.value.id}');
 Map<String, dynamic> _queryParams = {};

 _queryParams['api_token'] = currentUser.value.apiToken;
 uri = uri.replace(queryParameters: _queryParams);

 try {
  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', uri));
  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => Helper.getData(data))
      .expand((data) => (data as List))
      .map((data) => BannerModel.fromJSON(data));
 } catch (e) {

  print(e);
  print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
  return new Stream.value(new BannerModel.fromJSON({}));
 }
}











addPaymentStatusUpdate(type,invoiceId, id) async {
 final String _apiToken = 'api_token=${currentUser.value.apiToken}';
 // ignore: deprecated_member_use
 final String url = '${GlobalConfiguration().getString('api_base_url')}api_admin/paymentstatusupdate/$type/$invoiceId/${currentUser.value.id}/$id?$_apiToken';
 print(url);
 bool res;
 final client = new http.Client();
 final response = await client.post(
  Uri.parse(url),
  headers: {HttpHeaders.contentTypeHeader: 'application/json'},
  body: json.encode(''),
 );

 if (response.statusCode == 200) {
  // setCurrentUser(response.body);
  // currentUser.value = User.fromJSON(json.decode(response.body)['data']);
  if (json.decode(response.body)['data'] == 'success') {
   res = true;
  } else {
   res = false;
  }
 } else {
  throw new Exception(response.body);
 }
 return res;
}




addCategory(Currency currentData, paraType, id) async {
 // User _user = userRepo.currentUser.value;

 //final String _apiToken = 'api_token=${_user.apiToken}';
 // ignore: deprecated_member_use
 final uri = Uri.parse("${GlobalConfiguration().getString('base_url')}Api_admin/currency/$paraType/$id");


 try {

  var request = http.MultipartRequest('POST', uri);

  if( currentData.uploadImage!=null) {
   Uint8List data = await currentData.uploadImage.readAsBytes();
   List<int> list = data.cast();

   var pic = http.MultipartFile.fromBytes('image', list, filename: 'myFile.png');
   request.files.add(pic);
  }
  request.fields['currencyName'] = currentData.currencyName;
  request.fields['currencySymbol'] = currentData.currencySymbol;
  request.fields['country'] = currentData.country;

  var response = await request.send();

  if (response.statusCode == 200) {
   response.stream.bytesToString().asStream().listen((event) {
    var parsedJson = json.decode(event);
    print(parsedJson);
    print(response.statusCode);
    //It's done...
   });
  } else {}
 }catch (e) {

  print(e);

 }
}


sendNotification(PushNotificationModel currentData) async {
 User _user = currentUser.value;

final String _apiToken = 'api_token=${_user.apiToken}';
 //ignore: deprecated_member_use
 final uri = Uri.parse("${GlobalConfiguration().getString('base_url')}Api_admin/pushNotification/do_add/${currentUser.value.id}?$_apiToken");


 try {

  var request = http.MultipartRequest('POST', uri);

  if( currentData.uploadImage!=null) {
   Uint8List data = await currentData.uploadImage.readAsBytes();
   List<int> list = data.cast();

   var pic = http.MultipartFile.fromBytes('image', list, filename: 'myFile.png');
   request.files.add(pic);
  }


  var response = await request.send();

  if (response.statusCode == 200) {
   response.stream.bytesToString().asStream().listen((event) {
    var parsedJson = json.decode(event);
    print(parsedJson);
    print(response.statusCode);
    //It's done...
   });
  } else {}
 }catch (e) {

  print(e);

 }
}





addEdFocusShopType(ShopTypeModel itemData,  pageType, id) async {
   User _user = currentUser.value;

   final String _apiToken = 'api_token=${_user.apiToken}';
 // ignore: deprecated_member_use
 final uri = Uri.parse("${GlobalConfiguration().getString('base_url')}Api_admin/shopFocusType/$pageType/$id/${currentUser.value.id}?$_apiToken");


 try {

  var request = http.MultipartRequest('POST', uri);

  if( itemData.previewImage!=null) {
   Uint8List data = await itemData.previewImage.readAsBytes();
   List<int> list = data.cast();

   var pic = http.MultipartFile.fromBytes('previewImage', list, filename: 'myFile.png');
   request.files.add(pic);
  }

  if( itemData.coverImage!=null) {
   Uint8List data = await itemData.coverImage.readAsBytes();
   List<int> list = data.cast();

   var pic = http.MultipartFile.fromBytes('coverImage', list, filename: 'myFile.png');
   request.files.add(pic);
  }

  request.fields['title'] = itemData.focusTypeName;
  request.fields['color_code'] = itemData.colorCode;
  request.fields['commission'] = itemData.commission;
  request.fields['shop_type'] = itemData.shopTypeId;
  var response = await request.send();

  if (response.statusCode == 200) {
   response.stream.bytesToString().asStream().listen((event) {
    var parsedJson = json.decode(event);
    print(parsedJson);
    print(response.statusCode);
    //It's done...
   });
  } else {}
 }catch (e) {

  print(e);

 }
}


Future<Stream<ShopTypeModel>> getShopTypeList() async {
 Uri uri = Helper.getUri('Api_admin/shopFocusType/list/no/${currentUser.value.id}');
 Map<String, dynamic> _queryParams = {};

 _queryParams['api_token'] = currentUser.value.apiToken;
 uri = uri.replace(queryParameters: _queryParams);
 try {
  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', uri));
  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => Helper.getData(data))
      .expand((data) => (data as List))
      .map((data) => ShopTypeModel.fromJSON(data));
 } catch (e) {

  print(e);
  print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
  return new Stream.value(new ShopTypeModel.fromJSON({}));
 }
}


Future<Stream<Currency>> getCurrency() async {
 Uri uri = Helper.getUri('Api_admin/currency/list/no/${currentUser.value.id}');
 Map<String, dynamic> _queryParams = {};

 _queryParams['api_token'] = currentUser.value.apiToken;
 uri = uri.replace(queryParameters: _queryParams);
 try {
  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', uri));
  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => Helper.getData(data))
      .expand((data) => (data as List))
      .map((data) => Currency.fromJSON(data));
 } catch (e) {

  print(e);
  print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
  return new Stream.value(new Currency.fromJSON({}));
 }
}




Future<bool> globalDelete(String table,  id) async {

 // ignore: deprecated_member_use
 final String url = '${GlobalConfiguration().getString('api_base_url')}api_admin/$table/delete/$id';
 print(url);
 bool res;
 final client = new http.Client();
 final response = await client.post(
  Uri.parse(url),
  headers: {HttpHeaders.contentTypeHeader: 'application/json'},
  body: json.encode(''),
 );

 if (response.statusCode == 200) {
  // setCurrentUser(response.body);
  // currentUser.value = User.fromJSON(json.decode(response.body)['data']);
  if (json.decode(response.body)['data'] == 'success') {
   res = true;
  } else {
   res = false;
  }
 } else {
  throw new Exception(response.body);
 }
 return res;
}



addEdDeliveryFees(DeliveryFees itemData,  pageType, id) async {
 User _user =currentUser.value;

 final String _apiToken = 'api_token=${_user.apiToken}';
 // ignore: deprecated_member_use
 final url = "${GlobalConfiguration().getString('base_url')}Api_admin/deliveryFees/$pageType/$id/${currentUser.value.id}?$_apiToken";




 bool res;
 final client = new http.Client();
 final response = await client.post(
  Uri.parse(url),
  headers: {HttpHeaders.contentTypeHeader: 'application/json'},
  body: json.encode(itemData.toMap()),
 );

 if (response.statusCode == 200) {

  if (json.decode(response.body)['success'] == 'true') {
   res = true;
  } else {
   res = false;
  }
 } else {
  throw new Exception(response.body);
 }
 return res;


}

Future<Stream<DeliveryFees>>getDeliveryFees() async {
 Uri uri = Helper.getUri('Api_admin/deliveryFees/list/no/${currentUser.value.id}');
 Map<String, dynamic> _queryParams = {};

 _queryParams['api_token'] = currentUser.value.apiToken;
 uri = uri.replace(queryParameters: _queryParams);
 try {
  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', uri));
  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => Helper.getData(data))
      .expand((data) => (data as List))
      .map((data) => DeliveryFees.fromJSON(data));
 } catch (e) {

  print(e);
  print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
  return new Stream.value(new DeliveryFees.fromJSON({}));
 }
}

addEdDeliveryTips(DeliveryTipsModel itemData,id,pageType) async {
   User _user = currentUser.value;

  final String _apiToken = 'api_token=${_user.apiToken}';
 // ignore: deprecated_member_use
 final url = "${GlobalConfiguration().getString('base_url')}Api_admin/deliveryTips/$pageType/$id/${currentUser.value.id}?$_apiToken";
 print(url);



 bool res;
 final client = new http.Client();
 final response = await client.post(
  Uri.parse(url),
  headers: {HttpHeaders.contentTypeHeader: 'application/json'},
  body: json.encode(itemData.toMap()),
 );

 if (response.statusCode == 200) {
  // setCurrentUser(response.body);
  // currentUser.value = User.fromJSON(json.decode(response.body)['data']);
  if (json.decode(response.body)['success'] == 'true') {
   res = true;
  } else {
   res = false;
  }
 } else {
  throw new Exception(response.body);
 }
 return res;


}


Future<Stream<DeliveryTipsModel>>getDeliveryTips() async {
 Uri uri = Helper.getUri('Api_admin/deliveryTips/list/no/${currentUser.value.id}');
 Map<String, dynamic> _queryParams = {};

 _queryParams['api_token'] = currentUser.value.apiToken;
 uri = uri.replace(queryParameters: _queryParams);

 try {
  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', uri));
  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => Helper.getData(data))
      .expand((data) => (data as List))
      .map((data) => DeliveryTipsModel.fromJSON(data));
 } catch (e) {

  print(e);
  print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
  return new Stream.value(new DeliveryTipsModel.fromJSON({}));
 }
}

Future<DriverDetailsModel> getDriverDetailsData(id) async {

 Uri uri = Helper.getUri('Api_admin/driverDetails/do_add/$id/${currentUser.value.id}');
 Map<String, dynamic> _queryParams = {};

 _queryParams['api_token'] = currentUser.value.apiToken;
 uri = uri.replace(queryParameters: _queryParams);

 DriverDetailsModel res;
 final client = new http.Client();
 final response = await client.post(
  uri,
  headers: {HttpHeaders.contentTypeHeader: 'application/json'},
  body: json.encode(''),
 );


 if (response.statusCode == 200) {

  if (response.statusCode == 200) {

   res = DriverDetailsModel.fromJSON(json.decode(response.body)['data']);
  } else {
   throw new Exception(response.body);
  }

  return res;
 } else {
  throw new Exception(response.body);
 }
}

statusUpdate(table,id,select,value ) async {
 final String _apiToken = 'api_token=${currentUser.value.apiToken}';
 // ignore: deprecated_member_use
 final String url = '${GlobalConfiguration().getString('api_base_url')}api_admin/singleStatus/$table/$id/$select/$value?$_apiToken';
 print(url);
 bool res;
 final client = new http.Client();
 await client.post(
  Uri.parse(url),
  headers: {HttpHeaders.contentTypeHeader: 'application/json'},
  body: json.encode(''),
 );


 return res;
}