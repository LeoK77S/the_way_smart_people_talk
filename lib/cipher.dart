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

class CipherEasyNhywzy extends CipherExpand {
  CipherEasyNhywzy() : super(16, '你还要我怎样突然来的短信就够悲伤', '，');
}

class CipherNormalNhywzy extends CipherExpand {
  @override
  int intIntWordEncryptHandler(int intIntWord, int index, int intIntWordsLen) {
    return intIntWord + index + intIntWordsLen;
  }

  @override
  int intIntWordDecryptHandler(int intIntWord, int index, int intIntWordsLen) {
    return intIntWord - intIntWordsLen - index;
  }

  CipherNormalNhywzy() : super(16, '你还要我怎样突然来的短信就够悲伤', '！');
}
