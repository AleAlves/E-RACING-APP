import 'package:intl/intl.dart';


String formatDate(String? date) {
  DateTime dateTime = toDatetime(date);
  var month = DateFormat.MMMM().format(dateTime);
  return "${dateTime.day}, $month ${dateTime.year}";
}

String formatHour(String? date) {
  DateTime dateTime = toDatetime(date);
  return "${dateTime.hour}h ${dateTime.minute}min";
}

DateTime toDatetime(String? date) {
  return DateFormat('yyyy-MM-ddTHH:mm:ssZ').parse(date ?? '');
}