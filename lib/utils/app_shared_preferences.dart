import 'package:shared_preferences/shared_preferences.dart';

import '../global/models/pdf_model.dart';

class AppSharedPreferences {
  static String keyIsSalesLoggedIn = "keyIsSalesLoggedIn";
  static String keyPDF = "keyPDF";
  static String keyPDFList = "keyPDFList";

  static Future<SharedPreferences> getInstance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs;
  }

//<---------------------------- Clear Data -------------------------------------//

  static Future<void> clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  static Future<PdfModel> getPDF(int position) async {
    var list = await getPDFList();
    return list[position];
  }

  static Future<List<PdfModel>> setPDF(PdfModel value) async {
    var list = await getPDFList();
    int index = list.indexWhere((element) => element.pdfId == value.pdfId);
    if (index > -1) {
      list.removeAt(index);
      list.insert(index, value);
    }else{
      list.add(value);
    }
    setPDFList(list);
    return list;
  }

  static Future<bool> updatePDF(int pos, PdfModel value) async {
    List<PdfModel> list = await getPDFList();
    list.remove(pos);
    list.insert(pos, value);
    return setPDFList(list);
  }

  static Future<List<PdfModel>> deletePDF(String pdfId) async {
    var list = await getPDFList();
    list.removeWhere((element) => element.pdfId == pdfId);
    setPDFList(list);
    return list;
  }

  static Future<List<PdfModel>> getPDFList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String data = prefs.getString(keyPDFList) ?? '';
    List<PdfModel> list = [];
    if (data != null && data.isNotEmpty) {
      list = PdfModel.decodeList(data);
    }
    return list;
  }

  static Future<bool> setPDFList(List<PdfModel> value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(keyPDFList, PdfModel.encodeList(value));
  }
//
// //<---------------------------- Bool -------------------------------------//
//
//   static Future<bool> getBoolData(String key) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getBool(key) ?? false;
//   }
//
//   static Future<bool> setBoolData(String key, bool value) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.setBool(key, value);
//   }
//
// //<---------------------------- Double -------------------------------------//
//
//   static Future<double> getDoubleData(String key) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getDouble(key) ?? 0.0;
//   }
//
//   static Future<bool> setDoubleData(String key, double value) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.setDouble(key, value);
//   }
//
// //<---------------------------- Int -------------------------------------//
//
//   static Future<int> getIntegerData(String key) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getInt(key) ?? 0;
//   }
//
//   static Future<bool> setIntegerData(String key, int value) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.setInt(key, value);
//   }

}
