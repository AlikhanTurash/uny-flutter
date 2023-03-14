import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:unyapp/data/categories.dart';
import 'package:unyapp/data/i_uny_api.dart';
import 'package:unyapp/logic/x_status.dart';
import 'package:unyapp/models/interest.dart';

//------
// State

class InterestsState extends Equatable {
  final XStatus status;
  final List<Interest> interests;
  final String? errorMessage;

  const InterestsState({
    this.status = XStatus.initial,
    this.interests = const [],
    this.errorMessage,
  });

  @override
  List<Object?> get props => [status, interests, errorMessage];
}

//------
// Cubit

class InterestsCubit extends Cubit<InterestsState> {
  final IUnyApi _unyApi;

  InterestsCubit({required IUnyApi unyApi})
      : _unyApi = unyApi,
        super(const InterestsState());

  //----
  Future<void> getInterests() async {
    //~~~
    List<Interest> interests = [];
    Future<void> request() async {
      interests = [];
      for (var category in unyCategories) {
        final categoryInterests = await _unyApi.fetchInterests(category.id);
        interests.addAll(categoryInterests);
      }
    }
    //~~~

    emit(const InterestsState(status: XStatus.inProgress));
    try {
      await request();
      emit(InterestsState(status: XStatus.success, interests: interests));
    } catch (e) {
      //---
      if (e.toString().toLowerCase().contains('formatexception')) {
        // Вторая попытка
        await Future.delayed(const Duration(milliseconds: 200));
        try {
          await request();
          emit(InterestsState(status: XStatus.success, interests: interests));
        } catch (e) {
          emit(InterestsState(status: XStatus.failure, errorMessage: e.toString()));
        }
      }
      //---
      else {
        emit(InterestsState(status: XStatus.failure, errorMessage: e.toString()));
      }
    }
  }
  //----

  void toInitial() {
    emit(const InterestsState(status: XStatus.initial));
  }
}
