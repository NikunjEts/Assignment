import 'package:flutter/cupertino.dart';

import '../global/models/pdf_model.dart';
import '../utils/app_shared_preferences.dart';
class PdfModelApi extends ChangeNotifier {
  Future<bool> updatePdfModel(String id, PdfModel data) async {
    try {
      await AppSharedPreferences.setPDF(data);
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> deletePdfModel(int pos) async {
    try {
      await AppSharedPreferences.deletePDF(pos);
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<PdfModel> getSinglePdf(int pos) async {
    try {
      return await AppSharedPreferences.getPDF(pos);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<PdfModel>> retrievePdfModel() async {
    try {
      return AppSharedPreferences.getPDFList();
    } catch (e) {
      rethrow;
    }
  }
}
