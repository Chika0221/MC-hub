class KeyData {
  final String id;
  final String defaultLabel;
  final double width;
  final double height;
  final double xOffset;

  const KeyData({
    required this.id,
    required this.defaultLabel,
    this.width = 1.0,
    this.height = 1.0,
    this.xOffset = 0.0,
  });
}
