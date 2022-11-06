import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketnotes/auth/data/authstore.dart';
import 'package:pocketnotes/shared/pb_client.dart';

final isLoggedInProvider = Provider<bool>((ref) {
  return ref.watch(authStoreProvider).isValid;
});

final loginWithEmailProvider = Provider.family<Future<String>, List<String>>(
  (ref, data) async {
    try {
      final userService = ref.watch(userServiceProvider);
      final authStore = ref.watch(authStoreProvider);
      final email = data[0];
      final password = data[1];
      final response = await userService.authWithPassword(email, password);
      authStore.save(response.token, response.record);
      // ignore: unused_result
      ref.refresh(isLoggedInProvider);
      return "Success";
    } catch (e) {
      return e.toString();
    }
  },
);

final createAccountProvider = Provider.family<Future<String>, List<String>>(
  (ref, data) async {
    try {
      final userService = ref.watch(userServiceProvider);
      final body = <String, dynamic>{
        "email": data[1],
        "emailVisibility": true,
        "password": data[2],
        "passwordConfirm": data[3],
        "name": data[0]
      };
      await userService.create(
        body: body,
      );
      return "Success";
    } catch (e) {
      return e.toString();
    }
  },
);

final logoutProvider = Provider((ref) {
  ref.watch(authStoreProvider).clear();
});
