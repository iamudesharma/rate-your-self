 

 class AppError extends Error {
  final String message;
  final String? code;
  final String? details;

  AppError({
    required this.message,
    this.code,
    this.details,
  });

  @override
  String toString() {
    return 'AppError{message: $message, code: $code, details: $details}';
  }


 }


 