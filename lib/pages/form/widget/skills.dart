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

class SkillsInfo extends StatefulWidget {
  final List<Skill> skillsList;
  const SkillsInfo(this.skillsList,{Key? key}) : super(key: key);

  @override
  State<SkillsInfo> createState() => _SkillsInfoState();
}

class _SkillsInfoState extends State<SkillsInfo> {
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
              'Your Skills',
              style: headline20.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: /*Consumer<PdfNotifier>(builder: (context, _notifier, child) {
              List<Skill> skillsList = _notifier.model.skills != null ? _notifier.model.skills! : [];
              return */ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    key: Key(widget.skillsList[index].skillId),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: SkillFullWidget(
                      skill: widget.skillsList[index],
                      onPressed: () {
                        Provider.of<PdfNotifier>(context, listen: false).removeSkill(widget.skillsList[index]);
                      },
                    ),
                  );
                },
                itemCount: widget.skillsList.length,
              )/*;
            })*/,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SimpleElevatedButton(
                buttonWidth: double.infinity,
                onPressed: () {
                  Provider.of<PdfNotifier>(context, listen: false).addSkill(Skill.createEmpty("Skill"));
                },
                text: 'Add another skill'),
          )
        ],
      ),
    );
  }
}

class SkillFullWidget extends StatefulWidget {
  const SkillFullWidget({
    Key? key,
    required this.skill,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;
  final Skill skill;

  @override
  _SectionFullWidgetState createState() => _SectionFullWidgetState();
}

class _SectionFullWidgetState extends State<SkillFullWidget> {
  TextEditingController skillNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      setState(() {
        if (checkChangeText(skillNameController.text, widget.skill.skillName)) {
          skillNameController.text = widget.skill.skillName ?? "";
        }
      });
    });

    return BorderedExpansionTile(
      title: widget.skill.skillName ?? "Test",
      children: [
        RectBorderFormField(
          textEditingController: skillNameController,
          labelText: 'Skill Name',
          onTextChanged: (val) {
            widget.skill.skillName = val;
            Provider.of<PdfNotifier>(context, listen: false).editSkill(widget.skill);
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: SimpleOutlinedButton(color: Pallete.errorColor, buttonWidth: double.infinity, onPressed: () => widget.onPressed(), text: 'Remove this skill'),
        )
      ],
    );
  }
}
