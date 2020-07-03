import 'package:crypto/crypto.dart';
import 'dart:convert'; // for the utf8.encode method

class HashUtils {
  static HashUtils instance = HashUtils();

  /// Function to hashing string
  String hash(String text) {
    var bytes = utf8.encode(text); // data being hashed
    return sha1.convert(bytes).toString();
  }
}