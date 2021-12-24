import 'package:e_racing_app/core/model/social_platform_model.dart';
import 'package:e_racing_app/social/social_media_repository.dart';

class GetSocialMediaUseCase {

  final SocialMediaRepository _repository = SocialMediaRepositoryImpl();

  Future<List<SocialPlatformModel>> invoke() async {
    return ((await _repository.get()).data as List)
        .map<SocialPlatformModel>((tags) => SocialPlatformModel.fromJson(tags))
        .toList();
  }
}
