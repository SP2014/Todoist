import 'dart:io';

import 'http_service.dart';

class HttpServiceImpl implements HttpService{
  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  Future<File> downloadFile(String fileUrl) {
    // TODO: implement downloadFile
    throw UnimplementedError();
  }

  @override
  Future getHttp(String route) {
    // TODO: implement getHttp
    throw UnimplementedError();
  }

  @override
  Future postHttp(String route, body) {
    // TODO: implement postHttp
    throw UnimplementedError();
  }

  @override
  Future postHttpForm(String route, Map<String, dynamic> body, List<File> files) {
    // TODO: implement postHttpForm
    throw UnimplementedError();
  }

}