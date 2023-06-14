import 'package:flutter_study/core/extension/string_extension.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('978-4774185071', () {
    expect('9784774185071'.getDpParameter(), '4774185078');
  });

  test('978-4798068527', () {
    expect('9784798068527'.getDpParameter(), '4798068527');
  });

  test('978-4798048970', () {
    expect('9784798048970'.getDpParameter(), '4798048976');
  });
}
