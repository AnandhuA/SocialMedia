part of 'like_bloc.dart';

@immutable
sealed class LikeState {}

final class LikeInitial extends LikeState {}

final class LikeLoadingState extends LikeState{}

final class LikeSuccessState extends LikeState{}

final class LikeErrorState extends LikeState{}
