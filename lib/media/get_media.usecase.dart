import 'package:e_racing_app/media/media_repository.dart';

class GetMediaUseCase {

  final MediaRepository _repository = MediaRepositoryImpl();

  invoke(String id) async {
    return await _repository.get(id);
  }
}