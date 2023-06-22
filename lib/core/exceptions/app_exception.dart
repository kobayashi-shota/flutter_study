sealed class AppException implements Exception {
  AppException(this.code, this.message);

  final String code;
  final String message;

  String details() => message;
}

final class AlreadyExistsException extends AppException {
  AlreadyExistsException()
      : super(
          'already-exists',
          'このアイテムは既に存在しています',
        );
}
