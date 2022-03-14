import 'package:flutter/cupertino.dart';

import '../../../global/models/pdf_model.dart';
import '../../../utils/app_shared_preferences.dart';

class UserResumeList extends ChangeNotifier {
  List<PdfModel> pdfModels = [];

  Future<void> _getResumes() async {
    try {
      pdfModels = await AppSharedPreferences.getPDFList();
    } catch (e) {
      print(e);
    }
  }

  Future<bool> addToResume({required PdfModel pdfModel}) async {
    try {
      await AppSharedPreferences.setPDF(pdfModel);
      pdfModels = await AppSharedPreferences.getPDFList();
    } catch (e) {
      print(e);
    }
    return true;
  }

  Future<bool> deleteFromResume({required PdfModel pdfModel}) async {
    try {
      await AppSharedPreferences.deletePDF(/*pdfModel.pdfId*/ 0); //TODO POSTION
      pdfModels = await AppSharedPreferences.getPDFList();
    } catch (e) {
      print(e);
    }
    return true;
  }
}
