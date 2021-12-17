
import 'package:e_racing_app/core/model/tag_model.dart';
import 'package:e_racing_app/tag/tag_repository.dart';

class GetTagUseCase {

  final TagRepository _repository = TagRepositoryImpl();

  Future<List<TagModel>> invoke() async {
    return ((await _repository.get()).data as List)
        .map<TagModel>((tags) => TagModel.fromJson(tags))
        .toList();
  }
}
