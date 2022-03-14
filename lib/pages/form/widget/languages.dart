import 'package:flutter/material.dart';
import '../../../global/functions/return_correct_string.dart';
import '../../../global/models/pdf_model.dart';
import '../../../global/theme/pallete.dart';
import '../../../global/theme/theme.dart';
import '../../../global/widgets/buttons.dart';
import '../../../global/widgets/expansion.dart';
import '../../../global/widgets/textfield.dart';
import '../controller/form_controller.dart';
import 'package:provider/provider.dart';

class LanguagesInfo extends StatefulWidget {
  final List<Skill> languagesList;

  const LanguagesInfo(this.languagesList, {Key? key}) : super(key: key);

  @override
  State<LanguagesInfo> createState() => _LanguagesInfoState();
}

class _LanguagesInfoState extends State<LanguagesInfo> {
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
              'Your Languages',
              style: headline20.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: /*Consumer<PdfNotifier>(builder: (context, _notifier, child) {
                List<Skill> languagesList = _notifier.model.languages != null ? _notifier.model.languages! : [];

                return*/
                ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  key: Key(widget.languagesList[index].skillId),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: LanguageFullWidget(
                    language: widget.languagesList[index],
                    onPressed: () {
                      Provider.of<PdfNotifier>(context, listen: false).removeLanguage(widget.languagesList[index]);
                    },
                  ),
                );
              },
              itemCount: widget.languagesList.length,
            ) /*;
              })*/
            ,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SimpleElevatedButton(
                buttonWidth: double.infinity,
                onPressed: () {
                  Provider.of<PdfNotifier>(context, listen: false).addLanguage(Skill.createEmpty("Language"));
                },
                text: 'Add another language'),
          )
        ],
      ),
    );
  }
}

class LanguageFullWidget extends StatefulWidget {
  const LanguageFullWidget({
    Key? key,
    required this.language,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;
  final Skill language;

  @override
  _SectionFullWidgetState createState() => _SectionFullWidgetState();
}

class _SectionFullWidgetState extends State<LanguageFullWidget> {
  TextEditingController languageNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      setState(() {
        if (checkChangeText(languageNameController.text, widget.language.skillName)) {
          languageNameController.text = widget.language.skillName ?? "";
        }
      });
    });

    return BorderedExpansionTile(
      title: widget.language.skillName ?? "Test",
      children: [
        RectBorderFormField(
          textEditingController: languageNameController,
          labelText: 'Skill Name',
          onTextChanged: (val) {
            widget.language.skillName = val;
            Provider.of<PdfNotifier>(context, listen: false).editLanguage(widget.language);
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child:
              SimpleOutlinedButton(color: Pallete.errorColor, buttonWidth: double.infinity, onPressed: () => widget.onPressed(), text: 'Remove this language'),
        )
      ],
    );
  }
}
