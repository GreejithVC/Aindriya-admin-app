import 'general.dart';

class VendorModel {
  double rating;
  String coverImage;
  String image;
  General general;
  bool status;
  String shopName;
  int shopId;





  // used for indicate if client logged in or not
  bool auth;

//  String role;

  VendorModel();

  VendorModel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      shopId = jsonMap['shopId'];
      rating = jsonMap['rating'].toDouble() ;
      general = jsonMap['general'] != null ? General.fromJSON(jsonMap['general']) : General.fromJSON({});
      image = jsonMap['image'] != null ? jsonMap['image'] : '';
      coverImage = jsonMap['coverImage'] != null ? jsonMap['coverImage'] : '';
      status = jsonMap['status'];
      shopName = jsonMap['shopName']!= null ? jsonMap['shopName'] : '';

    } catch (e) {

      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["rating"] = rating;
    map["general"] = general;
    map["image"] = image;
    map["coverImage"] = coverImage;
    map["status"] = status;
    map["shopName"] = shopName;



    return map;
  }

  @override
  String toString() {
    var map = this.toMap();
    map["auth"] = this.auth;
    return map.toString();
  }
}
