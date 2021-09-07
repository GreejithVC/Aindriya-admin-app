
class General {

  String name;
  String shopName;
  String subTitle;
  String email;
  String password;
  String alternativeMobile;
  String phone;
  String openTime;
  String closeTime;
  String startedYear;
  String description;
  String address;







  // used for indicate if client logged in or not
  bool auth;

//  String role;

  General();

  General.fromJSON(Map<String, dynamic> jsonMap) {
    try {

      name = jsonMap['name'] != null ? jsonMap['name'] : '';
      shopName = jsonMap['shopName'] != null ? jsonMap['shopName'] : '';
      subTitle = jsonMap['subTitle'] != null ? jsonMap['subTitle'] : '';
      email = jsonMap['email'] != null ? jsonMap['email'] : '';
      phone = jsonMap['phone'];
      alternativeMobile = jsonMap['alternativeMobile'];
      openTime = jsonMap['openTime'];
      closeTime = jsonMap['closeTime'];
      startedYear = jsonMap['startedYear'];
      description = jsonMap['description'];
      password = jsonMap['password'];
      address = jsonMap['address'];



    } catch (e) {
      shopName = '';
      email ='';
      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();

    map["email"] = email;
    map["name"] = name;
    map['shopName'] = shopName;
    map["subTitle"] = subTitle;
    map["alternativeMobile"] = alternativeMobile;
    map["openTime"] = openTime;
    map["closeTime"] = closeTime;
    map["description"] = description;
    map["startedYear"] = startedYear;
    map["password"] = password;
    map["phone"] = phone;
    map["address"] = address;

    return map;
  }

  @override
  String toString() {
    var map = this.toMap();
    map["auth"] = this.auth;
    return map.toString();
  }
}
