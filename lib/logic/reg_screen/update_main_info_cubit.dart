import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:unyapp/data/i_uny_api.dart';
import 'package:unyapp/logic/x_status.dart';
import 'package:unyapp/main.dart';

//------
// State

class UpdateMainInfoState extends Equatable {
  final XStatus status;
  final String? errorMessage;

  const UpdateMainInfoState({
    this.status = XStatus.initial,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [status, errorMessage];
}

//------
// Cubit

class UpdateMainInfoCubit extends Cubit<UpdateMainInfoState> {
  final IUnyApi _unyApi;

  UpdateMainInfoCubit({required IUnyApi unyApi})
      : _unyApi = unyApi,
        super(const UpdateMainInfoState());

  Future<void> updateUser({
    String? firstName,
    String? lastName,
    DateTime? dateOfBirth,
    String? location,
    bool? showZodiacSign,
  }) async {
    emit(const UpdateMainInfoState(status: XStatus.inProgress));
    try {
      await _unyApi.updateUser(
        firstName: firstName,
        lastName: lastName,
        dateOfBirth: dateOfBirth,
        showZodiacSign: showZodiacSign,
        location: location,
        gender: unyUser!.gender, // Поле gender - обязательное
      );
      //-----------------------------
      // Обновляем поля ПОЛЬЗОВАТЕЛЯ
      if (firstName != null) {
        unyUser!.firstName = firstName;
      }
      if (lastName != null) {
        unyUser!.lastName = lastName;
      }
      if (dateOfBirth != null) {
        unyUser!.dateOfBirth = dateOfBirth;
      }
      if (location != null) {
        unyUser!.location = location;
      }
      // if (showZodiacSign != null) {
      //   unyUser!.showZodiacSign = showZodiacSign;
      // }
      //-----------------------------
      emit(const UpdateMainInfoState(status: XStatus.success));
    } catch (e) {
      emit(UpdateMainInfoState(status: XStatus.failure, errorMessage: e.toString()));
    }
  }

  void toInitial() {
    emit(const UpdateMainInfoState(status: XStatus.initial));
  }
}
