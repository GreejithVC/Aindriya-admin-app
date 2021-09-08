import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:login_and_signup_web/src/models/driver_details.dart';
import 'package:login_and_signup_web/src/models/packagetype.dart';
import '../helpers/helper.dart';
import '../models/Currency.dart';
import '../models/Dropdown.dart';
import '../models/banner.dart';
import '../models/deliveryFees.dart';
import '../models/deliveryTips.dart';
import '../models/pushnotification.dart';
import '../models/shoptype.dart';
import '../repository/product_repository.dart';
import '../repository/secondary_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:toast/toast.dart';
import '../repository/secondary_repository.dart' as repository;

class SecondaryController extends ControllerMVC {
  GlobalKey<FormState> bannerFormKey;
  bool loaderData = false;
  DriverDetailsModel driverDetailsData = new DriverDetailsModel();
  GlobalKey<FormState> generalFormKey;
  BannerModel bannerData = new BannerModel();
  DeliveryFees deliveryFees = new DeliveryFees();
  Currency currencyData = Currency();
  GlobalKey<FormState> deliveryFeesFormKey;
  GlobalKey<FormState> currencyFormKey;
  GlobalKey<FormState> deliveryTipsFormKey;
  List<DropDownModel> dropDownList = <DropDownModel>[];
  PushNotificationModel pushNotificationData = new PushNotificationModel();
  ShopTypeModel shopTypeData = new ShopTypeModel();
  PackageTypeModel packageTypeData = new PackageTypeModel();
  DeliveryTipsModel deliveryTips = new DeliveryTipsModel();
  List<DeliveryTipsModel> deliveryTipsList = <DeliveryTipsModel>[];
  List<ShopTypeModel> shopTypeList = <ShopTypeModel>[];
  List<PackageTypeModel> packageTypeList = <PackageTypeModel>[];
  List<BannerModel> bannerList = <BannerModel>[];
  List<DeliveryFees> deliveryFeesList = <DeliveryFees>[];
  List<Currency> currencyList = <Currency>[];
  TextEditingController controllerTitle;

  TextEditingController controllerText;

  OverlayEntry loader;

  SecondaryController() {
    loader = Helper.overlayLoader(context);
    controllerTitle = TextEditingController();
    controllerText = TextEditingController();
    controllerTitle.addListener(() {
      setState(() {});
    });
    controllerText.addListener(() {
      setState(() {});
    });
    bannerFormKey = new GlobalKey<FormState>();
    generalFormKey = new GlobalKey<FormState>();
    deliveryFeesFormKey = new GlobalKey<FormState>();
    deliveryTipsFormKey = new GlobalKey<FormState>();
    currencyFormKey = new GlobalKey<FormState>();
  }

