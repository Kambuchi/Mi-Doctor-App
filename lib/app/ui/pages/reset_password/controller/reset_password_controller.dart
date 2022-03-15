import 'package:flutter_meedu/flutter_meedu.dart';
import '../../../../domain/repositories/authentication_repository.dart';
import '../../../../domain/responses/reset_password_response.dart';

class ResetPasswordController extends SimpleNotifier {
  String _email = '';
  String get email => _email;

  final _authenticationRepository = Get.find<AuthenticationRepository>();

  void onEmailChanged(String text) {
    _email = text;
  }

  Future<ResetPasswordResponse> submit() {
    return _authenticationRepository.sendResetPasswordLink(email);
  }
}
