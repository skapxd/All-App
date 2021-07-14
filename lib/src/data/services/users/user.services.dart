import 'package:meta/meta.dart';

import '../url_base.dart';

class UsersService extends UrlBase {
  Future addUserFCMToken({
    @required String token,
  }) async {
    urlBase.post('/');
  }
}
