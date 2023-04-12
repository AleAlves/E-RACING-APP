import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../core/ui/component/state/view_state_widget.dart';
import '../../../../../core/ui/component/ui/button_widget.dart';
import '../../../../../core/ui/component/ui/input_text_widget.dart';
import '../../../../../core/ui/component/ui/spacing_widget.dart';
import '../../../../../core/ui/component/ui/text_widget.dart';
import '../../../../../core/ui/view_state.dart';
import '../../league_create_view_model.dart';
import '../../navigation/league_create_flow.dart';

class LeagueCreateDescriptionView extends StatefulWidget {
  final LeagueCreateViewModel viewModel;

  const LeagueCreateDescriptionView(this.viewModel, {Key? key})
      : super(key: key);

  @override
  _LeagueCreateDescriptionViewState createState() =>
      _LeagueCreateDescriptionViewState();
}

class _LeagueCreateDescriptionViewState
    extends State<LeagueCreateDescriptionView> implements BaseSateWidget {
  var isValid = false;
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    observers();
    super.initState();
    _descriptionController.text = widget.viewModel.description ?? '';
    _descriptionController.addListener(observers);
    widget.viewModel.fetchTerms();
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
      bottom: button(),
      scrollable: false,
      onBackPressed: onBackPressed,
      state: ViewState.ready,
    );
  }

  @override
  Widget content() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          guideLines(),
          const SpacingWidget(LayoutSize.size48),
          Form(
            child: leagueNameForm(),
            key: _formKey,
          ),
        ],
      ),
    );
  }

  @override
  observers() {
    _descriptionController.addListener(() {
      final String text = _descriptionController.text;
      setState(() {
        isValid = text.isNotEmpty;
      });
    });
  }

  Widget guideLines() {
    return const TextWidget(
        text:
            "Descibre the leagues caracteristics, what type of  game, platform, racing is ok",
        style: Style.subtitle);
  }

  Widget leagueNameForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: InputTextWidget(
          enabled: true,
          label: 'Description',
          icon: Icons.person,
          inputType: InputType.multilines,
          controller: _descriptionController,
          validator: (value) {
            if (value == null || value.isEmpty == true) {
              return 'type something';
            }
            return null;
          }),
    );
  }

  Widget button() {
    return ButtonWidget(
      enabled: isValid,
      type: ButtonType.primary,
      onPressed: () {
        widget.viewModel.setDescription(_descriptionController.text);
      },
      label: "Next",
    );
  }

  @override
  Future<bool> onBackPressed() async {
    widget.viewModel.onNavigate(LeagueCreateNavigator.name);
    return false;
  }
}
