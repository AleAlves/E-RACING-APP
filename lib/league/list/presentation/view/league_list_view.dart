import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/ext/access_extension.dart';
import '../../../../core/tools/session.dart';
import '../../../../core/ui/component/ui/button_widget.dart';
import '../../../../core/ui/component/ui/float_action_button_widget.dart';
import '../../../../core/ui/component/ui/league_card_widget.dart';
import '../../../../core/ui/component/ui/spacing_widget.dart';
import '../../../LeagueRouter.dart';
import '../league_list_view_model.dart';

class LeagueListView extends StatefulWidget {
  final LeagueListViewModel viewModel;

  const LeagueListView(this.viewModel, {Key? key}) : super(key: key);

  @override
  _LeagueListViewState createState() => _LeagueListViewState();
}

class _LeagueListViewState extends State<LeagueListView>
    implements BaseSateWidget {
  @override
  void initState() {
    widget.viewModel.getLeagues();
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
        scrollable: true,
        state: widget.viewModel.state,
        onBackPressed: onBackPressed,
        floatAction: FloatActionButtonWidget(
          icon: Icons.filter_alt,
          title: "Search tags",
          onPressed: () {
            searchBottomSheet();
          },
        ));
  }

  @override
  Future<bool> onBackPressed() async {
    Modular.to.pop();
    return false;
  }

  @override
  Widget content() {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 0),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.viewModel.leagues?.length,
        itemBuilder: (context, index) {
          return LeagueCardWidget(
              label: widget.viewModel.leagues?[index]?.name,
              members: widget.viewModel.leagues?[index]?.members?.length,
              capacity: widget.viewModel.leagues?[index]?.capacity,
              hasMembership: isLeagueMember(widget.viewModel.leagues?[index]),
              tags: widget.viewModel.tags,
              leagueTags: widget.viewModel.leagues?[index]?.tags,
              onPressed: () {
                var id = widget.viewModel.leagues?[index]?.id;
                Session.instance.setLeagueId(id);
                Modular.to.pushNamed(LeagueRouter.detail);
              });
        },
      ),
    );
  }

  searchBottomSheet() {
    showModalBottomSheet(
        isDismissible: true,
        isScrollControlled: true,
        context: context,
        builder: (context) =>
            StatefulBuilder(builder: (BuildContext context, myState) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Observer(builder: (context) {
                  return Wrap(
                    children: [
                      tagWidget(myState),
                      const SpacingWidget(LayoutSize.size32),
                      ButtonWidget(
                          enabled: true,
                          label: "Search",
                          type: ButtonType.primary,
                          onPressed: () {
                            widget.viewModel.searchEvents();
                            Navigator.of(context).pop();
                          }),
                      const SpacingWidget(LayoutSize.size16),
                    ],
                  );
                }),
              );
            }));
  }

  Widget tagWidget(StateSetter myState) {
    return widget.viewModel.tags!.isEmpty
        ? Container()
        : Padding(
            padding: EdgeInsets.zero,
            child: Wrap(
              children: widget.viewModel.tags!
                  .map((item) {
                    final selected =
                        widget.viewModel.searchTags?.contains(item?.id) ??
                            false;
                    return ActionChip(
                        avatar: CircleAvatar(
                          backgroundColor: selected
                              ? Theme.of(context).colorScheme.secondary
                              : null,
                          child: selected ? const Text('-') : const Text('+'),
                        ),
                        label: Text(item?.name ?? ''),
                        onPressed: () {
                          myState(() {
                            selected
                                ? widget.viewModel.searchTags?.remove(item?.id)
                                : widget.viewModel.searchTags
                                    ?.add(item?.id ?? '');
                          });
                        });
                  })
                  .toList()
                  .cast<Widget>(),
            ),
          );
  }
}
