void main() {
  var d = {"one": 1, "two": 2, "three": "3"};
  Map<String, String> o = {for (var e in d.keys) e: "${d[e]}"};
  print(o);
}
