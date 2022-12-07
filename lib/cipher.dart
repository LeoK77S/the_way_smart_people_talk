import 'package:the_way_smart_people_talk/cipher_base.dart';

enum CipherType { easy16, easyNhywzy, normalNhywzy }

String getCipherTypeDescription(CipherType cipherType) {
  switch (cipherType) {
    case CipherType.easy16:
      return '十六进制密码器(简单)';
    case CipherType.easyNhywzy:
      return '你还要我怎样(简单)';
    case CipherType.normalNhywzy:
      return '你还要我怎样(普通)';
  }
}

class CipherExpandEasy16 extends CipherExpand {
  CipherExpandEasy16(String values, [String? sep])
      : super('0123456789abcdef', values, CipherRadix(16), sep);
}

class CipherEasyNhywzy extends CipherExpandEasy16 {
  CipherEasyNhywzy() : super('你还要我怎样突然来的短信就够悲伤', '，');
}

class CipherNormalNhywzyBase extends CipherRadix {
  @override
  int intIntWordEncryptHandler(int intIntWord, int index, int intIntWordsLen) {
    return intIntWord + index + intIntWordsLen;
  }

  @override
  int intIntWordDecryptHandler(int intIntWord, int index, int intIntWordsLen) {
    return intIntWord - intIntWordsLen - index;
  }

  CipherNormalNhywzyBase(int radix) : super(radix);
}

class CipherNormalNhywzy extends CipherExpand {
  CipherNormalNhywzy()
      : super('0123456789abcdef', '你还要我怎样突然来的短信就够悲伤',
            CipherNormalNhywzyBase(16), '！');
}
