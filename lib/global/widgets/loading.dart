
import 'package:flutter/material.dart';

import '../theme/pallete.dart';

Widget progressWidget(BuildContext context) {
  return const Center(
    child: Padding(
      padding: EdgeInsets.all(15.0),
      child: CircularProgressIndicator(
        strokeWidth: 3,
        valueColor: AlwaysStoppedAnimation<Color>(Pallete.primaryColor),
      ),
    ),
  );
}
