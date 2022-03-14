import 'package:flutter/cupertino.dart';

import '../../../global/models/pdf_model.dart';
import '../../../utils/app_shared_preferences.dart';

class UserResumeList extends ChangeNotifier {
  List<PdfModel> pdfModels = [];

  Future<void> getResumes() async {
    pdfModels = await AppSharedPreferences.getPDFList();
    notifyListeners();
  }

  Future<void> addToResume({required PdfModel pdfModel}) async {
    pdfModels = await AppSharedPreferences.setPDF(pdfModel);
    notifyListeners();
  }

  Future<void> deleteFromResume({required PdfModel pdfModel}) async {
    pdfModels = await AppSharedPreferences.deletePDF(pdfModel.pdfId);
    notifyListeners();
  }

  Future<PdfModel> getSinglePdf(int pos) async {
    try {
      return await AppSharedPreferences.getPDF(pos);
    } catch (e) {
      rethrow;
    }
  }
}
