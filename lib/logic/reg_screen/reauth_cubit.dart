import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:unyapp/data/i_uny_api.dart';
import 'package:unyapp/logic/x_status.dart';

//------
// State

class ReAuthState extends Equatable {
  final XStatus status;
  final String? errorMessage;

  const ReAuthState({
    this.status = XStatus.initial,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [status, errorMessage];
}

//------
// Cubit

class ReAuthCubit extends Cubit<ReAuthState> {
  final IUnyApi _unyApi;

  ReAuthCubit({required IUnyApi unyApi})
      : _unyApi = unyApi,
        super(const ReAuthState());

  Future<void> auth({required String countryCode, required String phone}) async {
    emit(const ReAuthState(status: XStatus.inProgress));
    await Future.delayed(const Duration(milliseconds: 1000));
    try {
      await _unyApi.auth(countryCode, phone);
      emit(const ReAuthState(status: XStatus.success));
    } catch (e) {
      emit(ReAuthState(status: XStatus.failure, errorMessage: e.toString()));
    }
  }

  void toInitial() {
    emit(const ReAuthState(status: XStatus.initial));
  }
}
