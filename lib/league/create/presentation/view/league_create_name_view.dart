import 'package:e_racing_app/league/create/presentation/navigation/league_create_flow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../core/ui/component/state/view_state_widget.dart';
import '../../../../../core/ui/component/ui/button_widget.dart';
import '../../../../../core/ui/component/ui/input_text_widget.dart';
import '../../../../../core/ui/component/ui/spacing_widget.dart';
import '../../../../../core/ui/component/ui/text_widget.dart';
import '../../../../../core/ui/view_state.dart';
import '../league_create_view_model.dart';

class LeagueCreateNameView extends StatefulWidget {
  final LeagueCreateViewModel viewModel;

  const LeagueCreateNameView(this.viewModel, {Key? key}) : super(key: key);

  @override
  _LeagueCreateNameViewState createState() => _LeagueCreateNameViewState();
}

class _LeagueCreateNameViewState extends State<LeagueCreateNameView>
    implements BaseSateWidget {
  var isValid = false;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  @override
  void initState() {
    observers();
    _nameController.text = widget.viewModel.name ?? '';
    _nameController.addListener(observers);
    widget.viewModel.fetchTerms();
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
  observers() {
    _nameController.addListener(() {
      final String text = _nameController.text;
      setState(() {
        isValid = text.isNotEmpty;
      });
    });
  }

  @override
  ViewStateWidget viewState() {
    return ViewStateWidget(
      body: content(),
      bottom: button(),
      scrollable: false,
      onBackPressed: onBackPressed,
      state: widget.viewModel.state,
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

  Widget guideLines() {
    return const TextWidget(
        text: "What will your league be named?", style: Style.subtitle);
  }

  Widget leagueNameForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: InputTextWidget(
          enabled: true,
          label: 'Name',
          icon: Icons.person,
          controller: _nameController,
          validator: (value) {
            if (value == null || value.isEmpty == true) {
              isValid = false;
              return 'valid name needed';
            }
            return null;
          }),
    );
  }

  Widget button() {
    return ButtonWidget(
      enabled: _nameController.value.text.isNotEmpty,
      type: ButtonType.primary,
      onPressed: () {
        widget.viewModel.setName(_nameController.text);
      },
      label: "Next",
    );
  }

  @override
  Future<bool> onBackPressed() async {
    widget.viewModel.onNavigate(LeagueCreateNavigator.terms);
    return false;
  }
}
