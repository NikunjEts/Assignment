String? returnCorrectStringNull(String? value) {
  if (value == null || value == "") {
    return null;
  } else {
    return value;
  }
}

String returnCorrectStringString(String? value) {
  if (value == null) {
    return "";
  } else {
    return value;
  }
}

String returnCorrectStringInt(String? value) {
  if (value == null) {
    return "0";
  } else {
    return value;
  }
}

String returnCorrectStringNumber(int? value) {
  if (value == null) {
    return "0";
  } else {
    return value.toString();
  }
}

bool returnCorrectStringBool(String? value) {
  if (value == null || value == "") {
    return false;
  } else {
    return true;
  }
}

String? returnCorrectInitialValue(bool? value) {
  if (value == null) {
    return null;
  } else if (value == true) {
    return "Yes";
  } else {
    return "No";
  }
}

bool checkChangeText(String controllerText, String? objectText) {
  bool isControllerEmpty = controllerText.isEmpty;
  bool isObjectNotNull = objectText != null;
  bool areBothSame = controllerText != objectText;

  return isControllerEmpty && isObjectNotNull || areBothSame;
}
