import 'package:food_dash/data/data_provider/fireauth_provider.dart';
import 'package:food_dash/data/model/response/google_signIn_response.dart';

class GoogleSignInController {
  final fireAuthProvider = FireAuthProvider();

  Future<GoogleSignInResponse> googleSignIn() async {
    final user = await fireAuthProvider.googleSignIn();
    return GoogleSignInResponse(user);
  }
}
