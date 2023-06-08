import 'package:flutter_study/core/extension/string_extension.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('有効な10桁のISBN-10: "0321751043"', () {
    expect('0321751043'.isValidISBN(), true);
  });

  test('ハイフンを含む有効な10桁のISBN-10: "0-321-75104-3"', () {
    expect('0-321-75104-3'.isValidISBN(), true);
  });

  test('無効な10桁のISBN-10（チェックディジットが正しくない）: "0321751041"', () {
    expect('0321751041'.isValidISBN(), false);
  });

  test('無効な10桁のISBN-10（桁数が足りない）: "321751043"', () {
    expect('321751043'.isValidISBN(), false);
  });

  test('無効な10桁のISBN-10（数字以外の文字を含む）: "0-321-7X104-3"', () {
    expect('0-321-7X104-3'.isValidISBN(), false);
  });

  test('有効なISBN-13: "9780545010221"', () {
    expect('9780545010221'.isValidISBN(), true);
  });

  test('ハイフンを含む有効なISBN-13: "978-0-545-01022-1"', () {
    expect('978-0-545-01022-1'.isValidISBN(), true);
  });

  test('無効なISBN-13（チェックディジットが正しくない）: "9780545010220"', () {
    expect('9780545010220'.isValidISBN(), false);
  });

  test('無効なISBN-13（桁数が足りない）: "978054501022"', () {
    expect('978054501022'.isValidISBN(), false);
  });

  test('無効なISBN-13（数字以外の文字を含む）: "978054501022X"', () {
    expect('978054501022X'.isValidISBN(), false);
  });
}
