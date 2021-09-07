import 'package:flutter/cupertino.dart';
import '../models/driver.dart';
import '../models/user_model.dart';
import '../models/vendorAll.dart';
import '../repository/primaryuser_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class PrimaryUserController extends ControllerMVC {
  GlobalKey<FormState> bannerFormKey;
  List<VendorAllModel> vendorList = <VendorAllModel>[];
  List<UserModel> userList = <UserModel>[];
  List<DriverModel> driverList = <DriverModel>[];
  PrimaryUserController() {

    bannerFormKey = new GlobalKey<FormState>();

  }




  Future<void> listenForVendor() async {

    final Stream<VendorAllModel> stream = await getVendorList();
    stream.listen((VendorAllModel _list) {
      setState(() => vendorList.add(_list));
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }

  Future<void> listenForUser() async {
    final Stream<UserModel> stream = await getUserList();
    stream.listen((UserModel _list) {
      setState(() => userList.add(_list));
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }

  Future<void> listenForDrivers() async {
    final Stream<DriverModel> stream = await getDriverList();
    stream.listen((DriverModel _list) {
      setState(() => driverList.add(_list));
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }





}