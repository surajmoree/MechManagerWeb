

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

  Future<void> logOut(String token)async
  {
    try
    {
      await requestGET(path: '/logout',parameters:{'token':token} );
    }catch (e) {
      print('Error in logout: $e');
      throw e;
    }
  }
}
