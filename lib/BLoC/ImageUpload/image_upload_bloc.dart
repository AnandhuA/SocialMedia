import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:social_media/repository/authentication/post_repo.dart';

part 'image_upload_event.dart';
part 'image_upload_state.dart';

class ImageUploadBloc extends Bloc<ImageUploadEvent, ImageUploadState> {
  ImageUploadBloc() : super(ImageUploadInitial()) {
    on<EditProfileImageUploadEvent>(_imageUploadEvent);
  }

  FutureOr<void> _imageUploadEvent(
    EditProfileImageUploadEvent event,
    Emitter<ImageUploadState> emit,
  ) async {
    emit(ImageUploadLoadingState());
    final imgurl = await PostRepo.uploadImage(event.imagePath);
    emit(
      ImageUploadSuccessState(
        imgeUrl: imgurl,
        coverPhoto: event.coverPhoto,
      ),
    );
  }
}
