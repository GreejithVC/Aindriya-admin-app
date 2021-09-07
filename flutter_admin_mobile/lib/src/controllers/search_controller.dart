import '../models/driver.dart';
import '../models/orderlist.dart';
import '../models/user_model.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:toast/toast.dart';

class SearchController extends ControllerMVC {
  //GlobalKey<FormState> bannerFormKey;

  List<OrderList> orderList = <OrderList>[];
  SearchController() {

    //  bannerFormKey = new GlobalKey<FormState>();

  }








  filterListUser( List<UserModel> users, String filterString) {
    List<UserModel> tempUsers = users;
    List<UserModel> _users = tempUsers
        .where((u) =>
    (u.userName.toLowerCase().contains(filterString.toLowerCase())) ||
        (u.id.toString().toLowerCase().contains(filterString.toLowerCase())))
        .toList();

    return _users;
  }

  filterListDriver( List<DriverModel> users, String filterString) {
    List<DriverModel> tempUsers = users;
    List<DriverModel> _users = tempUsers
        .where((u) =>
    (u.userName.toLowerCase().contains(filterString.toLowerCase())) ||
        (u.id.toString().toLowerCase().contains(filterString.toLowerCase())))
        .toList();

    return _users;
  }




  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity ,);
  }

}