import 'package:flutter/cupertino.dart';
import 'package:flutter_study/core/constants/string_constants.dart';
import 'package:flutter_study/core/extension/string_extension.dart';

extension IntExtension on int {
  /// EAN13のISBN13などのチェックデジットを算出する
  static String calculateModulus10Weight3(
    String input,
  ) {
    const modulus = 10;
    var checkSum = 0;

    debugPrint('input: $input');
    debugPrint('input.length: ${input.length}');

    final digits = input
        .toLowerCase()
        .replaceAll(RegExp('[^0-9]'), '')
        .dropLast(1)
        .split('')
        .map(int.parse)
        .toList();

    for (final (index, digit) in digits.indexed) {
      if (index.isEven) {
        checkSum += digit;
      } else {
        checkSum += digit * 3;
      }
    }

    debugPrint('checkSum calculation completed: $checkSum');

    final remainder = checkSum % modulus;
    debugPrint('remainder: $remainder');

    final checkDigit = modulus - remainder;
    debugPrint('checkDigit: $checkDigit');

    return switch (checkDigit) {
      10 => '0',
      _ => checkDigit.toString(),
    };
  }

  static String calculateModulus11Weight10_2(
    String input, {
    bool onlyCheckDigit = true,
  }) {
    const weight = 10;
    final weights = List<int>.generate(
      // 重みづけは末尾以外だけ
      weight - 1,
      (index) => weight - index,
      growable: false,
    );
    const modulus = 11;
    var checkSum = 0;
    var digits = <int>[];

    debugPrint('input: $input');
    debugPrint('weights: $weights');

    if (input.length == 13 && input.startsWith(StringConstants.isbnPrefix)) {
      digits = input
          .dropFirst(StringConstants.isbnPrefix.length)
          .dropLast(1)
          .split('')
          .map(int.parse)
          .toList();
    } else {
      digits = input.dropLast(1).split('').map(int.parse).toList();
    }

    debugPrint('input: $input');
    debugPrint('digits: $digits');

    for (final (index, digit) in digits.indexed) {
      final weighted = digit * weights[index];
      checkSum += weighted;
      debugPrint('$digit * ${weights[index]} = $weighted ($checkSum)');
    }

    debugPrint('checkSum calculation completed: $checkSum');

    final remainder = checkSum % modulus;

    debugPrint('remainder: $remainder = $checkSum % $modulus');

    final checkDigit = remainder == 0 ? '0' : (modulus - remainder).toString();

    debugPrint('checkDigit: $checkDigit');

    return digits.join() + checkDigit;
  }
}
