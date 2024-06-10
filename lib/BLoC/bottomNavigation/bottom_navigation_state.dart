part of 'bottom_navigation_cubit.dart';

@immutable
sealed class BottomNavigationState {}

final class BottomNavigationInitial extends BottomNavigationState {
  final int index;

  BottomNavigationInitial({required this.index});
}

