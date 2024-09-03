

import 'api.dart';

class UserApi extends Api {
  Future<dynamic> userLogin(jsonData) async {
    try {
      final userData = await requestPOST(path: '/login', parameters: jsonData)
          .timeout(const Duration(seconds: 60));
      return userData;
    } catch (e, _) {
      print(e);
      print(_);
    }
  }
}
