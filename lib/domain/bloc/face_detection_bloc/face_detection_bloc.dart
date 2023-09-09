import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/models/face_detection/face_detection_model.dart';
import '../../../data/repository/api_service.dart';
import '../../../external/service/shared_preference_service.dart';

part 'face_detection_event.dart';
part 'face_detection_state.dart';

class FaceDetectionBloc extends Bloc<FaceDetectionEvent, FaceDetectionState> {
  ApiService _apiService = ApiService();
  SharedPreferenceService _sharedPreferenceService = SharedPreferenceService();

  FaceDetectionModel _faceDetectionModel = FaceDetectionModel();
  FaceDetectionModel get faceDetectionModel => _faceDetectionModel;
  void setFaceDetection(List<DataFaceDetection> data) {
    _faceDetectionModel.data?.addAll(data);
  }

  String _token = "";
  String get token => _token;
  void setToken(String token) {
    _token = token;
  }

  FaceDetectionBloc() : super(FaceDetectionInitial()) {
    on<FaceDetectionEvent>((event, emit) async {
      if (event is GetListFaceDetection) {
        emit(GetFaceDetectionLoading());
        try {
          var tokenNew = await _sharedPreferenceService.getToken();
          if (tokenNew == null) {
            emit(SiteMustLogin());
          } else {
            _token = tokenNew;

            var response =
                await _apiService.getFaceDetection(event.siteId, _token, 30);
            if (response?.statusCode == 200) {
              FaceDetectionModel tempList =
                  FaceDetectionModel.fromJson(response?.data);
              if (tempList.data?.length == 0) {
                emit(GetFaceDetectionEmpty());
              } else {
                _faceDetectionModel = tempList;
                emit(GetFaceDetectionSuccess(_faceDetectionModel));
              }
            } else {
              emit(GetFaceDetectionFailed("Failed get data report"));
            }
          }
        } catch (e) {
          emit(GetFaceDetectionFailed(e.toString()));
        }
      }
    });
  }
}
