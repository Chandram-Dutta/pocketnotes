// ignore_for_file: unused_result

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketnotes/auth/data/authstore.dart';
import 'package:pocketnotes/auth/presentation/signin_page.dart';
import 'package:pocketnotes/auth/services/auth_services.dart';
import 'package:pocketnotes/shared/pb_client.dart';

class AccountPage extends ConsumerWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userService = ref.watch(userServiceProvider);
    final authStore = ref.watch(authStoreProvider);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: FutureBuilder(
          future: userService.getOne(authStore.model.id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: [
                  Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    color: Theme.of(context).colorScheme.onBackground,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back_ios,
                              size: 30,
                              color: Theme.of(context).colorScheme.background,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            "Hello,\n${snapshot.data?.data['name']}.",
                            style: Theme.of(context)
                                .textTheme
                                .headline3!
                                .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                    fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Account Details:",
                            ),
                            const Divider(),
                            ListTile(
                              leading: const Icon(Icons.email),
                              title: const Text("Email"),
                              subtitle:
                                  SelectableText(snapshot.data?.data['email']),
                            ),
                            ListTile(
                              leading: const Icon(Icons.person),
                              title: const Text("Username"),
                              subtitle: SelectableText(
                                  snapshot.data?.data['username']),
                            ),
                            ListTile(
                              leading: const Icon(Icons.abc_rounded),
                              title: const Text("User ID"),
                              subtitle: SelectableText("${snapshot.data?.id}"),
                            ),
                            ListTile(
                              leading: const Icon(Icons.date_range),
                              title: const Text("Account Created On"),
                              //todo change date format
                              subtitle: Text("${snapshot.data?.created}"),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).colorScheme.error,
                          ),
                          foregroundColor: MaterialStateProperty.all(
                            Theme.of(context).colorScheme.errorContainer,
                          ),
                          elevation: MaterialStateProperty.all(
                            0,
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        onPressed: () {
                          ref.watch(logoutProvider);
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => SignInPage())),
                            (route) => false,
                          );
                        },
                        child: const Text("Sign Out"),
                      ),
                    ),
                  )
                ],
              );
            } else {
              return const Center(
                child: CupertinoActivityIndicator(
                  radius: 50,
                ),
              );
            }
          }),
    );
  }
}
