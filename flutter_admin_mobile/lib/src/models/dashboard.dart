
class Dashboard {
  int newOrders = 0;
  int processing = 0;
  int outForDelivery = 0;
  int completed = 0;
  int newOrdersPercent =0;
  int processingPercent =0 ;
  int outForDeliveryPercent =0;
  int completePercent = 0;
  double totalEarnCod = 0;
  double totalEarnOnline =0;
  double totalEarn = 0;
  int vendorNew;
  int userNew;
  int driverNew;
  double thisMonthEarn = 0;


  Dashboard();

  Dashboard.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      newOrders = jsonMap['newOrders'] !=null?jsonMap['newOrders']:0;
      processing = jsonMap['processing']!=null?jsonMap['processing']:0;
      outForDelivery = jsonMap['outForDelivery']!=null?jsonMap['outForDelivery']:0;
      completed = jsonMap['completed']!=null?jsonMap['completed']:0;
      newOrdersPercent = jsonMap['newOrdersPercent']!=null?jsonMap['newOrdersPercent']:0;
      processingPercent = jsonMap['processingPercent']!=null?jsonMap['processingPercent']:0;
      outForDeliveryPercent = jsonMap['outForDeliveryPercent']!=null?jsonMap['outForDeliveryPercent']:0;
      completePercent = jsonMap['completePercent']!=null?jsonMap['completePercent']:0;
      totalEarnCod = jsonMap['totalEarnCod']!=null?jsonMap['totalEarnCod'].toDouble():0;
      thisMonthEarn = jsonMap['thisMonthEarn'].toDouble()!=null?jsonMap['thisMonthEarn'].toDouble():0;
      totalEarnOnline = jsonMap['totalEarnOnline']!=null?jsonMap['totalEarnOnline'].toDouble():0;
      totalEarn = jsonMap['totalEarn']!=null?jsonMap['totalEarn'].toDouble():0;
      vendorNew = jsonMap['vendorNew'];
      userNew = jsonMap['userNew'];
      driverNew = jsonMap['driverNew'];
    } catch (e) {

      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["newOrders"] = newOrders;
    map["processing"] = processing;
    map["outForDelivery"] = outForDelivery;
    map["completed"] = completed;
    map["newOrdersPercent"] = newOrdersPercent;
    map["processingPercent"] = processingPercent;
    map["outForDeliveryPercent"] = outForDeliveryPercent;
    map["completePercent"] = completePercent;
    map["totalEarnCod"] = totalEarnCod;
    map["totalEarnOnline"] = totalEarnOnline;
    map["totalEarn"] = totalEarn;
    map["vendorNew"] = vendorNew;
    map["userNew"] = userNew;
    map["driverNew"] = driverNew;




    return map;
  }


}
