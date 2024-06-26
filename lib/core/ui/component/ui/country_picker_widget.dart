import 'package:country_code_picker/country_code_picker.dart';
import 'package:e_racing_app/core/ui/component/state/loading_shimmer.dart';
import 'package:flutter/material.dart';

class CountryPickerWidget extends StatefulWidget {
  final String? country;
  final Function(String?) onCountrySelected;

  const CountryPickerWidget(
      {this.country, required this.onCountrySelected, Key? key})
      : super(key: key);

  Widget loading(BuildContext context) {
    return const Card(child: LoadingShimmer());
  }

  @override
  _CountryPickerWidgetState createState() => _CountryPickerWidgetState();
}

class _CountryPickerWidgetState extends State<CountryPickerWidget> {
  bool loaded = false;
  Image? image;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CountryCodePicker(
      padding: const EdgeInsets.all(24),
      onChanged: (e) => widget.onCountrySelected.call(e.code),
      initialSelection: widget.country ?? 'BR',
      showCountryOnly: false,
      showOnlyCountryWhenClosed: true,
      backgroundColor: Theme.of(context).colorScheme.background,
      dialogBackgroundColor: Theme.of(context).colorScheme.background,
      favorite: const ['+55', 'BR'],
    );
  }
}
