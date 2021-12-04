import 'package:e_racing_app/core/ui/component/ui/bound_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_from_widget.dart';
import 'package:e_racing_app/league/presentation/league_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../league_view_model.dart';

class LeagueCreateWidget extends StatefulWidget {
  final LeagueViewModel viewModel;

  const LeagueCreateWidget(this.viewModel, {Key? key}) : super(key: key);

  @override
  _LeagueCreateWidgetState createState() => _LeagueCreateWidgetState();
}

class _LeagueCreateWidgetState extends State<LeagueCreateWidget> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    _nameController.text = '';
    _descriptionController.text = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(child: create(), key: _formKey),
            Observer(builder: (_) {
              return Container();
            }),
          ],
        ),
        onWillPop: _onBackPressed);
  }

  Widget create() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          TextFormWidget("Nome", Icons.title, _nameController, (value) {
            if (value == null || value.isEmpty == true) {
              return 'Name needed';
            }
            return null;
          }),
          const BoundWidget(BoundType.medium),
          TextFormWidget("Descrição", Icons.title, _descriptionController,
              (value) {
            if (value == null || value.isEmpty == true) {
              return 'Name needed';
            }
            return null;
          }),
          const BoundWidget(BoundType.big),
          ButtonWidget("Concluir", ButtonType.normal, () {
            if (_formKey.currentState?.validate() == true) {}
          }),
        ],
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    return false;
  }
}
