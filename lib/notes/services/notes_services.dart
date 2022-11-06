import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:pocketnotes/auth/data/authstore.dart';
import 'package:pocketnotes/notes/data/note_model.dart';
import 'package:pocketnotes/shared/pb_client.dart';

final createNotesProvider = Provider.family<Future<String>, Note>(
  (ref, data) async {
    try {
      final authStore = ref.watch(authStoreProvider);
      final notesService = ref.watch(notesServiceProvider);
      final body = <String, dynamic>{
        "body": data.content,
        "title": data.title,
        "userId": authStore.model.id,
      };
      await notesService.create(
        body: body,
      );
      return "Success";
    } catch (e) {
      return e.toString();
    }
  },
);

final updateNotesProvider = Provider.family<Future<String>, List>(
  (ref, data) async {
    try {
      final notesService = ref.watch(notesServiceProvider);
      final body = <String, dynamic>{
        "body": data[1].content,
        "title": data[1].title,
      };
      await notesService.update(
        data[0],
        body: body,
      );
      return "Success";
    } catch (e) {
      return e.toString();
    }
  },
);

final deleteNoteProvider =
    Provider.family<Future<void>, String>((ref, id) async {
  final notesService = ref.watch(notesServiceProvider);
  return await notesService.delete(id);
});

final listNotesProvider = FutureProvider<List<RecordModel>>((ref) async {
  final notesService = ref.watch(notesServiceProvider);
  return notesService.getFullList(
    sort: '-created',
  );
});
