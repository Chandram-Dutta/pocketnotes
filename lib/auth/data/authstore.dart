import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:pocketnotes/shared/pb_client.dart';

final authStoreProvider = Provider<AuthStore>((ref) {
  return ref.watch(pbClientProvider).authStore;
});

final authStoreChangesProvider = StreamProvider<AuthStoreEvent>((ref) {
  return ref.watch(authStoreProvider).onChange;
});
