extension ExDateTime on DateTime {

  bool isSameDay(DateTime dt) {
    final diff = difference(dt);
    return diff.inDays == 0;
  }
}