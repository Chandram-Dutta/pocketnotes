import 'package:intl/intl.dart';

String readTimestamp(String timestamp) {
  var now = DateTime.now();
  var format = DateFormat('HH:mm a');
  var date = DateTime.parse(timestamp);
  var diff = now.difference(date);
  var time = '';

  if (diff.inSeconds <= 0 ||
      diff.inSeconds > 0 && diff.inMinutes == 0 ||
      diff.inMinutes > 0 && diff.inHours == 0 ||
      diff.inHours > 0 && diff.inDays == 0) {
    time = "${format.format(date)} today.";
  } else if (diff.inDays > 0 && diff.inDays < 7) {
    if (diff.inDays == 1) {
      time = '${diff.inDays} day ago.';
    } else {
      time = '${diff.inDays} days ago.';
    }
  } else {
    if (diff.inDays == 7) {
      time = '${(diff.inDays / 7).floor()} week ago.';
    } else {
      time = '${(diff.inDays / 7).floor()} weeks ago.';
    }
  }

  return time;
}
