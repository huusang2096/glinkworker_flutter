// Import the test package and Counter class
import 'package:flutter_map_booking/components/validations.dart';
import 'package:test/test.dart';

void main() {
  test('Validate name', () {
    final validator = Validations();
    expect(validator.validateName('Nguyễn Văn Linh'), null);
  });
}
