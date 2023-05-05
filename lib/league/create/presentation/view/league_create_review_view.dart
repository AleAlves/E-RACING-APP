import 'package:e_racing_app/core/model/media_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../core/ui/component/state/view_state_widget.dart';
import '../../../../../core/ui/component/ui/banner_widget.dart';
import '../../../../../core/ui/component/ui/button_widget.dart';
import '../../../../../core/ui/component/ui/social_collection_widget.dart';
import '../../../../../core/ui/component/ui/spacing_widget.dart';
import '../../../../../core/ui/component/ui/tag_collection_widget.dart';
import '../../../../../core/ui/component/ui/text_widget.dart';
import '../../../../../core/ui/view_state.dart';
import '../league_create_view_model.dart';
import '../navigation/league_create_flow.dart';

class LeagueCreateReviewView extends StatefulWidget {
  final LeagueCreateViewModel viewModel;

  const LeagueCreateReviewView(this.viewModel, {Key? key}) : super(key: key);

  @override
  _LeagueCreateReviewViewState createState() => _LeagueCreateReviewViewState();
}

class _LeagueCreateReviewViewState extends State<LeagueCreateReviewView>
    implements BaseSateWidget {
  @override
  void initState() {
    observers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return mainObserver();
  }

  @override
  Observer mainObserver() {
    return Observer(builder: (_) => viewState());
  }

  @override
  ViewStateWidget viewState() {
    return ViewStateWidget(
      body: content(),
      bottom: buttonWidget(),
      onBackPressed: onBackPressed,
      state: widget.viewModel.state,
    );
  }

  @override
  Widget content() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          const SpacingWidget(LayoutSize.size16),
          leagueReviewTitle(),
          const SpacingWidget(LayoutSize.size32),
          leagueBannerWidget(),
          const SpacingWidget(LayoutSize.size32),
          leagueNameWidget(),
          const SpacingWidget(LayoutSize.size32),
          leagueDescriptionsWidget(),
          const SpacingWidget(LayoutSize.size32),
          tagsWidget(),
          const SpacingWidget(LayoutSize.size32),
          socialWidget(),
          const SpacingWidget(LayoutSize.size16),
        ],
      ),
    );
  }

  Widget leagueReviewTitle() {
    return const TextWidget(text: "Preview", style: Style.title);
  }

  Widget leagueBannerWidget() {
    return BannerWidget(
      media: MediaModel(widget.viewModel.banner ?? ''),
    );
  }

  Widget leagueNameWidget() {
    return Row(
      children: [
        TextWidget(text: widget.viewModel.name, style: Style.subtitle)
      ],
    );
  }

  Widget leagueDescriptionsWidget() {
    return Row(
      children: [
        TextWidget(text: widget.viewModel.description, style: Style.subtitle)
      ],
    );
  }

  Widget tagsWidget() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        children: [
          TagCollectionWidget(
            tagIds: widget.viewModel.leagueTags,
            tags: widget.viewModel.tags,
            singleLined: false,
          ),
        ],
      ),
    );
  }

  Widget socialWidget() {
    return widget.viewModel.linkModels?.isEmpty == true
        ? Container()
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SpacingWidget(LayoutSize.size16),
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child:
                      TextWidget(text: "Social media", style: Style.paragraph),
                ),
                const SpacingWidget(LayoutSize.size4),
                SocialCollectionWidget(
                  hide: widget.viewModel.linkModels == null,
                  links: widget.viewModel.linkModels,
                  socialPlatforms: widget.viewModel.socialMedias,
                ),
              ],
            ),
          );
  }

  Widget statusMessage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextWidget(
              text: widget.viewModel.status?.message ?? '', style: Style.title),
          const SpacingWidget(LayoutSize.size48),
          Icon(
            widget.viewModel.status?.error == true
                ? Icons.cancel
                : Icons.check_circle,
            size: 64,
            color: widget.viewModel.status?.error == true
                ? Colors.red
                : Colors.green,
          ),
        ],
      ),
    );
  }

  Widget buttonWidget() {
    return ButtonWidget(
      enabled: true,
      type: ButtonType.primary,
      onPressed: () {
        widget.viewModel.create();
      },
      label: widget.viewModel.status?.action ?? 'Create League',
    );
  }

  @override
  observers() {}

  @override
  Future<bool> onBackPressed() async {
    widget.viewModel.onRoute(LeagueCreateNavigator.socialMedia);
    return false;
  }
}
