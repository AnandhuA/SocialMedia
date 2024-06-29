part of 'image_upload_bloc.dart';

@immutable
sealed class ImageUploadState {}

final class ImageUploadInitial extends ImageUploadState {}


final class ImageUploadLoadingState extends ImageUploadState {}

final class ImageUploadSuccessState extends ImageUploadState {
  final String imgeUrl;
  final bool coverPhoto;

  ImageUploadSuccessState({
    required this.imgeUrl,
    required this.coverPhoto,
  });
}

final class ImageUploadErrorState extends ImageUploadState {
  final String error;

  ImageUploadErrorState({required this.error});
}
