class DeliverySettingsModel{
  double radius;
  bool autoassing;
  bool deliveryTips;
  bool instantDelivery;






  // used for indicate if client logged in or not
  bool auth;

//  String role;

  DeliverySettingsModel();

  DeliverySettingsModel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      radius = jsonMap['radius'].toDouble() != 0 ? jsonMap['radius'] : 0.0;
      autoassing = jsonMap['autoassing'] != null ? jsonMap['autoassing'] : false;
      deliveryTips = jsonMap['deliveryTips'] != null ? jsonMap['deliveryTips'] : false;
      instantDelivery = jsonMap['instantDelivery'] != null ? jsonMap['instantDelivery'] : false;


    } catch (e) {

      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["radius"] = radius;
    map["autoassing"] = autoassing;
    map["deliveryTips"] = deliveryTips;
    map["instantDelivery"] = instantDelivery;








    return map;
  }

  @override
  String toString() {
    var map = this.toMap();
    map["auth"] = this.auth;
    return map.toString();
  }
}