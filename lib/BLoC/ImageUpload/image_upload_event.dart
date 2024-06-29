part of 'image_upload_bloc.dart';

@immutable
sealed class ImageUploadEvent {}


final class EditProfileImageUploadEvent extends ImageUploadEvent {
  final String imagePath;
  final bool coverPhoto;
  EditProfileImageUploadEvent({required this.imagePath, required this.coverPhoto});
}
