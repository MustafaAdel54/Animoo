abstract class ApiConsumer {
  Future get({
    required String path,
    Map<String, dynamic>? body,
    Map<String, dynamic>? header,
    Map<String, dynamic>? queryParameter,
  });

  Future put({
    required String path,
    Map<String, dynamic>? body,
    Map<String, dynamic>? header,
    Map<String, dynamic>? queryParameter,
  });

  Future post({
    required String path,
    dynamic body,
    Map<String, dynamic>? header,
    Map<String, dynamic>? queryParameter,
  });

  Future delete({required String path});

  Future patch({required String path});
}
