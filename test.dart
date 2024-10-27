void main(List<String> args) {
  Set s = Set();
  Set se = Set();
  s.add(5);
  s.add(2);
  se.add(4);
  se.add(8);
  () v = ();
  s.add(v);
  print(s.runtimeType);
  print(s.toList() + se.toList());
}
