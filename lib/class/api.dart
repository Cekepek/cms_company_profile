class ResponseRequestApi {
  int status = 0;
  String message = "";
  dynamic data = [];
  ResponseRequestApi({
    required this.status,
    required this.message,
    required this.data,
  });
}
