
class Bank {
  String bankName;
  String accountNo;
  String swiftCode;



  // used for indicate if client logged in or not
  bool auth;

//  String role;

  Bank();

  Bank.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      bankName = jsonMap['bankName'] != null ? jsonMap['bankName'] : '';
      accountNo = jsonMap['accountNo'] != null ? jsonMap['accountNo'] : '';
      swiftCode = jsonMap['swiftCode'] != null ? jsonMap['swiftCode'] : '';


    } catch (e) {

      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["bankName"] = bankName;
    map["accountNo"] = accountNo;
    map["swiftCode"] = swiftCode;




    return map;
  }

  @override
  String toString() {
    var map = this.toMap();
    map["auth"] = this.auth;
    return map.toString();
  }
}
