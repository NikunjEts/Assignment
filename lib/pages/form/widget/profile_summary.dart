import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../global/models/pdf_model.dart';
import '../../../global/theme/theme.dart';
import '../../../global/widgets/textfield.dart';
import '../controller/form_controller.dart';

class ProfileSummary extends StatefulWidget {
  final Summary summary;

  const ProfileSummary(
    this.summary, {
    Key? key,
  }) : super(key: key);

  @override
  _ProfileSummaryState createState() => _ProfileSummaryState();
}

class _ProfileSummaryState extends State<ProfileSummary> {
  TextEditingController summaryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance!.addPostFrameCallback((_) async {
    //   setState(() {
    //     if (checkChangeText(summaryController.text, summary.professionalSummary)) {
    //       summaryController.text = summary.professionalSummary ?? "";
    //     }
    //   });
    // });

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 10,
              top: 10,
            ),
            child: Text(
              'Profile',
              style: headline20.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          RectBorderFormField(
            textEditingController: summaryController,
            maxLines: 9,
            maxLength: 500,
            labelText: "Summary",
            hintText: 'eg. I am a motivated IT graduate looking forward...',
            onTextChanged: (val) {
              widget.summary.professionalSummary = val;
              Provider.of<PdfNotifier>(context, listen: false).editSummary(widget.summary);
            },
          ),
        ],
      ),
    );
  }
}
