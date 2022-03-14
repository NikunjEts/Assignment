import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../global/models/pdf_model.dart';
import '../../../global/theme/pallete.dart';
import '../../../global/theme/theme.dart';
import '../../../global/widgets/shape.dart';
import '../../form/controller/resume_controller.dart';
import '../../form/view/form_layout_view.dart';

class LoggedHomeAuthView extends StatelessWidget {
  const LoggedHomeAuthView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: LayoutBuilder(
      builder: (context, size) {
        if (size.maxWidth > 750) {
          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: SizedBox(
              width: 850,
              height: 600,
              child: Card(
                elevation: 8,
                shape: Shape.roundedRectangleBorderAll(20),
                shadowColor: Colors.black.withOpacity(0.4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ResumeList(false),
                  ],
                ),
              ),
            ),
          );
        }

        return Scaffold(
          backgroundColor: Pallete.backgroundColor,
          appBar: AppBar(
            backgroundColor: Pallete.primaryLightColor,
            elevation: 0,
            centerTitle: false,
            title: Text(
              'RESUME BUILDER',
              style: headline20.copyWith(color: Pallete.primaryColor, fontWeight: FontWeight.bold),
            ),
          ),
          body: Container(
            height: double.infinity,
            color: Pallete.primaryLightColor,
            child: ResumeList(true),
          ),
        );
      },
    )),
      floatingActionButton: FloatingActionButton(
        elevation: 10.0,
        child: Icon(Icons.add),
        backgroundColor: Pallete.primaryColor,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ResumeEdit(PdfModel.createEmpty())));
        },
      ),
    );
  }
}

class ResumeList extends StatefulWidget {
  final bool useMobileLayout;

  const ResumeList(this.useMobileLayout, {Key? key}) : super(key: key);

  @override
  State<ResumeList> createState() => _ResumeListState();
}

class _ResumeListState extends State<ResumeList> {
  @override
  void initState() {
    super.initState();
    Provider.of<UserResumeList>(context, listen: false).getResumes();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Pallete.backgroundColor,
      child: Padding(
        padding: widget.useMobileLayout ? const EdgeInsets.all(16.0) : const EdgeInsets.all(36.0),
        child: Consumer<UserResumeList>(builder: (context, _notifier, child) {
          List<PdfModel> resumes = _notifier.pdfModels;
          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 16,
              );
            },
            itemBuilder: (context, index) {
              return AddResumeWidget(
                pdfModel: resumes[index],
              );
            },
            itemCount: resumes.length,
          );
        }),
      ),
    );
  }
}

class AddResumeWidget extends StatelessWidget {
  final PdfModel pdfModel;

  const AddResumeWidget({
    Key? key,
    required this.pdfModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 75,
        width: double.infinity,
        decoration: BoxDecoration(borderRadius: Shape.roundedShapeAll(10), border: Border.all(color: Pallete.secondaryBackgroundColor, width: 1.5)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(pdfModel.resumePersonal!.firstName ?? " [BLANK] ", style: subtitle14.copyWith(color: Pallete.textColor, fontWeight: FontWeight.bold)),
                ],
              ),
              const Spacer(),
              IconButton(
                icon: Icon(Icons.delete_outline),
                color: Pallete.errorColor,
                onPressed: () async {
                  await Provider.of<UserResumeList>(context, listen: false).deleteFromResume(pdfModel: pdfModel);
                },
              ),
              IconButton(
                icon: Icon(Icons.edit),
                color: Pallete.primaryColor,
                onPressed: () async {
                  // Get.toNamed('/resume/${pdfModel.pdfId}');
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ResumeEdit(pdfModel)));
                },
              ),
            ],
          ),
        ));
  }
}
