// 1000 -> 1000
// 10000 -> 10k
// 10345 -> 10.3k
// 1000000 -> 1m
// 1010000 -> 1.1m
// 10000000 -> 10m
// 10660000 -> 10.6m
// 106600000 -> 106.6m
extension Shortly on num {
  String toShortString() {
    if (this < 1000) {
      return toString();
    } else if (this < 1000000) {
      return '${(this / 1000).toStringAsFixed(this % 1000 == 0 ? 0 : 1)}k';
    } else {
      return '${(this / 1000000).toStringAsFixed(this % 1000000 == 0 ? 0 : 1)}m';
    }
  }
}
