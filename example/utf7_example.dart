import 'package:utf7/utf7.dart';

main() {
  String encoded = Utf7.encode("Tèxt cöntäînîng ûtf-8 chäräctérs");
  String decoded = Utf7.decode(encoded);
}
