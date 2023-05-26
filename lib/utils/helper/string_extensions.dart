
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
    } finally {
      n = null;
    }
    return n;
  }
}