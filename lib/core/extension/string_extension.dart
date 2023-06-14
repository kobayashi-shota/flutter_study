import 'package:flutter/foundation.dart';
import 'package:flutter_study/core/extension/int_extension.dart';

extension StringExtension on String {
  /// 引数で指定した文字数だけ先頭から除いた文字列を返す
  String dropFirst(int numCharacters) {
    if (numCharacters >= length) {
      return this;
    } else {
      return substring(numCharacters);
    }
  }

  String dropLast(int index) {
    if (index >= length) {
      return '';
    } else {
      return substring(0, length - index);
    }
  }

  /// ISBNのバリデーションチェック。
  /// ISBN13のチェックデジットが正しければtrueを返す
  bool isValidISBN13() {
    debugPrint(this);

    final checkDigit = IntExtension.calculateModulus10Weight3(this);

    return checkDigit == this[length - 1];
  }

  /// 文字列をISBN10に変換する
  String? toISBN10() {
    return IntExtension.calculateModulus11Weight10_2(this);
  }

  /// AmazonのURLのdp/以下に設置するパラメータの取得
  String? getDpParameter() {
    if (isValidISBN13()) {
      final dpParameter = toISBN10();

      return dpParameter;
    } else {
      throw Exception('Invalid ISBN13');
    }
  }
}
