import 'package:e_racing_app/core/model/media_model.dart';
import 'package:e_racing_app/media/media_repository.dart';

class GetMediaUseCase {

  final MediaRepository _repository = MediaRepositoryImpl();

  Future<MediaModel> invoke(String id) async {
    return MediaModel.fromJson((await _repository.get(id)).data);
  }
}