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

String? formatHourWithGMT(String? date) {
  try {
    DateTime dateTime = toDatetime(date);
    return "${dateTime.hour}h ${dateTime.minute}min GMT${-4}";
  } catch (e) {
    return "";
  }
}

DateTime toDatetime(String? date) {
  return DateFormat('yyyy-MM-ddTHH:mm:ssZ').parse(date ?? '');
}
