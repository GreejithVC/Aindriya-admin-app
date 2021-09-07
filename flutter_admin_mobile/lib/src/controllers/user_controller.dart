import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/models/payment_gateway.dart';
import '../helpers/helper.dart';
import '../models/Dropdown.dart';
import '../models/admin_Payment.dart';
import '../models/admin_general.dart';
import '../models/settings.dart';
import '../models/bank.dart';
import '../models/delivery_setting.dart';
import '../models/general.dart';
import '../models/profile_response.dart';
import '../models/smtp_model.dart';
import '../repository/product_repository.dart';
import '../repository/user_repository.dart';
import 'package:toast/toast.dart';
import 'package:vrouter/vrouter.dart';
import '../models/register.dart';
import '../models/user.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../repository/user_repository.dart' as repository;

class UserController extends ControllerMVC {
  GlobalKey<FormState> loginFormKey;
  GlobalKey<FormState> registerFormKey;
  Registermodel registerData = new Registermodel();
  User userData = new User();
  List<DropDownModel> dropDownList = <DropDownModel>[];
  TextEditingController openTime;
  TextEditingController closeTime;
  GlobalKey<ScaffoldState> scaffoldKeyState;
  GlobalKey<FormState> generalFormKey;
  GlobalKey<FormState> bankFormKey;
  ProfileResponse profileDetails = new ProfileResponse();
  ProfileResponse adminProfileDetails = new ProfileResponse();
  SettingsModel settingDetails = new SettingsModel();
  GlobalKey<FormState> adminGeneralFormKey;
  GlobalKey<FormState> paymentFormKey;
  GlobalKey<FormState> smtpFormKey;
  GlobalKey<FormState> deliveryFormKey;
  General generalModel = new General();
  Bank bankModel = new Bank();
  AdminGeneral adminGeneral = new AdminGeneral();
  DeliverySettingsModel delivery = new DeliverySettingsModel();
  Smtp smtp = new Smtp();
  AdminPayment adminPayment = new AdminPayment();
  OverlayEntry loader;
  String password;
  String prePassword;
  String rePassword;
  bool loaderData=false;
  PaymentGatewayModel paymentGateData = new PaymentGatewayModel();
  UserController() {
    openTime = TextEditingController();
    closeTime = TextEditingController();
    loader = Helper.overlayLoader(context);
    this.scaffoldKeyState = new GlobalKey<ScaffoldState>();
    loginFormKey = new GlobalKey<FormState>();
    registerFormKey = new GlobalKey<FormState>();
    generalFormKey = new GlobalKey<FormState>();
    bankFormKey = new GlobalKey<FormState>();

    adminGeneralFormKey = new GlobalKey<FormState>();
    paymentFormKey = new GlobalKey<FormState>();
    smtpFormKey = new GlobalKey<FormState>();
    deliveryFormKey = new GlobalKey<FormState>();

  }

