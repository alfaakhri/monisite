part of 'face_detection_bloc.dart';

@immutable
abstract class FaceDetectionEvent {}

class GetListFaceDetection extends FaceDetectionEvent {
  final int siteId;
  final int limit;

  GetListFaceDetection(this.siteId, this.limit);
}
