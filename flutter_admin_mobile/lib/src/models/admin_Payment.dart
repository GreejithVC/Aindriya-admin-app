class AdminPayment {
  String razorpay;
  String strip;
  String minimumPurchase;
  String currency;
  String driverCommission;
  String cancelTimer;




  // used for indicate if client logged in or not
  bool currencyPosition;

//  String role;

  AdminPayment();

  AdminPayment.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      razorpay = jsonMap['rayzopay'] != null ? jsonMap['rayzopay'] : '';
      strip = jsonMap['strip'] != null ? jsonMap['strip'] : '';
      currency = jsonMap['currency'] != null ? jsonMap['currency'] : '';
      minimumPurchase = jsonMap['minimumPurchase'] != null ? jsonMap['minimumPurchase'] : '';
      currencyPosition = jsonMap['currencyPosition'] != null ? jsonMap['currencyPosition'] : false;
      driverCommission = jsonMap['driverCommission'] != null ? jsonMap['driverCommission'] : '';
      cancelTimer = jsonMap['cancelTimer'] != null ? jsonMap['cancelTimer'] : '';



    } catch (e) {

      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["rayzopay"] = razorpay;
    map["strip"] = strip;
    map["minimumPurchase"] = minimumPurchase;
    map["currency"] = currency;
    map["currencyPosition"] = currencyPosition;
    map["driverCommission"] = driverCommission;
    map["cancelTimer"] = cancelTimer;







    return map;
  }



}