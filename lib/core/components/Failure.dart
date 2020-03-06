
class Failure {
  // Use something like "int code;" if you want to translate error messages
  String _message;

  Failure(this._message);

  @override
  String toString() => _message;

  String get message => _message;
}