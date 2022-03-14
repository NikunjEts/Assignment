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

class LinksInfo extends StatefulWidget {
  final List<Links> links;

  const LinksInfo(this.links, {Key? key}) : super(key: key);

  @override
  State<LinksInfo> createState() => _LinksInfoState();
}

class _LinksInfoState extends State<LinksInfo> {
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
              'Your Links',
              style: headline20.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  key: Key(widget.links[index].linksId),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: LinksFullWidget(
                    link: widget.links[index],
                    onPressed: () {
                      Provider.of<PdfNotifier>(context, listen: false).removeLink(widget.links[index]);
                    },
                  ),
                );
              },
              itemCount: widget.links.length,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SimpleElevatedButton(
                buttonWidth: double.infinity,
                onPressed: () {
                  Provider.of<PdfNotifier>(context, listen: false).addLink(Links.createEmpty());
                },
                text: 'Add another link'),
          )
        ],
      ),
    );
  }
}

class LinksFullWidget extends StatefulWidget {
  const LinksFullWidget({
    Key? key,
    required this.link,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;
  final Links link;

  @override
  _SectionFullWidgetState createState() => _SectionFullWidgetState();
}

class _SectionFullWidgetState extends State<LinksFullWidget> {
  TextEditingController linkNameController = TextEditingController();

  TextEditingController linkUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      setState(() {
        if (checkChangeText(linkNameController.text, widget.link.linkName)) {
          linkNameController.text = widget.link.linkName ?? "";
        }
        if (checkChangeText(linkUrlController.text, widget.link.linkUrl)) {
          linkUrlController.text = widget.link.linkUrl ?? "";
        }
      });
    });

    return BorderedExpansionTile(
      title: widget.link.linkName ?? "Test",
      children: [
        Row(
          children: [
            Flexible(
              child: RectBorderFormField(
                textEditingController: linkNameController,
                labelText: 'Link Name',
                onTextChanged: (val) {
                  widget.link.linkName = val;
                  Provider.of<PdfNotifier>(context, listen: false).editLink(widget.link);
                },
              ),
            ),
            Flexible(
              child: RectBorderFormField(
                textEditingController: linkUrlController,
                labelText: 'Link URL',
                onTextChanged: (val) {
                  widget.link.linkUrl = val;
                  Provider.of<PdfNotifier>(context, listen: false).editLink(widget.link);
                },
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: SimpleOutlinedButton(color: Pallete.errorColor, buttonWidth: double.infinity, onPressed: () => widget.onPressed(), text: 'Remove this link'),
        )
      ],
    );
  }
}
