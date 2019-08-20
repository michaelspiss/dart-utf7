part of utf7;

/// Implements the encode and decode functionality
class Utf7 {
  // set D (directly encoded characters): A-Za-z0-9'()´-./:?
  // set O (optional direct characters): !"#$%&*;<=>@[]^_`{|}
  //
  // set B (base64 characters): base64, but without =

  /// Checks if the given [char] is part of set D (directly encoded characters)
  static bool _isOnlyDirectlyEncoded(int char) {
    if(char < 39 || char > 122) return false;
    if((65 <= char && char <= 90 /* A-Z */) ||
        (97 <= char && char <= 122 /* a-z */) ||
        (44 <= char && char <= 58) /* 0-9 and ´-./: */ ||
        (39 <= char && char <= 41 /* '() */) ||
        char == 63 /* ? */) return true;
    return false; // any other character in between
  }

  /// Checks if the given [char] is part of set O *OR D* (for simplicity)
  static bool _isDirectlyEncoded(int char) {
    if(char < 33 || char > 125 || char == 92 || char == 43) return false;
    return true;
  }


  /// Encodes the utf-8 [input] to the corresponding utf-7 string, also encodes
  /// optional direct characters
  ///
  /// Should be used if the utf-7 string is used at a place where those
  /// characters have a special meaning.
  static String encodeAll(String input) {

  }

  /// Encodes the utf-8 [input] to the corresponding utf-7 string.
  ///
  /// Does not encode "set O" characters, [encodeAll] should be used if used
  /// in a place where those characters have special meaning.
  static String encode(String input) {
    List<int> chars = [];
    int index;
    int char;
    List<int> charsToShift = [];
    bool shifted = false;
    while (index < input.length) {
      char = input.codeUnitAt(index);
      if (32 <= char && char <= 126) {
        if (shifted) {
          chars.add(38); // +
          // add base64 encoded string
          chars.add(45); // -
          shifted = false;
        }
        chars.add(char);
      } else {
        charsToShift.add(char);
        shifted = true;
      }
      index++;
    }
    return String.fromCharCodes(chars);
  }

  /// Decodes the utf-7 [input] to the corresponding utf-8 string.
  static String decode(String input) {}
}
