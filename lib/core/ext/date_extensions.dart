import 'package:intl/intl.dart';

String? formatDate(String? date) {
  try {
    DateTime dateTime = toDatetime(date);
    var month = DateFormat.MMMM().format(dateTime);
    return "${dateTime.day}, $month ${dateTime.year}";
  } catch (e) {
    return "";
  }
}

String? formatHour(String? date) {
  try {
    DateTime dateTime = toDatetime(date);
    return "${dateTime.hour}h ${dateTime.minute}min";
  } catch (e) {
    return "";
  }
}

DateTime toDatetime(String? date) {
  return DateFormat('yyyy-MM-ddTHH:mm:ssZ').parse(date ?? '');
}