  register(){

      if (registerFormKey.currentState.validate()) {
        registerFormKey.currentState.save();
        repository.registerUser(registerData).then((value) {
          if (value == true) {
            showToast("Register Successfully", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
           // Navigator.of(context).pushReplacementNamed('/Login');
          }else{
            // ignore: deprecated_member_use
            scaffoldKeyState?.currentState?.showSnackBar(SnackBar(
              content: Text('This mobile number is already register'),
            ));
          }
        }).catchError((e) {

        }).whenComplete(() {

        });
      }
 }


  Future<void> listenForDropdown(table, select, column, para1) async {
    dropDownList.clear();
    final Stream<DropDownModel> stream = await getDropdownDataSC(table, select, column, para1);

    stream.listen((DropDownModel _list) {
      setState(() => dropDownList.add(_list));

    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }

  Future<void> listenForDropdownNC(table, select) async {
    dropDownList.clear();
    final Stream<DropDownModel> stream = await getDropdownDataNC(table, select);

    stream.listen((DropDownModel _list) {
      setState(() => dropDownList.add(_list));

    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }


  login(){
    if(loginFormKey.currentState.validate()){
      loginFormKey.currentState.save();
      Overlay.of(context).insert(loader);
      repository.loginUser(userData).then((value) {

        if (value.auth == true ) {
         gettoken();
         // ignore: deprecated_member_use
         VRouter.of(context).pushReplacement('/dashboard');
        }else {
          // ignore: deprecated_member_use
          scaffoldKeyState?.currentState?.showSnackBar(SnackBar(
            content: Text('Invalid Email & password'),
          ));
        }
      }).catchError((e) {
        print(e);
        loader.remove();
        // ignore: deprecated_member_use
        scaffoldKeyState?.currentState?.showSnackBar(SnackBar(
          content: Text('Error'),
        ));
      }).whenComplete(() {
        Helper.hideLoader(loader);
      });
    }
}
  gettoken() {
    FirebaseMessaging.instance.getToken().then((deviceid) {

      var table = 'admin' + currentUser.value.id;
      FirebaseFirestore.instance.collection('adminToken').doc(table).set({'devToken': deviceid, 'adminId': currentUser.value.id}).catchError((e) {
        print(e);
      });
    });
  }


  bankDetailsUpdate(){
    if (bankFormKey.currentState.validate()) {
      bankFormKey.currentState.save();

      showToast("Update Successfully", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
      repository.updateProfile(bankModel,'bank_detail').then((value) {


      }).catchError((e) {

      }).whenComplete(() {

      });
    }

  }


  passwordUpdate(){
    if (loginFormKey.currentState.validate()) {
      loginFormKey.currentState.save();

      if(password==rePassword){
        Overlay.of(context).insert(loader);
        repository.passwordManagement('update', password,prePassword).then((value) {
        }).whenComplete(() {
          Helper.hideLoader(loader);
          showToast("Password changed", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
        });
      }else {
        showToast("Password is not matched", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
      }
    }
  }




  updateProfileAdmin(){
    if (generalFormKey.currentState.validate()) {
      generalFormKey.currentState.save();
      Overlay.of(context).insert(loader);
      currentUser.value.name = userData.name;
      currentUser.value.email = userData.email;
      currentUser.value.address = userData.address;
      currentUser.value.phone = userData.phone;
      setCurrentUserUpdate( currentUser.value);
      repository.updateProfileAdminData(currentUser.value).then((value) {

      }).catchError((e) {
        loader.remove();
        // ignore: deprecated_member_use
        scaffoldKeyState?.currentState?.showSnackBar(SnackBar(
          content: Text('Error'),
        ));
      }).whenComplete(() {
        Helper.hideLoader(loader);
      });
    }
  }
  listenForSetting() {

    repository.getAdminSettingDetailData().then((value) {
      setState(() {
        loaderData = true;

        settingDetails = value;

      } );

    }).catchError((e) {
      loader.remove();
      // ignore: deprecated_member_use
      scaffoldKeyState?.currentState?.showSnackBar(SnackBar(
        content: Text('Error'),
      ));
    }).whenComplete(() {

    });
  }


  getVendorProfileDetailData(id) {

    repository.getVendorProfileDetails(id).then((value) {
      setState(() {
        loaderData = true;
        profileDetails = value;
        openTime.text = profileDetails.general.openTime;
        closeTime.text = profileDetails.general.closeTime;
      } );

    }).catchError((e) {
      loader.remove();
      // ignore: deprecated_member_use
      scaffoldKeyState?.currentState?.showSnackBar(SnackBar(
        content: Text('Error'),
      ));
    }).whenComplete(() {
      //Helper.hideLoader(loader);
    });
  }
  generalDetailsUpdate(){
    if (adminGeneralFormKey.currentState.validate()) {
      adminGeneralFormKey.currentState.save();
      Overlay.of(context).insert(loader);
          repository.updateProfile(adminGeneral,'general').then((value) {

            showToast("Update Successfully", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
          }).catchError((e) {

          }).whenComplete(() {
            Helper.hideLoader(loader);
          });
    }
  }
  paymentDetailsUpdate(){
    if (paymentFormKey.currentState.validate()) {
      paymentFormKey.currentState.save();
      Overlay.of(context).insert(loader);
      repository.updateProfile(adminPayment,'payment').then((value) {

        showToast("Update Successfully", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
      }).catchError((e) {

      }).whenComplete(() {
        Helper.hideLoader(loader);
      });
    }
  }
  smptDetailsUpdate(){
    if (smtpFormKey.currentState.validate()) {
      smtpFormKey.currentState.save();
      Overlay.of(context).insert(loader);
      repository.updateProfile(smtp,'smtp').then((value) {

        showToast("Update Successfully", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
      }).catchError((e) {

      }).whenComplete(() {
        Helper.hideLoader(loader);
      });
    }
  }

  deliveryDetailsUpdate(){
    if (deliveryFormKey.currentState.validate()) {
      deliveryFormKey.currentState.save();
      Overlay.of(context).insert(loader);
      repository.updateProfile(delivery,'delivery').then((value) {

        showToast("Update Successfully", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
      }).catchError((e) {

      }).whenComplete(() {
        Helper.hideLoader(loader);
      });
    }
  }

  paymentGatewayDetailsUpdate(){
    print(paymentGateData.toMap());
    if (generalFormKey.currentState.validate()) {
      generalFormKey.currentState.save();
      Overlay.of(context).insert(loader);
      repository.updatePaymentGate(paymentGateData).then((value) {
        showToast("Update Successfully", gravity: Toast.BOTTOM,
            duration: Toast.LENGTH_SHORT);
      }).catchError((e) {

      }).whenComplete(() {
        Helper.hideLoader(loader);
      });
    }

  }

  listenForPaymentGate(){
    repository.getPaymentGatewayDetails().then((value) {
      setState(() {
        loaderData = true;
        paymentGateData = value;

      } );

    }).catchError((e) {
      loader.remove();
      // ignore: deprecated_member_use
      scaffoldKeyState?.currentState?.showSnackBar(SnackBar(
        content: Text('Error'),
      ));
    }).whenComplete(() {
      //Helper.hideLoader(loader);
    });

  }

  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity ,);
  }

  void showToastPopup(String msg, context,  {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity ,);
  }
}