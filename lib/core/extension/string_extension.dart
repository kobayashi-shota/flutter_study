import 'package:flutter/foundation.dart';

extension StringExtension on String {
  /// 引数で指定した文字数だけ先頭から除いた文字列を返す
  String dropFirst(int numCharacters) {
    if (numCharacters >= length) {
      return this;
    } else {
      return substring(numCharacters);
    }
  }

  /// ISBNのバリデーション。桁数別に内部でバリデーションメソッドを呼び分ける
  bool isValidISBN() {
    final cleanedISBN = replaceAll('-', '');

    debugPrint(this);
    debugPrint('cleanedISBN: $cleanedISBN');
    debugPrint('cleanedISBN.length: ${cleanedISBN.length}');

    /// ISBNコードの桁数をチェック
    /// ISBN-10は10桁、ISBN-13は13桁
    return switch (cleanedISBN.length) {
      10 => _isValidISBN10(this),
      13 => _isValidISBN13(this),
      _ => false
    };
  }

  /// モジュラス11 ウェイト10-2
  /// ISBN-10のチェックデジットを算出する
  /// 引数のISBNのチェックデジットが正しければtrueを返す
  bool _isValidISBN10(String cleanedISBN) {
    final cleanedISBN = replaceAll('-', '');
    final lastIndex = cleanedISBN.length - 1;
    var checksum = 0;

    // 末尾はcheck digitなのでloopに含めない
    for (var index = 0; index < lastIndex; index++) {
      final digit = int.tryParse(cleanedISBN[index]);
      if (digit == null) {
        debugPrint('Non-numbers exist.');
        return false;
      }

      debugPrint('digit: $digit * ${10 - index}');

      checksum += digit * (10 - index);
    }

    final remainder = checksum % 11;
    final result = 11 - remainder;

    final lastCharacter = cleanedISBN[lastIndex].toLowerCase();
    final lastDigit = switch (lastCharacter) {
      'x' => 10,
      '0' => 11,
      _ => int.tryParse(lastCharacter)
    };

    if (lastDigit == null) {
      debugPrint('Non-numbers exist.');
      return false;
    }

    return result == lastDigit;
  }

  /// モジュラス10 ウェイト3・1
  /// ISBN-13のチェックデジットを算出する
  /// 引数のISBNのチェックデジットが正しければtrueを返す
  bool _isValidISBN13(String cleanedISBN) {
    final cleanedISBN = replaceAll('-', '');
    final lastIndex = cleanedISBN.length - 1;
    var checksum = 0;

    // 末尾はcheck digitなのでloopに含めない
    for (final (index, value) in cleanedISBN.split('').indexed) {
      if (index == lastIndex) {
        debugPrint('Loop ends because lastIndex');
        break;
      }

      final digit = int.tryParse(value);

      if (digit == null) {
        debugPrint('Non-numbers exist.');
        return false;
      }

      checksum += switch (index.isEven) {
        true => 1 * digit,
        false => 3 * digit,
      };
    }

    final lastDigit = int.tryParse(cleanedISBN[lastIndex]);
    if (lastDigit == null) {
      debugPrint('Non-numbers exist.');
      return false;
    }

    final remainder = checksum % 10;
    final result = 10 - remainder;

    debugPrint('checksum $checksum');
    debugPrint('remainder $remainder');
    debugPrint('result $result');
    debugPrint('lastDigit: $lastDigit');

    return result == lastDigit;
  }
}
