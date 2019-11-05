class HttpResultModel<T> {
  T data;
  int code;
  String message;

  HttpResultModel(int code, String message, T data);
}
