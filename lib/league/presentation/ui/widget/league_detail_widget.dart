import 'package:e_racing_app/core/ext/access_extension.dart';
import 'package:e_racing_app/core/ext/event_iconography_extension.dart';
import 'package:e_racing_app/core/tools/routes.dart';
import 'package:e_racing_app/core/tools/session.dart';
import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/banner_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/event_simple_card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/expanded_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/float_action_button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/membership_action_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/shortcut_collection_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/social_collection_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/tag_collection_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/event/presentation/ui/event_flow.dart';
import 'package:e_racing_app/league/presentation/league_view_model.dart';
import 'package:e_racing_app/league/presentation/ui/league_flow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

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
    widget.viewModel.getPlayerEvents();
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
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
              child: banner(),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: social(),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: panel(),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: playersEvent(),
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
    return CardWidget(
      padding: EdgeInsets.zero,
      ready: true,
      child: Column(
        children: [
          BannerWidget(
            media: widget.viewModel.media,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24, bottom: 24),
            child: description(),
          ),
        ],
      ),
    );
  }

  Widget description() {
    return ExpandedWidget(
      shapeless: true,
      iniExpanded: !isLeagueMember(widget.viewModel.league),
      ready: widget.viewModel.league != null,
      expandIcon: Icons.visibility_outlined,
      collapseIcon: Icons.visibility_off_outlined,
      header: Row(
        children: [
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
        const SpacingWidget(LayoutSize.size16),
        tags(),
        const SpacingWidget(LayoutSize.size16),
        membership(),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SpacingWidget(LayoutSize.size16),
        const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: TextWidget(text: "Social media", style: Style.description),
        ),
        const SpacingWidget(LayoutSize.size4),
        SocialCollectionWidget(
          hide: widget.viewModel.league?.links == null,
          links: widget.viewModel.league?.links,
          socialPlatforms: widget.viewModel.socialMedias,
        ),
      ],
    );
  }

  Widget panel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SpacingWidget(LayoutSize.size16),
        const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: TextWidget(text: "Quick Access", style: Style.description),
        ),
        const SpacingWidget(LayoutSize.size4),
        ShortcutCollectionWidget(
          shortcuts: widget.viewModel.menus?.toList(),
          onPressed: widget.viewModel.deeplink,
        ),
      ],
    );
  }

  Widget membership() {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 4),
      child: MembershipActionWidget(
        leagueModel: widget.viewModel.league,
        onStartMembership: () {
          widget.viewModel.startMembership();
        },
        onStopMembership: () {
          widget.viewModel.stopMembership();
        },
        isMember: isLeagueMember(widget.viewModel.league),
      ),
    );
  }

  Widget playersEvent() {
    return widget.viewModel.playerEvents?.isNotEmpty == false
        ? CardWidget(
            child: SizedBox(
              height: 100,
              width: MediaQuery.of(context).size.width,
            ),
            ready: false)
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SpacingWidget(LayoutSize.size16),
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: TextWidget(
                    text: "Your activities", style: Style.description),
              ),
              const SpacingWidget(LayoutSize.size4),
              ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: widget.viewModel.playerEvents?.length,
                itemBuilder: (context, index) {
                  return EventSimpleCardWidget(
                    icon: getIcon(widget.viewModel.playerEvents?[index]?.type),
                    color:
                        getColor(widget.viewModel.playerEvents?[index]?.type),
                    event: widget.viewModel.playerEvents?[index],
                    onPressed: () {
                      Session.instance.setEventId(
                          widget.viewModel.playerEvents?[index]?.id);
                      Modular.to.pushNamed(Routes.events,
                          arguments: EventFlows.eventDetail);
                    },
                  );
                },
              ),
            ],
          );
  }

  @override
  Future<bool> onBackPressed() async {
    widget.viewModel.setFlow(LeagueFlow.list);
    return false;
  }
}