  addBanner(context, pageType, id) {
    if (bannerFormKey.currentState.validate()) {
      bannerFormKey.currentState.save();
      print(bannerData.toMap());
      Overlay.of(context).insert(loader);

      if ((bannerData.uploadImage != null && pageType == 'do_add') ||
          pageType == 'update') {
        setState(() => bannerList.clear());
        repository
            .addBannerData(bannerData, id, pageType)
            .then((value) {
              showToast("Update Successfully",
                  gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
            })
            .catchError((e) {})
            .whenComplete(() {
              listenForBanner(bannerData.type);
              Navigator.pop(context);

              Helper.hideLoader(loader);
            });
      } else {
        showToastPopup(
          "Upload your image",
          context,
          gravity: Toast.BOTTOM,
          duration: Toast.LENGTH_SHORT,
        );
      }
    }
  }

  sendPushNotification() async {
    if (generalFormKey.currentState.validate()) {
      generalFormKey.currentState.save();
      Overlay.of(context).insert(loader);
      String timeStamp = DateTime.now().millisecondsSinceEpoch.toString();

      await repository.sendNotification(pushNotificationData).then((value) {
        if (pushNotificationData.uploadImage != null) {
          // ignore: deprecated_member_use
          pushNotificationData.uploadImage =
              '${GlobalConfiguration().getString('base_upload')}uploads/pushnotification_image/pushnotification_1.png';
        } else {
          pushNotificationData.uploadImage = 'no';
        }
        FirebaseFirestore.instance
            .collection('notificationall')
            .doc(timeStamp)
            .set({
          'title': pushNotificationData.title,
          'subtitle': pushNotificationData.message,
          'usertype': pushNotificationData.userType,
          'image': pushNotificationData.uploadImage
        }).catchError((e) {
          print(e);
        });
        showToast("Update Successfully",
            gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
      }).catchError((e) {
        loader.remove();
        // ignore: deprecated_member_use
      }).whenComplete(() {
        Helper.hideLoader(loader);

        // setState(() => currencyData.clear());

        return true;
      });
    }
  }

  Future<void> listenForDropdown(table, select, column, para1) async {
    dropDownList.clear();
    final Stream<DropDownModel> stream =
        await getDropdownDataSC(table, select, column, para1);

    stream.listen((DropDownModel _list) {
      setState(() => dropDownList.add(_list));
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }

  deliveryTipsUpdate(context, id, pageType) {
    if (deliveryTipsFormKey.currentState.validate()) {
      deliveryTipsFormKey.currentState.save();
      Overlay.of(context).insert(loader);
      setState(() => deliveryTipsList.clear());

      print(deliveryTips.toMap());
      repository.addEdDeliveryTips(deliveryTips, id, pageType).then((value) {
        showToastPopup("Update Successfully", context,
            gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
      }).catchError((e) {
        print(e);
      }).whenComplete(() {
        Navigator.pop(context);
        listenForDeliveryTips();
        Helper.hideLoader(loader);
      });
    }
  }

  addEdFocusType(context, id, pageType) {
    if (generalFormKey.currentState.validate()) {
      generalFormKey.currentState.save();
      if ((shopTypeData.previewImage != null && pageType == 'do_add') &&
              (shopTypeData.coverImage != null && pageType == 'do_add') ||
          pageType == 'update') {
        Overlay.of(context).insert(loader);
        setState(() => shopTypeList.clear());

        repository.addEdFocusShopType(shopTypeData, pageType, id).then((value) {
          showToastPopup("Update Successfully", context,
              gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
        }).catchError((e) {
          print(e);
        }).whenComplete(() {
          Navigator.pop(context);
          listenForShopTypeList();
          Helper.hideLoader(loader);
        });
      } else {
        showToastPopup("Please upload your image", context,
            gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
      }
    }
  }

  addPackageType(context, id, pageType) {
    if (generalFormKey.currentState.validate()) {
      generalFormKey.currentState.save();
      if (pageType == 'do_add') {
        Overlay.of(context).insert(loader);
        setState(() => shopTypeList.clear());
        FirebaseFirestore.instance.collection('packageDetails').add({
          'name': packageTypeData.packageName,
          'maxProducts': packageTypeData.maxProductSupported,
          'maxCategory': packageTypeData.maxCategorySupported,
          'isFeaturedShop': packageTypeData.isFeaturedShop,
          'monthlyRate': packageTypeData.monthlyRate,
          'yearlyRate': packageTypeData.yearlyRate
        }).catchError((e) {
          print(e);
        }).whenComplete(() {
          Navigator.pop(context);
          listenForPackageTypeList();
          Helper.hideLoader(loader);
        });
        showToast("Update Successfully",
            gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
      }
    }
  }

  Future<void> listenForDeliveryTips() async {
    final Stream<DeliveryTipsModel> stream = await getDeliveryTips();
    stream.listen((DeliveryTipsModel _list) {
      setState(() => deliveryTipsList.add(_list));
    }, onError: (a) {
      print(a);
      print(a);
    }, onDone: () {});
  }

  Future<void> listenForShopTypeList() async {
    final Stream<ShopTypeModel> stream = await getShopTypeList();
    stream.listen((ShopTypeModel _list) {
      setState(() => shopTypeList.add(_list));
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }

  Future<void> listenForPackageTypeList() async {
    packageTypeList.clear();
    print("listenForPackageTypeList///");
    FirebaseFirestore.instance
        .collection("packageDetails")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        print(result);
        print(result.id);
        print(result.reference);
        print(result.data());
        setState(() =>
            packageTypeList.add(PackageTypeModel.fromJSON(result.data())));
      });
    }).catchError((e) {
      print(e);
    }).whenComplete(() {});
  }

  paymentStatsUpdate(type, invoiceId, id) async {
    await repository.addPaymentStatusUpdate(type, invoiceId, id).then((value) {
      showToast("Update Successfully",
          gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
    }).catchError((e) {
      loader.remove();
      // ignore: deprecated_member_use
    });
  }

  updateCurrency(context, paraType, id) async {
    if (currencyFormKey.currentState.validate()) {
      currencyFormKey.currentState.save();
      setState(() => currencyList.clear());
      if (currencyData.uploadImage != null) {
        Overlay.of(context).insert(loader);
        await repository.addCategory(currencyData, paraType, id).then((value) {
          showToast("Update Successfully",
              gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
        }).catchError((e) {
          loader.remove();
          // ignore: deprecated_member_use
        }).whenComplete(() {
          Helper.hideLoader(loader);
          Navigator.pop(context);
          // setState(() => currencyData.clear());
          listenForCurrency();
          return true;
        });
      } else {
        showToastPopup(
          "Upload your image",
          context,
          gravity: Toast.BOTTOM,
          duration: Toast.LENGTH_SHORT,
        );
      }
    }
  }

  Future<void> listenForBanner(id) async {
    if (bannerList.length != 0) {
      bannerList.clear();
    }
    final Stream<BannerModel> stream = await getBanner(id);
    stream.listen((BannerModel _banner) {
      setState(() => bannerList.add(_banner));
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }

  Future<void> listenForCurrency() async {
    print(1);
    final Stream<Currency> stream = await getCurrency();
    stream.listen((Currency _list) {
      setState(() => currencyList.add(_list));
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }

  deliveryFeesUpdate(context, id, pageType) {
    if (deliveryFeesFormKey.currentState.validate()) {
      deliveryFeesFormKey.currentState.save();
      Overlay.of(context).insert(loader);
      setState(() => deliveryFeesList.clear());

      repository
          .addEdDeliveryFees(
        deliveryFees,
        pageType,
        id,
      )
          .then((value) {
        showToastPopup("Update Successfully", context,
            gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
      }).catchError((e) {
        print(e);
      }).whenComplete(() {
        Navigator.pop(context);
        listenForDeliveryFees();
        Helper.hideLoader(loader);
      });
    }
  }

  delete(table, id) {
    repository.globalDelete(table, id).then((value) {
      showToast("Delete Successfully",
          gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
    }).catchError((e) {
      // loader.remove();
      // ignore: deprecated_member_use
    }).whenComplete(() {
      // Helper.hideLoader(loader);
      if (table == 'deliveryFees') {
        listenForDeliveryFees();
      } else if (table == 'shopFocusType') {
        listenForShopTypeList();
      } else if (table == 'packageType') {
        listenForPackageTypeList();
      } else if (table == 'banner') {
        listenForBanner(1);
      } else if (table == 'deliveryTips') {
        listenForDeliveryTips();
      } else if (table == 'currency') {
        currencyList.clear();
        listenForCurrency();
      }
    });
  }

  getDriverDetails(id) {
    repository.getDriverDetailsData(id).then((value) {
      setState(() {
        loaderData = true;
        driverDetailsData = value;
      });
    }).catchError((e) {
      loader.remove();
    }).whenComplete(() {});
  }

  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(
      msg,
      context,
      duration: duration,
      gravity: gravity,
    );
  }

  void showToastPopup(String msg, context, {int duration, int gravity}) {
    Toast.show(
      msg,
      context,
      duration: duration,
      gravity: gravity,
    );
  }

  Future<void> listenForDeliveryFees() async {
    print(1);
    final Stream<DeliveryFees> stream = await getDeliveryFees();
    stream.listen((DeliveryFees _list) {
      setState(() => deliveryFeesList.add(_list));
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }
}
