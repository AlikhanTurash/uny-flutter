import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:unyapp/data/i_uny_api.dart';
import 'package:unyapp/logic/x_status.dart';

//------
// State

class DeleteInterestState extends Equatable {
  final XStatus status;
  final int? interestId;
  final int? errorCode;
  final String? errorMessage;

  const DeleteInterestState({
    this.status = XStatus.initial,
    this.interestId,
    this.errorCode,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [status, interestId, errorCode, errorMessage];
}

//------
// Cubit

class DeleteInterestCubit extends Cubit<DeleteInterestState> {
  final IUnyApi _unyApi;

  DeleteInterestCubit({required IUnyApi unyApi})
      : _unyApi = unyApi,
        super(const DeleteInterestState());

  //----
  Future<void> deleteInterestFromUser(int interestId) async {
    //~~~
    void emitError(Object e) {
      if (e is int) {
        emit(DeleteInterestState(
            status: XStatus.failure,
            interestId: interestId,
            errorCode: e,
            errorMessage: 'Error code: $e'));
      } else {
        emit(
          DeleteInterestState(
            status: XStatus.failure,
            interestId: interestId,
            errorMessage: e.toString(),
          ),
        );
      }
    }
    //~~~

    emit(const DeleteInterestState(status: XStatus.inProgress));
    try {
      await _unyApi.deleteInterestFromUser(interestId);
      emit(DeleteInterestState(status: XStatus.success, interestId: interestId));
    } catch (e) {
      //---
      if (e.toString().toLowerCase().contains('formatexception')) {
        // Вторая попытка
        await Future.delayed(const Duration(milliseconds: 200));
        try {
          await _unyApi.deleteInterestFromUser(interestId);
          emit(DeleteInterestState(status: XStatus.success, interestId: interestId));
        } catch (e) {
          emitError(e);
        }
      }
      //---
      else {
        emitError(e);
      }
    }
  }
  //----

  void toInitial() {
    emit(const DeleteInterestState(status: XStatus.initial));
  }
}
