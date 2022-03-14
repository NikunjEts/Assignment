import 'package:flutter/material.dart';
import '../../../global/functions/return_correct_string.dart';
import '../../../global/models/pdf_model.dart';
import '../../../global/theme/pallete.dart';
import '../../../global/theme/theme.dart';
import '../../../global/widgets/buttons.dart';
import '../../../global/widgets/expansion.dart';
import '../../../global/widgets/textfield.dart';
import 'package:provider/provider.dart';

import '../controller/form_controller.dart';

class EducationHistory extends StatefulWidget {
  final List<Section> _educationList;
  const EducationHistory(this._educationList,{Key? key}) : super(key: key);

  @override
  State<EducationHistory> createState() => _EducationHistoryState();
}

class _EducationHistoryState extends State<EducationHistory> {
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 20,
              top: 10,
            ),
            child: Text(
              'Education History',
              style: headline20.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: /*Consumer<PdfNotifier>(builder: (context, _notifier, child) {
              List<Section> widget._educationList = _notifier.model.education != null ? _notifier.model.education! : [];
              return */ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    key: Key(widget._educationList[index].sectionId),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: SectionFullWidget(
                      section: widget._educationList[index],
                      onPressed: () {
                        Provider.of<PdfNotifier>(context, listen: false).removeEducationSection(widget._educationList[index]);
                      },
                    ),
                  );
                },
                itemCount: widget._educationList.length,
              )/*;
            })*/,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SimpleElevatedButton(
                buttonWidth: double.infinity,
                onPressed: () {
                  Provider.of<PdfNotifier>(context, listen: false).addEducationSection(Section.createEmpty("Education"));
                },
                text: 'Add another education'),
          )
        ],
      ),
    );
  }
}

class SectionFullWidget extends StatefulWidget {
  const SectionFullWidget({
    Key? key,
    required this.section,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;
  final Section section;

  @override
  _SectionFullWidgetState createState() => _SectionFullWidgetState();
}

class _SectionFullWidgetState extends State<SectionFullWidget> {
  TextEditingController jobController = TextEditingController();
  TextEditingController employerController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      setState(() {
        if (checkChangeText(jobController.text, widget.section.textOne)) {
          jobController.text = widget.section.textOne ?? "";
        }
        if (checkChangeText(employerController.text, widget.section.textTwo)) {
          employerController.text = widget.section.textTwo ?? "";
        }
        if (checkChangeText(cityController.text, widget.section.textThree)) {
          cityController.text = widget.section.textThree ?? "";
        }
        if (checkChangeText(startDateController.text, widget.section.startDate)) {
          startDateController.text = widget.section.startDate ?? "";
        }
        if (checkChangeText(endDateController.text, widget.section.endDate)) {
          endDateController.text = widget.section.endDate ?? "";
        }
        if (checkChangeText(descriptionController.text, widget.section.description)) {
          descriptionController.text = widget.section.description ?? "";
        }
      });
    });

    return BorderedExpansionTile(
      title: widget.section.textOne ?? "Test",
      children: [
        Row(
          children: [
            Flexible(
              child: RectBorderFormField(
                textEditingController: jobController,
                labelText: 'School',
                onTextChanged: (val) {
                  widget.section.textOne = val;
                  Provider.of<PdfNotifier>(context, listen: false).editEducationSection(widget.section);
                },
              ),
            ),
            Flexible(
              child: RectBorderFormField(
                textEditingController: employerController,
                labelText: 'Degree',
                onTextChanged: (val) {
                  widget.section.textTwo = val;
                  Provider.of<PdfNotifier>(context, listen: false).editEducationSection(widget.section);
                },
              ),
            ),
          ],
        ),
        Row(
          children: [
            Flexible(
              child: Row(
                children: [
                  Flexible(
                    child: RectBorderFormField(
                      textEditingController: startDateController,
                      labelText: 'Start Date',
                      onTextChanged: (val) {
                        widget.section.startDate = val;
                        Provider.of<PdfNotifier>(context, listen: false).editEducationSection(widget.section);
                      },
                    ),
                  ),
                  Flexible(
                    child: RectBorderFormField(
                      textEditingController: endDateController,
                      labelText: 'End Date',
                      onTextChanged: (val) {
                        widget.section.endDate = val;
                        Provider.of<PdfNotifier>(context, listen: false).editEducationSection(widget.section);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: RectBorderFormField(
                textEditingController: cityController,
                labelText: 'City',
                onTextChanged: (val) {
                  widget.section.textThree = val;
                  Provider.of<PdfNotifier>(context, listen: false).editEducationSection(widget.section);
                },
              ),
            ),
          ],
        ),
        RectBorderFormField(
          maxLines: 9,
          maxLength: 500,
          labelText: "Description",
          textEditingController: descriptionController,
          onTextChanged: (val) {
            widget.section.description = val;
            Provider.of<PdfNotifier>(context, listen: false).editEducationSection(widget.section);
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child:
              SimpleOutlinedButton(color: Pallete.errorColor, buttonWidth: double.infinity, onPressed: () => widget.onPressed(), text: 'Remove this education'),
        )
      ],
    );
  }
}
