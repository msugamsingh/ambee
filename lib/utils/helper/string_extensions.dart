
extension NullEmptyCheckExtension on String? {
  bool get isNullOrEmpty {
    var trimmed = this?.trim();
    return trimmed == null || trimmed.isEmpty;
  }
}


extension StringToDouble on String? {
  double? get toDouble {
    if (this == null) return null;
    double? n;
    try {
      n = double.parse(this!);
    } catch(e) {
      n = null;
    }
    return n;
  }
}

extension EmailValidator on String {
  bool get isValidEmail {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}