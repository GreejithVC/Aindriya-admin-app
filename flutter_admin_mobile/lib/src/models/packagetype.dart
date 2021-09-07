


class PackageTypeModel {
 int id;
 String maxProductSupported;
 String maxCategorySupported;
 String focusPackageTypeName;
 bool featuredShop;
 String monthlyRate;
 String yearlyRate;

 var previewImage;
 var coverImage;
 String packageTypeId;







  // used for indicate if client logged in or not
  bool auth;

//  String role;

  PackageTypeModel();

  PackageTypeModel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'];
      focusPackageTypeName = jsonMap['focusPackageTypeName'] != null ? jsonMap['focusPackageTypeName'] : '';
      maxProductSupported = jsonMap['maxProductSupported'] != null ? jsonMap['maxProductSupported'] : '';
      maxCategorySupported = jsonMap['maxCategorySupported'] != null ? jsonMap['maxCategorySupported'] : '';
      featuredShop = jsonMap['featuredShop'] != null ? jsonMap['featuredShop'] : '';
      monthlyRate = jsonMap['monthlyRate'] != null ? jsonMap['monthlyRate'] : '';
      yearlyRate = jsonMap['yearlyRate'] != null ? jsonMap['yearlyRate'] : '';


      previewImage = jsonMap['previewImage'] != null ? jsonMap['previewImage'] : '';
      coverImage = jsonMap['coverImage'] != null ? jsonMap['coverImage'] : '';
      packageTypeId = jsonMap['shopTypeId'] != null ? jsonMap['shopTypeId'] : '';


    } catch (e) {

      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["title"] = focusPackageTypeName;
    map["previewImage"] = previewImage;
    map["coverImage"] = coverImage;
    map["shopFocusType"] = packageTypeId;
    map["id"] = id;



    return map;
  }

  @override
  String toString() {
    var map = this.toMap();
    map["auth"] = this.auth;
    return map.toString();
  }
}
