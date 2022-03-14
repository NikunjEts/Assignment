import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';

import '../../../global/models/pdf_model.dart';
import '../../../global/templates/template_personal.dart';
import '../../../global/theme/pallete.dart';
import '../../../global/widgets/loading.dart';
import '../controller/form_controller.dart';

class PdfDisplay extends StatefulWidget {
  final bool useMobileLayout;

  const PdfDisplay(this.useMobileLayout, {Key? key}) : super(key: key);

  @override
  _PdfDisplayState createState() => _PdfDisplayState();
}

class _PdfDisplayState extends State<PdfDisplay> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      backgroundColor: Pallete.primaryLightColor,
      body: Theme(
        data: ThemeData(primaryColor: Pallete.backgroundColor, primaryIconTheme: const IconThemeData(color: Pallete.primaryColor)),
        child: Center(
          child: SizedBox(
            height: widget.useMobileLayout ? MediaQuery.of(context).size.height - 156 : MediaQuery.of(context).size.height - 80,
            child: Consumer<PdfNotifier>(builder: (context, _notifier, child) {
              PdfModel _pdfProvider = _notifier.model;
              return PdfPreview(
                loadingWidget: progressWidget(context),
                scrollViewDecoration: const BoxDecoration(
                  color: Pallete.primaryLightColor,
                ),
                pdfPreviewPageDecoration: const BoxDecoration(),
                useActions: false,
                maxPageWidth: widget.useMobileLayout ? null : MediaQuery.of(context).size.width / 2 - (80),
                allowPrinting: true,
                allowSharing: true,
                canDebug: false,
                canChangeOrientation: false,
                canChangePageFormat: false,
                build: (format) => generateDocument(context, pdfModel: _pdfProvider),
              );
            }),
          ),
        ),
      ),
    );
  }
}
