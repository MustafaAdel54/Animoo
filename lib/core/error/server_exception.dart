class ServerException implements Exception {
  final String message;
  final Map data;

  const ServerException({required this.message, required this.data});
}
