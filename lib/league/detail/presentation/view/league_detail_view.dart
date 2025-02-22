import 'package:e_racing_app/core/ext/event_iconography_extension.dart';
import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/banner_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/event_simple_card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/float_action_button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/shortcut_collection_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/social_collection_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../core/ext/access_extension.dart';
import '../../../../core/ext/dialog_extension.dart';
import '../../../../core/tools/session.dart';
import '../../../../core/ui/component/ui/button_widget.dart';
import '../../../../core/ui/component/ui/tag_collection_widget.dart';
import '../league_detail_view_model.dart';
import '../navigation/league_detail_navigation.dart';

class LeagueDetailView extends StatefulWidget {
  final LeagueDetailViewModel viewModel;

  const LeagueDetailView(this.viewModel, {super.key});

  @override
  LeagueDetailViewState createState() => LeagueDetailViewState();
}

class LeagueDetailViewState extends State<LeagueDetailView>
    implements BaseSateWidget {
  @override
  void initState() {
    widget.viewModel.fetchTags();
    widget.viewModel.getLeague();
    widget.viewModel.getPlayerEvents();
    widget.viewModel.getMenu();
    widget.viewModel.title = "Community";
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
        body: content(),
        state: widget.viewModel.state,
        bottom: doSubscribeButton(),
        onBackPressed: onBackPressed,
        floatAction: getAction());
  }

  @override
  Widget content() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 16),
          child: header(),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: playersEvent(),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: panel(),
        ),
        const SpacingWidget(LayoutSize.size64),
      ],
    );
  }

  Widget header() {
    return Column(
      children: [
        BannerWidget(
          media: widget.viewModel.media,
          loadDefault: widget.viewModel.shouldLoadDefaultPoster,
        ),
        const SpacingWidget(LayoutSize.size16),
        leagueTitle(),
        ButtonWidget(
            enabled: true,
            type: ButtonType.info,
            label: "About this community",
            onPressed: () {
              leagueDetail();
            }),
        const SpacingWidget(LayoutSize.size16),
      ],
    );
  }

  Widget leagueTitle() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Wrap(
          children: [
            TextWidget(
              text: widget.viewModel.league?.name ?? '',
              style: Style.title,
              align: TextAlign.left,
            )
          ],
        ),
      ),
    );
  }

  Widget leagueSocial() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SocialCollectionWidget(
          hide: widget.viewModel.league?.links == null,
          links: widget.viewModel.league?.links,
          socialPlatforms: widget.viewModel.socialMedias,
        ),
      ],
    );
  }

  Widget leagueDescription(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Wrap(
                children: const [
                  TextWidget(
                    text: "About",
                    style: Style.subtitle,
                    align: TextAlign.start,
                  ),
                ],
              ),
              ButtonWidget(
                  enabled: true,
                  icon: Icons.cancel,
                  type: ButtonType.iconShapeless,
                  onPressed: () {
                    Navigator.pop(context);
                  })
            ],
          ),
          const SpacingWidget(LayoutSize.size32),
          Wrap(
            children: [
              TextWidget(
                text: widget.viewModel.league?.description ?? '',
                style: Style.paragraph,
                align: TextAlign.justify,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget leagueTags() {
    return Wrap(
      children: [
        Column(
          children: [
            const SpacingWidget(LayoutSize.size32),
            TagCollectionWidget(
              tagIds: widget.viewModel.league?.tags,
              tags: widget.viewModel.tags,
            ),
          ],
        )
      ],
    );
  }

  Widget panel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShortcutCollectionWidget(
          shortcuts: widget.viewModel.menus?.toList(),
          onPressed: widget.viewModel.deeplink,
        ),
      ],
    );
  }

  Widget playersEvent() {
    return widget.viewModel.events == null
        ? CardWidget(
            ready: false,
            child: SizedBox(
              height: 100,
              width: MediaQuery.of(context).size.width,
            ))
        : playerContentWidget();
  }

  Widget playerContentWidget() {
    return widget.viewModel.events?.isEmpty == true
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SpacingWidget(LayoutSize.size16),
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: TextWidget(
                    text: "Recent events", style: Style.subtitle),
              ),
              const SpacingWidget(LayoutSize.size16),
              ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: widget.viewModel.events?.length,
                itemBuilder: (context, index) {
                  return EventSimpleCardWidget(
                    icon: getIcon(widget.viewModel.events?[index]?.type),
                    color: getColor(
                        widget.viewModel.events?[index]?.type, context),
                    event: widget.viewModel.events?[index],
                    onPressed: () {
                      Session.instance
                          .setEventId(widget.viewModel.events?[index]?.id);
                      widget.viewModel.gotToEvent();
                    },
                  );
                },
              ),
            ],
          );
  }

  FloatActionButtonWidget? getAction() {
    return isLeagueHost(widget.viewModel.league)
        ? FloatActionButtonWidget(
            icon: Icons.build,
            title: "Edit",
            onPressed: () {
              widget.viewModel.onRoute(LeagueDetailNavigationSet.update);
            },
          )
        : widget.viewModel.hasMembership == true
            ? FloatActionButtonWidget(
                icon: Icons.workspace_premium,
                title: "",
                onPressed: () {
                  confirmationDialogExt(
                    context: context,
                    issueMessage: "Do you wanto to cancel your membership?",
                    consentMessage: "Yes, I do",
                    onPositive: () {
                      widget.viewModel.stopMembership();
                    },
                  );
                },
              )
            : null;
  }

  Widget? doSubscribeButton() {
    return widget.viewModel.hasMembership == null
        ? null
        : widget.viewModel.hasMembership == true
            ? null
            : ButtonWidget(
                enabled: true,
                type: ButtonType.secondary,
                onPressed: () {
                  widget.viewModel.startMembership();
                },
                label: "Become a member",
              );
  }

  leagueDetail() {
    showModalBottomSheet(
        isDismissible: true,
        isScrollControlled: true,
        context: context,
        builder: (context) =>
            StatefulBuilder(builder: (BuildContext context, myState) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Observer(builder: (context) {
                  return Wrap(
                    children: [
                      leagueDescription(context),
                      leagueSocial(),
                      leagueTags(),
                      const SpacingWidget(LayoutSize.size8),
                    ],
                  );
                }),
              );
            }));
  }

  @override
  Future<bool> onBackPressed() async {
    return true;
  }
}
