import '../../../../domain/inputs/sign_up.dart';
import '../../../../domain/repositories/sign_up_repository.dart';
import '../../../../domain/responses/sign_up_response.dart';
import '../../../global_controllers/seccion_controller.dart';
import '../../../pages/register/controller/register_state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_meedu/flutter_meedu.dart';

class RegisterController extends StateNotifier<RegisterState> {
  final SessionController _sessionController;
  RegisterController(this._sessionController)
      : super(RegisterState.initialState);
  final GlobalKey<FormState> formKey = GlobalKey();
  final _signUpRepository = Get.i.find<SignUpRepository>();

  Future<SignUpResponse> submit() async {
    final response = await _signUpRepository.register(
      SignUpData(
        name: state.name,
        lastname: state.lastname,
        email: state.email,
        password: state.password,
        ci: state.ci,
      ),
    );
    if (response.error == null) {
      _sessionController.setUser(response.user!);
    }
    return response;
  }

  void onNameChanged(String text) {
    state = state.copyWith(name: text);
  }

  void onLastNameChanged(String text) {
    state = state.copyWith(lastname: text);
  }

  void onCiChanged(String text){
    state = state.copyWith(ci: text);
  }

  void onEmailChanged(String text) {
    state = state.copyWith(email: text);
  }

  void onPaswordChanged(String text) {
    state = state.copyWith(password: text);
  }

  void onVPaswordChanged(String text) {
    state = state.copyWith(vPassword: text);
  }
}
