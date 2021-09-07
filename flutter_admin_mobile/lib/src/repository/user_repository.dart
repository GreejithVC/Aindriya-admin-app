import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:login_and_signup_web/src/models/payment_gateway.dart';
import '../helpers/helper.dart';
import '../models/settings.dart';
import '../models/profile_response.dart';
import '../models/register.dart';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

ValueNotifier<User> currentUser = new ValueNotifier(User());

Future<bool> registerUser(Registermodel user) async {
  // ignore: deprecated_member_use
  final String url = '${GlobalConfiguration().getString('api_base_url')}api_vendor/register';

  bool res;
  final client = new http.Client();
  final response = await client.post(
      Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(user.toMap()),
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



Future<bool> updateProfile(dataValue, type) async {
  final String _apiToken = 'api_token=${currentUser.value.apiToken}';
  // ignore: deprecated_member_use
  final String url = '${GlobalConfiguration().getString('api_base_url')}api_admin/profileUpdate/$type/no/${currentUser.value.id}?$_apiToken';
 print(url);
  bool res;
  final client = new http.Client();
  final response = await client.post(
      Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(dataValue.toMap()),
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

// ignore: missing_return
Future<User> loginUser(User user) async {
  // ignore: deprecated_member_use
  final String url = '${GlobalConfiguration().getString('api_base_url')}api_admin/login';
  try {
  final client = new http.Client();
  final response = await client.post(
      Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(user.toMap()),
  );


  if (response.statusCode == 200) {

    if (response.statusCode == 200) {
      setCurrentUser(response.body);
      currentUser.value = User.fromJSON(json.decode(response.body)['data']);
    } else {
      throw new Exception(response.body);
    }
    print(currentUser.value.name);
    return currentUser.value;
  } else {
    throw new Exception(response.body);
  }
  }catch (e) {
    print(e);
  }
}


void setCurrentUser(jsonString) async {
  if (json.decode(jsonString)['data'] != null) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('current_user', json.encode(json.decode(jsonString)['data']));
  }
}
Future<User> getCurrentUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //prefs.clear();
  if (currentUser.value.auth == null && prefs.containsKey('current_user')) {
    currentUser.value = User.fromJSON(json.decode(prefs.get('current_user')));
    currentUser.value.auth = true;
  } else {
    currentUser.value.auth = false;
  }
  // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
  currentUser.notifyListeners();
  return currentUser.value;
}

Future<void> logout() async {
  currentUser.value = new User();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('current_user');
}


Future<ProfileResponse> getProfileDetails() async {
  Uri uri = Helper.getUri('Api_admin/profileUpdate/profilelist/null/${currentUser.value.id}');

  ProfileResponse res;
  final client = new http.Client();
  final response = await client.post(
    uri,
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(''),
  );

  print(json.decode(response.body)['data']);

  if (response.statusCode == 200) {
    // setCurrentUser(response.body);
    // currentUser.value = User.fromJSON(json.decode(response.body)['data']);
    print(json.decode(response.body)['data']);
    if (response.statusCode == 200) {

      res = ProfileResponse.fromJSON(json.decode(response.body)['data']);
    } else {
      throw new Exception(response.body);
    }

    return res;
  } else {
    throw new Exception(response.body);
  }
}


Future<bool> globalDelete(String table,  id) async {

  // ignore: deprecated_member_use
  final String url = '${GlobalConfiguration().getString('api_base_url')}api_admin/$table/delete/$id';

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


Future<SettingsModel> getAdminSettingDetailData() async {

  Uri uri = Helper.getUri('Api_admin/profileUpdate/profileview/no/${currentUser.value.id}');
  Map<String, dynamic> _queryParams = {};

  _queryParams['api_token'] = currentUser.value.apiToken;
  uri = uri.replace(queryParameters: _queryParams);
print(uri);
  SettingsModel res;
  final client = new http.Client();
  final response = await client.post(
    uri,
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(''),
  );



  if (response.statusCode == 200) {
    // setCurrentUser(response.body);
    // currentUser.value = User.fromJSON(json.decode(response.body)['data']);
    print(json.decode(response.body)['data']);
    if (response.statusCode == 200) {

      res = SettingsModel.fromJSON(json.decode(response.body)['data']);
    } else {
      throw new Exception(response.body);
    }

    return res;
  } else {
    throw new Exception(response.body);
  }
}

Future<ProfileResponse> getVendorProfileDetails(id) async {

  Uri uri = Helper.getUri('Api_admin/vendor/profile_view/$id/${currentUser.value.id}');
  Map<String, dynamic> _queryParams = {};

  _queryParams['api_token'] = currentUser.value.apiToken;
  uri = uri.replace(queryParameters: _queryParams);

  print(uri);
  ProfileResponse res;
  final client = new http.Client();
  final response = await client.post(
    uri,
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(''),
  );

  print(json.decode(response.body)['data']);

  if (response.statusCode == 200) {
    // setCurrentUser(response.body);
    // currentUser.value = User.fromJSON(json.decode(response.body)['data']);
    print(json.decode(response.body)['data']);
    if (response.statusCode == 200) {

      res = ProfileResponse.fromJSON(json.decode(response.body)['data']);
    } else {
      throw new Exception(response.body);
    }

    return res;
  } else {
    throw new Exception(response.body);
  }
}



void setCurrentUserUpdate(User jsonString) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('current_user', json.encode(jsonString.toMap()));
}


// ignore: missing_return
Future<bool> passwordManagement(type, value,value2) async {

  // ignore: deprecated_member_use
  Uri uri = Uri.parse("${GlobalConfiguration().getString('base_url')}Api_admin/passwordManagement/$type/${currentUser.value.id}");

  Map<String, dynamic> _queryParams = {};

  _queryParams['api_token'] = currentUser.value.apiToken;
  uri = uri.replace(queryParameters: _queryParams);
  print(uri);
  try {

    var request = http.MultipartRequest('POST', uri);

    request.fields['password'] = value;
    request.fields['prePassword'] = value2;
    request.fields['admin'] = currentUser.value.id;

    var response = await request.send();
    print(uri);

    if (response.statusCode == 200) {
      response.stream.bytesToString().asStream().listen((event) {
        var parsedJson = json.decode(event);
        print(parsedJson);
        print(response.statusCode);
        //It's done...
      });
    } else {}

    return true;
  }catch (e) {

    print(e);

  }
}


Future<bool> updateProfileAdminData(dataValue) async {

  final String _apiToken = 'api_token=${currentUser.value.apiToken}';
  // ignore: deprecated_member_use
  final String url = '${GlobalConfiguration().getString('api_base_url')}api_admin/profileUpdateadmin/general/${currentUser.value.id}?$_apiToken';


  bool res;
  final client = new http.Client();
  final response = await client.post(
    Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(dataValue.toMap()),
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


Future<PaymentGatewayModel> getPaymentGatewayDetails() async {

  Uri uri = Helper.getUri('Api_admin/paymentGateway/gateway/${currentUser.value.id}');
  Map<String, dynamic> _queryParams = {};

  _queryParams['api_token'] = currentUser.value.apiToken;
  uri = uri.replace(queryParameters: _queryParams);

  print(uri);
  PaymentGatewayModel res;
  final client = new http.Client();
  final response = await client.post(
    uri,
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(''),
  );



  if (response.statusCode == 200) {
    // setCurrentUser(response.body);
    // currentUser.value = User.fromJSON(json.decode(response.body)['data']);
    print(json.decode(response.body)['data']);
    if (response.statusCode == 200) {

      res = PaymentGatewayModel.fromJSON(json.decode(response.body)['data']);
    } else {
      throw new Exception(response.body);
    }

    return res;
  } else {
    throw new Exception(response.body);
  }
}

Future<bool> updatePaymentGate(paymentGateData) async {
  final String _apiToken = 'api_token=${currentUser.value.apiToken}';
  // ignore: deprecated_member_use
  final String url = '${GlobalConfiguration().getString('api_base_url')}api_admin/paymentGateway/gatewayupdate/${currentUser.value.id}?$_apiToken';
  print(url);
  bool res;
  final client = new http.Client();
  final response = await client.post(
    Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(paymentGateData.toMap()),
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

