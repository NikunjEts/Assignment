import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../global/functions/return_correct_string.dart';
import '../../../global/models/pdf_model.dart';
import '../../../global/theme/theme.dart';
import '../../../global/widgets/textfield.dart';
import '../controller/form_controller.dart';

class PersonalDetails extends StatefulWidget {
  // final PdfModel personal;
  final Personal personal;

  const PersonalDetails(
      this.personal, {
        Key? key,
      }) : super(key: key);

  @override
  _PersonalDetailsState createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  bool isFirstTime = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController jobRoleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (isFirstTime) {
      emailController.text =widget. personal.email ?? "";
      phoneController.text = widget.personal.phoneNumber ?? "";
      firstNameController.text = widget.personal.firstName ?? "";
      lastNameController.text = widget.personal.lastName ?? "";
      jobRoleController.text =widget. personal.jobTitle ?? "";
      isFirstTime = false;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              'Personal Details',
              style: headline20.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          RectBorderFormField(
            textEditingController: emailController,
            initialValue: widget.personal.email,
            labelText: 'Email Address',
            onTextChanged: (val) {
              widget.personal.email = val;
              Provider.of<PdfNotifier>(context, listen: false).editPersonal(widget.personal);
            },
          ),
          Row(
            children: [
              Flexible(
                child: RectBorderFormField(
                  textEditingController: firstNameController,
                  initialValue: returnCorrectStringString(widget.personal.firstName),
                  labelText: 'First Name',
                  onTextChanged: (val) {
                    widget.personal.firstName = val;
                    Provider.of<PdfNotifier>(context, listen: false).editPersonal(widget.personal);
                  },
                ),
              ),
              Flexible(
                child: RectBorderFormField(
                  textEditingController: lastNameController,
                  initialValue: returnCorrectStringString(widget.personal.lastName),
                  labelText: 'Last Name',
                  onTextChanged: (val) {
                    widget.personal.lastName = val;
                    Provider.of<PdfNotifier>(context, listen: false).editPersonal(widget.personal);
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Flexible(
                child: RectBorderFormField(
                  textEditingController: jobRoleController,
                  initialValue: returnCorrectStringString(widget.personal.jobTitle),
                  labelText: 'Job Role',
                  hintText: 'eg. Software Developer',
                  onTextChanged: (val) {
                    widget.personal.jobTitle = val;
                    Provider.of<PdfNotifier>(context, listen: false).editPersonal(widget.personal);
                  },
                ),
              ),
              Flexible(
                child: RectBorderFormField(
                  textEditingController: phoneController,
                  initialValue: returnCorrectStringString(widget.personal.email),
                  labelText: 'Phone Number',
                  onTextChanged: (val) {
                    widget.personal.phoneNumber = val;
                    Provider.of<PdfNotifier>(context, listen: false).editPersonal(widget.personal);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
