class HttpStatusException {
  final int statusCode;
  final String reasonPhrase;

  const HttpStatusException(this.statusCode, this.reasonPhrase);
}