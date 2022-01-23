import 'package:e_racing_app/core/tools/routes.dart';
import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../event_view_model.dart';
import '../event_flow.dart';

class EventListWidget extends StatefulWidget {
  final EventViewModel viewModel;

  const EventListWidget(this.viewModel, {Key? key}) : super(key: key);

  @override
  _EventListWidgetState createState() => _EventListWidgetState();
}

class _EventListWidgetState extends State<EventListWidget>
    implements BaseSateWidget {
  @override
  void initState() {
    widget.viewModel.fetchEvents();
    widget.viewModel.fetchTags();
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
        onBackPressed: onBackPressed);
  }

  @override
  Future<bool> onBackPressed() async {
    widget.viewModel.deeplink(deepLink: Routes.leagues);
    return false;
  }

  @override
  Widget content() {
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: widget.viewModel.events?.length,
              itemBuilder: (context, index) {
                return TextWidget(
                    widget.viewModel.events?[index]?.type.toString() ?? '',
                    Style.description);
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: ERcaingApp.color.shade200,
          onPressed: () {
            widget.viewModel.setFlow(EventFlow.create);
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ));
  }
}
