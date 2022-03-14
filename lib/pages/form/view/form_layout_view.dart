import 'package:assignment/pages/form/view/pdf_view.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';

import '../../../apis/resume.dart';
import '../../../global/models/pdf_model.dart';
import '../../../global/templates/template_personal.dart';
import '../../../global/theme/pallete.dart';
import '../../../global/theme/theme.dart';
import '../../../global/widgets/buttons.dart';
import '../../../global/widgets/shape.dart';
import '../controller/form_controller.dart';
import '../controller/resume_controller.dart';
import 'form_view.dart';

class ResumeEdit extends StatefulWidget {
  final PdfModel model;

  const ResumeEdit(this.model, {Key? key}) : super(key: key);

  @override
  _ResumeEditState createState() => _ResumeEditState();
}

class _ResumeEditState extends State<ResumeEdit> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    Provider.of<PdfNotifier>(context,listen: false).setModal(widget.model);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    List<Widget> actionButton() {
      return [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: SimpleOutlinedButton(
              onPressed: () async {
                await Printing.sharePdf(
                    bytes: await generateDocument(context, pdfModel: Provider.of<PdfNotifier>(context, listen: false).model), filename: 'resume.pdf');
              },
              text: 'Download'),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: SimpleOutlinedButton(
              onPressed: () async {
                try {
                  PdfModel model = Provider.of<PdfNotifier>(context, listen: false).model;
                  await Provider.of<UserResumeList>(context,listen: false).addToResume(pdfModel: model);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        'Your resume was saved!',
                        style: bodyText14.copyWith(color: Pallete.backgroundColor),
                      )));
                  Navigator.of(context).pop();
                } catch (e) {
                  print(e);
                }
              },
              text: 'Save'),
        ),
      ];
    }

    AppBar resumeAppbar() {
      return AppBar(
        iconTheme: const IconThemeData(color: Pallete.primaryColor),
        centerTitle: false,
        leading: IconButton(
            onPressed: () {
              // if (widget.uid == null) {
              //   Get.offAndToNamed('/');
              // } else {
              //   Get.offAndToNamed('home');
              // }
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Pallete.primaryColor,
            )),
        title: Text(
          'Resume Builder',
          style: headline20.copyWith(color: Pallete.primaryColor, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
        ),
        backgroundColor: Pallete.backgroundColor,
        shadowColor: Colors.black.withOpacity(0.3),
        elevation: 8,
      );
    }

    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 900) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
              backgroundColor: Pallete.primaryLightColor,
              appBar: AppBar(
                backgroundColor: Pallete.backgroundColor,
                iconTheme: const IconThemeData(color: Pallete.primaryColor),
                centerTitle: false,
                title: Text(
                  'Resume Builder',
                  style: headline20.copyWith(color: Pallete.primaryColor, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                ),
                bottom: TabBar(
                  labelStyle: subtitle14.copyWith(color: Pallete.primaryColor),
                  labelColor: Pallete.primaryColor,
                  unselectedLabelColor: Colors.grey.shade400,
                  unselectedLabelStyle: subtitle14.copyWith(color: Colors.grey.shade400),
                  tabs: const [
                    Tab(
                      text: 'Edit',
                    ),
                    Tab(
                      text: 'Preview',
                    ),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  Center(
                      child: Container(
                        height: double.infinity,
                        color: Pallete.backgroundColor,
                        child: const FormSide(),
                      )),
                  Scaffold(
                    backgroundColor: Pallete.primaryLightColor,
                    body: PdfDisplay(true),
                    bottomNavigationBar: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: Pallete.backgroundColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            offset: const Offset(0.0, 1.0), //(x,y)
                            blurRadius: 6.0,
                          ),
                        ],
                        borderRadius: Shape.roundedShapeOnly(topLeft: 20, topRight: 20),
                      ),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: actionButton()),
                    ),
                  ),
                ],
              )),
        );
      } else {
        return Scaffold(
          backgroundColor: Pallete.primaryLightColor,
          appBar: resumeAppbar(),
          body: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 850),
                    height: double.infinity,
                    color: Pallete.backgroundColor,
                    child: const FormSide(),
                  )),
              Flexible(
                  child: Center(
                    child: Scaffold(
                      backgroundColor: Pallete.primaryLightColor,
                      body: const PdfDisplay(false),
                      bottomNavigationBar: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: Pallete.backgroundColor,
                          borderRadius: Shape.roundedShapeOnly(topRight: 20),
                        ),
                        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: actionButton()),
                      ),
                    ),
                  )),
            ],
          ),
        );
      }
    });
  }
}