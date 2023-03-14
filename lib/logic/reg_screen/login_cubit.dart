import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:unyapp/data/i_uny_api.dart';
import 'package:unyapp/logic/reg_screen/user_utils.dart';
import 'package:unyapp/logic/x_status.dart';

//------
// State

class LoginState extends Equatable {
  final XStatus status;
  final String? errorMessage;
  final int? errorCode;

  const LoginState({
    this.status = XStatus.initial,
    this.errorMessage,
    this.errorCode,
  });

  @override
  List<Object?> get props => [status, errorMessage, errorCode];
}

//------
// Cubit

class LoginCubit extends Cubit<LoginState> {
  final IUnyApi _unyApi;

  LoginCubit({required IUnyApi unyApi})
      : _unyApi = unyApi,
        super(const LoginState());

  Future<void> login({
    required String countryCode,
    required String phone,
    required String smsCode,
  }) async {
    emit(const LoginState(status: XStatus.inProgress));
    try {
      final userJson = await _unyApi.login(countryCode, phone, smsCode);
      //*****************************
      // Создаём ПОЛЬЗОВАТЕЛЯ !!!
      createGlobalUnyUserFromJson(userJson);
      //*****************************
      emit(const LoginState(status: XStatus.success));
    } catch (e) {
      if (e is int) {
        emit(LoginState(status: XStatus.failure, errorCode: e));
      } else {
        emit(LoginState(status: XStatus.failure, errorMessage: e.toString()));
      }
    }
  }

  void toInitial() {
    emit(const LoginState(status: XStatus.initial));
  }
}
