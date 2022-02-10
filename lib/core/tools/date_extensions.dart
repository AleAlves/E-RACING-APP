extension DateFormting on String {
  String formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  String formatHour(DateTime date) {
    return "${date.hour}h ${date.minute}min";
  }
}
