part of './utils_service.dart';

class UploadImageService extends UrlBase {
  final now = DateTime.now();

  final pref = Pref();

  Future<void> uploadLogo({
    @required String file,
    @required Function(String urlLogo) onSuccess,
    @required Function(dynamic error) onFailed,
  }) async {
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        file,
        filename: 'logo.${file.split('.').last}',
      )
    });

    Response res;
    try {
      res = await this.urlBase.post('/api-v1/gcp/upload-image', data: formData);

      if (onSuccess != null && res.data['success']) {
        onSuccess(res.data['urlImage']);
      }
    } catch (e) {
      if (onFailed != null && !res.data['success']) {
        onFailed(e);
      }
      print('StoresService - catch: $e');
    }
  }
}
