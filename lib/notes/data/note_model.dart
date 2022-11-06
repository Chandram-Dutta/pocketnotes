import 'package:flutter/foundation.dart';

@immutable
class Note {
  final String title;
  final String content;

  const Note({
    required this.title,
    required this.content,
  });
}
