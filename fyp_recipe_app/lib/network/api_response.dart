class ApiResponse<T> {
  Status status;
  T? data;
  String? error;

  ApiResponse.loading() : status = Status.loading;

  ApiResponse.error(String message)
      : status = Status.error,
        error = message;

  ApiResponse.success(T value)
      : status = Status.success,
        data = value;
}

enum Status {
  loading,
  error,
  success,
}
