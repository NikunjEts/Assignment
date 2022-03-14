import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../global/models/pdf_model.dart';
import '../controller/form_controller.dart';
import '../widget/education_history.dart';
import '../widget/employment_history.dart';
import '../widget/extra_curriculars.dart';
import '../widget/languages.dart';
import '../widget/links.dart';
import '../widget/personal_details.dart';
import '../widget/profile_summary.dart';
import '../widget/skills.dart';

class FormSide extends StatefulWidget {
  const FormSide({Key? key}) : super(key: key);

  @override
  State<FormSide> createState() => _FormSideState();
}

class _FormSideState extends State<FormSide> {
  String? name;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Consumer<PdfNotifier>(builder: (context, _notifier, child) {
          PdfModel _model = _notifier.model;
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PersonalDetails(_model.resumePersonal!=null ?_model.resumePersonal! : Personal.createEmpty()),
              const SizedBox(height: 8),
              ProfileSummary(_model.resumeSummary!=null ?_model.resumeSummary! : Summary.createEmpty()),
              const SizedBox(height: 8),
              LinksInfo(_model.links!=null ? _model.links! : []),
              const SizedBox(height: 8),
              EmploymentHistory(_model.employment!=null ? _model.employment! : []),
              const SizedBox(height: 8),
              EducationHistory(_model.education!=null ? _model.education! : []),
              const SizedBox(height: 8),
              SkillsInfo(_model.skills!=null ? _model.skills! : []),
              const SizedBox(height: 8),
              Extracurriculars(_model.activities!=null ? _model.activities! : []),
              const SizedBox(height: 8),
              LanguagesInfo(_model.languages!=null ? _model.languages! : []),
              const SizedBox(height: 8),
            ],
          );
        }),
      ),
    );
  }
}
