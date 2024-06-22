import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'featch_following_event.dart';
part 'featch_following_state.dart';

class FeatchFollowingBloc
    extends Bloc<FeatchFollowingEvent, FeatchFollowingState> {
  FeatchFollowingBloc() : super(FeatchFollowingInitial()) {
    on<FeatchFollwingListEvent>((event, emit) {
      emit(FeatchFollowingLoadingState());
    });
  }
}
