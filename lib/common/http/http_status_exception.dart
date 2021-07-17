class HttpStatusException {
  final int statusCode;
  final String body;

  const HttpStatusException(this.statusCode, this.body);
}
