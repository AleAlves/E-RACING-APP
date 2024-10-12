import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';

import '../../../core/model/media_model.dart';

part 'community_card_vo.g.dart';

@JsonSerializable(explicitToJson: true)
class CommunityCardVO {
  @observable
  String? leagueId;

  @observable
  String? name;

  @observable
  MediaModel? media;

  CommunityCardVO(
      {required this.leagueId, required this.name, required this.media});

  factory CommunityCardVO.fromJson(Map<String, dynamic> json) =>
      _$CommunityCardVOFromJson(json);

  Map<String, dynamic> toJson() => _$CommunityCardVOToJson(this);
}
