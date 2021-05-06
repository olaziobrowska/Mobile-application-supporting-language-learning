class ErrorViewModel {
  String message;

  ErrorViewModel._({this.message});

  static ErrorViewModel newFromMessage(String message) {
    return ErrorViewModel._(message: message);
  }
}
