import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketbase/pocketbase.dart';

final pbClientProvider = Provider<PocketBase>((ref) {
  return PocketBase("http://127.0.0.1:8090");
});

final userServiceProvider = Provider<RecordService>((ref) {
  return ref.watch(pbClientProvider).collection("users");
});

final notesServiceProvider = Provider<RecordService>((ref) {
  return ref.watch(pbClientProvider).collection("notes");
});
