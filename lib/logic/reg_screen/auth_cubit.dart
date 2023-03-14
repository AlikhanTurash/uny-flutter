import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:unyapp/data/i_uny_api.dart';
import 'package:unyapp/logic/x_status.dart';

//------
// State

class AuthState extends Equatable {
  final XStatus status;
  final String? errorMessage;

  const AuthState({
    this.status = XStatus.initial,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [status, errorMessage];
}

//------
// Cubit

class AuthCubit extends Cubit<AuthState> {
  final IUnyApi _unyApi;

  AuthCubit({required IUnyApi unyApi})
      : _unyApi = unyApi,
        super(const AuthState());

  Future<void> auth({required String countryCode, required String phone}) async {
    emit(const AuthState(status: XStatus.inProgress));
    try {
      await _unyApi.auth(countryCode, phone);
      emit(const AuthState(status: XStatus.success));
    } catch (e) {
      emit(AuthState(status: XStatus.failure, errorMessage: e.toString()));
    }
  }

  void toInitial() {
    emit(const AuthState(status: XStatus.initial));
  }
}
