import 'package:encrypt/encrypt.dart';
import 'package:encrypt/encrypt_io.dart';
import 'package:flutter/services.dart';
import 'package:pointycastle/asymmetric/api.dart';

class Encrypt {
  static Future<String> encryptString(String rawString) async {
    final publicKeyString = await rootBundle.loadString('lib/core/public.pem');
    final publicKey = RSAKeyParser().parse(publicKeyString);
    final encrypter = Encrypter(RSA(publicKey: publicKey));
    final encrypted = encrypter.encrypt(rawString);
    return encrypted.base64;
  }
}
