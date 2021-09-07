import 'vendor.dart';
import '../helpers/custom_trace.dart';

class VendorAllModel {
  String id;
  String shopType;
  List<VendorModel> vendor;

  VendorAllModel();

  VendorAllModel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
vendor =
          jsonMap['vendor'] != null ? List.from(jsonMap['vendor']).map((element) => VendorModel.fromJSON(element)).toList() : [];
      shopType = jsonMap['shopType'];
    } catch (e) {
      id = '';
      vendor = [];
      shopType = '';
      print(CustomTrace(StackTrace.current, message: e));
    }
  }
}
