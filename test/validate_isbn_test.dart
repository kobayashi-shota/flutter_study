import 'package:flutter_study/core/extension/string_extension.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('有効なISBN-13: "9780545010221"', () {
    expect('9780545010221'.isValidISBN13(), true);
  });

  test('ハイフンを含む有効なISBN-13: "978-0-545-01022-1"', () {
    expect('978-0-545-01022-1'.isValidISBN13(), true);
  });

  test('無効なISBN-13（チェックディジットが正しくない）: "9780545010220"', () {
    expect('9780545010220'.isValidISBN13(), false);
  });

  test('無効なISBN-13（桁数が足りない）: "978054501022"', () {
    expect('978054501022'.isValidISBN13(), false);
  });

  test('無効なISBN-13（数字以外の文字を含む）: "978054501022X"', () {
    expect('978054501022X'.isValidISBN13(), false);
  });
}
