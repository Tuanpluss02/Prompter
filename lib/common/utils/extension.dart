// 1000 -> 1000
// 10000 -> 10k
// 1000000 -> 1m
extension Shortly on num {
  String toShortString() {
    if (this <= 1000) {
      return toString();
    } else if (this <= 1000000) {
      return '${(this ~/ 1000)}k';
    } else {
      return '${(this ~/ 1000000)}m';
    }
  }
}
