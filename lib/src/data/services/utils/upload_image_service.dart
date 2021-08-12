part of './utils_service.dart';

class UploadImageService extends UrlBase {
  Future<String> uploadLogo({
    @required String path,
  }) async {
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        path,
        filename: 'logo.${path.split('.').last}',
      )
    });

    Response res =
        await this.urlBase.post('/api-v1/gcp/upload-image', data: formData);

    return res.data['urlImage'];
  }
}
