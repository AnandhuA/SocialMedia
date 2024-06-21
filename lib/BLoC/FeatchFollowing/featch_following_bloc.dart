import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'featch_following_event.dart';
part 'featch_following_state.dart';

class FeatchFollowingBloc extends Bloc<FeatchFollowingEvent, FeatchFollowingState> {
  FeatchFollowingBloc() : super(FeatchFollowingInitial()) {
    on<FeatchFollowingEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
