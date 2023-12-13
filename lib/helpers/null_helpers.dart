bool nullableBoolWithDefault(bool? maybeBool, bool defaultBool) {
  if (maybeBool == null) {
    return defaultBool;
  } else {
    return maybeBool;
  }
}

String nullableStringWithDefault(String? maybeString, String defaultString) {
  if (maybeString == null) {
    return defaultString;
  } else {
    return maybeString;
  }
}
