import 'dart:developer';

abstract class Cipher {
  String encrypt(String plaintext);

  String decrypt(String argot);

  static const _errorDecryptMessage = 'The Plain Text Cannot Be decryptd.\n'
      'Please Check If The Code Is Correct.';

  late String sep;

  List<int> _generateIntIntWords(String plaintext) {
    List<int> codeUnits = plaintext.codeUnits;
    List<int> intIntWords = List.of(codeUnits);
    return intIntWords;
  }

  List<String> _intIntWordsToRadixStringWords(
      List<int> intIntWords, int radix) {
    List<String> radixStringWords = [];
    for (int intIntWord in intIntWords) {
      radixStringWords.add(intIntWord.toRadixString(radix));
    }
    return radixStringWords;
  }

  List<int> _radixStringWordsToIntIntWords(
      List<String> radixStringWords, int radix) {
    List<int> intIntWords = [];
    for (String radixStringWord in radixStringWords) {
      intIntWords.add(int.parse(radixStringWord, radix: radix));
    }
    return intIntWords;
  }

  String _convertIntIntWordsToString(
      {List<int> intIntWords = const [],
      List<String> intStringWords = const [],
      int Function(int intIntWord, int index, int intIntWordsLen)?
          intIntWordDecryptHandler}) {
    if (intIntWords.isEmpty && intStringWords.isEmpty) return '';
    // if (intIntWordDecryptHandler == null) return intIntWord
    intIntWordDecryptHandler ??=
        (int intIntWord, int index, int intIntWordsLen) => intIntWord;
    String string = '';
    if (intStringWords.isNotEmpty) {
      intIntWords = intStringWords
          .map((intStringWord) =>
              intStringWord.isNotEmpty ? int.parse(intStringWord) : 0)
          .toList();
    }
    for (int i = 0; i < intIntWords.length; i++) {
      int intIntWord =
          intIntWordDecryptHandler(intIntWords[i], i, intIntWords.length);
      string += String.fromCharCode(intIntWord);
    }
    return string;
  }
}

class CipherRadix extends Cipher {
  final int radix;
  int intIntWordEncryptHandler(int intIntWord, int index, int intIntWordsLen) =>
      intIntWord;
  int intIntWordDecryptHandler(int intIntWord, int index, int intIntWordsLen) =>
      intIntWord;
  CipherRadix(this.radix, [sep = ',']) {
    this.sep = sep;
  }

  @override
  String encrypt(String plaintext) {
    String argot = '';
    List<int> intIntWords = _generateIntIntWords(plaintext);
    for (int i = 0; i < intIntWords.length; i++) {
      intIntWords[i] =
          intIntWordEncryptHandler(intIntWords[i], i, intIntWords.length);
    }
    List<String> radixStringWords =
        _intIntWordsToRadixStringWords(intIntWords, radix);
    argot = radixStringWords.join(sep);
    return argot;
  }

  @override
  String decrypt(String argot) {
    String plaintext = '';
    try {
      List<String> radixStringWords = argot.split(sep);
      List<int> intIntWords =
          _radixStringWordsToIntIntWords(radixStringWords, radix);
      plaintext = _convertIntIntWordsToString(
          intIntWords: intIntWords,
          intIntWordDecryptHandler: intIntWordDecryptHandler);
    } on FormatException catch (e) {
      plaintext = e.toString();
      plaintext += Cipher._errorDecryptMessage;
    }
    return plaintext;
  }
}

class CipherExpand extends CipherRadix {
  var encryptDict = <String, String>{};
  var decryptDict = <String, String>{};

  CipherExpand(int radix, String values, [sep = ',', String keys = ''])
      : super(radix, sep) {
    keys = keys != ''
        ? keys
        : '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
            .substring(0, radix);
    log(keys);
    for (int i = 0; i < keys.length; i++) {
      encryptDict[keys[i]] = values[i];
      decryptDict[values[i]] = keys[i];
    }
  }

  @override
  String encrypt(String plaintext) {
    String argot = '';
    String argotSuper = super.encrypt(plaintext);
    encryptDict.forEach((key, value) {
      argotSuper = argotSuper.replaceAll(key, value);
    });
    argot = argotSuper;
    return argot;
  }

  @override
  String decrypt(String argot) {
    String plaintext = '';
    decryptDict.forEach((key, value) {
      argot = argot.replaceAll(key, value);
    });
    plaintext = super.decrypt(argot);
    return plaintext;
  }
}
