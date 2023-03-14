import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:unyapp/data/i_uny_api.dart';
import 'package:unyapp/logic/x_status.dart';

//------
// State

class DeletePhotoState extends Equatable {
  final XStatus status;
  final int? photoId;
  final int? errorCode;
  final String? errorMessage;

  const DeletePhotoState({
    this.status = XStatus.initial,
    this.photoId,
    this.errorCode,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [status, photoId, errorCode, errorMessage];
}

//------
// Cubit

class DeletePhotoCubit extends Cubit<DeletePhotoState> {
  final IUnyApi _unyApi;

  DeletePhotoCubit({required IUnyApi unyApi})
      : _unyApi = unyApi,
        super(const DeletePhotoState());

  //----
  Future<void> deletePhotoFromUser(int photoId) async {
    //~~~
    void emitError(Object e) {
      if (e is int) {
        emit(DeletePhotoState(
            status: XStatus.failure,
            photoId: photoId,
            errorCode: e,
            errorMessage: 'Error code: $e'));
      } else {
        emit(
          DeletePhotoState(
            status: XStatus.failure,
            photoId: photoId,
            errorMessage: e.toString(),
          ),
        );
      }
    }
    //~~~

    emit(const DeletePhotoState(status: XStatus.inProgress));
    try {
      await _unyApi.deletePhotoFromUser(photoId);
      emit(DeletePhotoState(status: XStatus.success, photoId: photoId));
    } catch (e) {
      //---
      if (e.toString().toLowerCase().contains('formatexception')) {
        // Вторая попытка
        await Future.delayed(const Duration(milliseconds: 200));
        try {
          await _unyApi.deletePhotoFromUser(photoId);
          emit(DeletePhotoState(status: XStatus.success, photoId: photoId));
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
    emit(const DeletePhotoState(status: XStatus.initial));
  }
}
