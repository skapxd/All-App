import 'package:meta/meta.dart';

import '../url_base.dart';

class Users extends UrlBase {
  Future addUserFCMToken({
    @required String token,
  }) async {
    url.post('/');
  }
}
