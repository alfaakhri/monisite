part of 'face_detection_bloc.dart';

@immutable
abstract class FaceDetectionState {}

class FaceDetectionInitial extends FaceDetectionState {}

class GetFaceDetectionLoading extends FaceDetectionState {}

class GetFaceDetectionSuccess extends FaceDetectionState {
  final FaceDetectionModel faceDetectionModel;

  GetFaceDetectionSuccess(this.faceDetectionModel);
}

class GetFaceDetectionEmpty extends FaceDetectionState {}

class GetFaceDetectionFailed extends FaceDetectionState {
  final String message;

  GetFaceDetectionFailed(this.message);
}

class SiteMustLogin extends FaceDetectionState {}
