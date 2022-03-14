import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../global/theme/theme.dart';
import '../pages/form/controller/form_controller.dart';
import '../pages/form/controller/resume_controller.dart';
import '../pages/form/view/form_layout_view.dart';
import '../pages/home/view/logged_home_view.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (context) => UserResumeList(),
      ),
      ChangeNotifierProvider(
        create: (context) => PdfNotifier(),
      ),
    ], child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Resume Builder",
      debugShowCheckedModeBanner: false,
      builder: (context, widget) => ResponsiveWrapper.builder(
        widget!,
        background: Container(
          color: Colors.grey.shade50,
        ),
        defaultScale: true,
        breakpoints: const [
          ResponsiveBreakpoint.resize(450, name: MOBILE),
          ResponsiveBreakpoint.autoScale(800, name: TABLET),
          ResponsiveBreakpoint.autoScale(1000, name: TABLET),
          ResponsiveBreakpoint.resize(1200, name: DESKTOP),
          ResponsiveBreakpoint.autoScale(2460, name: "4K"),
        ],
      ),
      theme: lightThemeDta,
      initialRoute: '/',
      home: LoggedHomeAuthView(),
    );
  }
}