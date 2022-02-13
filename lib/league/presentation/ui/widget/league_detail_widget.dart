import 'package:e_racing_app/core/tools/session.dart';
import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/banner_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/expanded_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/float_action_button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/membership_action_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/shortcut_collection_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/social_collection_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/tag_collection_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/league/presentation/league_view_model.dart';
import 'package:e_racing_app/league/presentation/ui/league_flow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class LeagueDetailWidget extends StatefulWidget {
  final LeagueViewModel viewModel;

  const LeagueDetailWidget(this.viewModel, {Key? key}) : super(key: key);

  @override
  _LeagueDetailWidgetState createState() => _LeagueDetailWidgetState();
}

class _LeagueDetailWidgetState extends State<LeagueDetailWidget>
    implements BaseSateWidget {
  @override
  void initState() {
    widget.viewModel.getLeague();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => mainObserver();

  @override
  Observer mainObserver() => Observer(builder: (_) => viewState());

  @override
  observers() {}

  @override
  ViewStateWidget viewState() {
    return ViewStateWidget(
        content: content(),
        state: widget.viewModel.state,
        onBackPressed: onBackPressed,
        scrollable: true);
  }

  @override
  Widget content() {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 4),
              child: banner(),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: description(),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: membership(),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: social(),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: panel(),
            ),
          ],
        ),
        FloatActionButtonWidget<LeagueFlow>(
          flow: LeagueFlow.edit,
          icon: Icons.build,
          onPressed: (flow) {
            widget.viewModel.setFlow(flow);
          },
        ),
      ],
    );
  }

  Widget banner() {
    return BannerWidget(
      media: widget.viewModel.media,
    );
  }

  Widget description() {
    return ExpandedWidget(
      ready: widget.viewModel.league != null,
      header: Row(
        children: [
          const Icon(Icons.emoji_events),
          const SpacingWidget(LayoutSize.size16),
          Expanded(
            child: TextWidget(
              text: widget.viewModel.league?.name ?? '',
              style: Style.title,
              align: TextAlign.left,
            ),
          ),
        ],
      ),
      body: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextWidget(
            text: widget.viewModel.league?.description ?? '',
            style: Style.description,
            align: TextAlign.center,
          ),
        ),
        const SpacingWidget(LayoutSize.size48),
        tags(),
        const SpacingWidget(LayoutSize.size16),
      ],
    );
  }

  Widget tags() {
    return TagCollectionWidget(
      tagIds: widget.viewModel.league?.tags,
      tags: widget.viewModel.tags,
    );
  }

  Widget social() {
    return SocialCollectionWidget(
      hide: widget.viewModel.league?.links == null,
      links: widget.viewModel.league?.links,
      socialPlatforms: widget.viewModel.socialMedias,
    );
  }

  Widget panel() {
    return ShortcutCollectionWidget(
      shortcuts: widget.viewModel.menus?.toList(),
      onPressed: widget.viewModel.deeplink,
    );
  }

  Widget membership() {
    return MembershipActionWidget(
      leagueModel: widget.viewModel.league,
      onStartMembership: () {
        widget.viewModel.startMembership();
      },
      onStopMembership: () {
        widget.viewModel.stopMembership();
      },
      isMember: widget.viewModel.league?.members
          ?.where((element) => element == Session.instance.getUser()?.id)
          .isNotEmpty ??
          false,
    );
  }

  @override
  Future<bool> onBackPressed() async {
    widget.viewModel.setFlow(LeagueFlow.list);
    return false;
  }
}
