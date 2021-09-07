

import '../helpers/custom_trace.dart';

class BannerModel {
  String type;
  String title;
  String para;
  String id;
  var  uploadImage;

  BannerModel();

  BannerModel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      type = jsonMap['type'];
      title = jsonMap['title'];
      para = jsonMap['para'];
      id  = jsonMap['id'];
      uploadImage = jsonMap['uploadImage'];
    } catch (e) {
      type = '';
      title = '';
      para = '';
      id = '';
      uploadImage = '';
      print(CustomTrace(StackTrace.current, message: e));
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["type"] = type;
    map["title"] = title;
    map["para"] = para;
    map["id"] = id;
    map["uploadImage"] = uploadImage;

    return map;
  }


}
