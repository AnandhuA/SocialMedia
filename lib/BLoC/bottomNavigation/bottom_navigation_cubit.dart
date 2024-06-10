import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'bottom_navigation_state.dart';

class BottomNavigationCubit extends Cubit<BottomNavigationState> {
  BottomNavigationCubit() : super(BottomNavigationInitial(index: 0));

  void bottomNvigationButtonClick({required int index}) {
    emit(BottomNavigationInitial(index: index));
  }
}
