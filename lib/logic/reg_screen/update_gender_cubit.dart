import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:unyapp/data/i_uny_api.dart';
import 'package:unyapp/logic/x_status.dart';
import 'package:unyapp/main.dart';
import 'package:unyapp/models/gender.dart';

//------
// State

class UpdateGenderState extends Equatable {
  final XStatus status;
  final String? errorMessage;

  const UpdateGenderState({
    this.status = XStatus.initial,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [status, errorMessage];
}

//------
// Cubit

class UpdateGenderCubit extends Cubit<UpdateGenderState> {
  final IUnyApi _unyApi;

  UpdateGenderCubit({required IUnyApi unyApi})
      : _unyApi = unyApi,
        super(const UpdateGenderState());

  Future<void> updateUser({Gender? gender}) async {
    emit(const UpdateGenderState(status: XStatus.inProgress));
    try {
      await _unyApi.updateUser(gender: gender);
      //-----------------------------
      // Обновляем поля ПОЛЬЗОВАТЕЛЯ
      if (gender != null) {
        unyUser!.gender = gender;
      }
      //-----------------------------
      emit(const UpdateGenderState(status: XStatus.success));
    } catch (e) {
      emit(UpdateGenderState(status: XStatus.failure, errorMessage: e.toString()));
    }
  }

  void toInitial() {
    emit(const UpdateGenderState(status: XStatus.initial));
  }
}
