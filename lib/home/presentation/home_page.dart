// ignore_for_file: unused_result

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:pocketnotes/auth/presentation/account_page.dart';
import 'package:pocketnotes/notes/presentation/createnotes_page.dart';
import 'package:pocketnotes/notes/presentation/viewnotes_page.dart';
import 'package:pocketnotes/notes/services/notes_services.dart';
import 'package:pocketnotes/shared/services/timestamps.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notesLists = ref.watch(listNotesProvider);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: ListView(
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Your Notes",
                        style: Theme.of(context).textTheme.headline2?.copyWith(
                              color: Theme.of(context).colorScheme.background,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const AccountPage();
                              },
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.person,
                          size: 30,
                          color: Theme.of(context).colorScheme.background,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          notesLists.when(
            data: ((data) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: data.length,
                  shrinkWrap: true,
                  itemBuilder: ((context, index) {
                    RecordModel item = data[index];
                    return Dismissible(
                      background: Container(
                        color: Theme.of(context).colorScheme.error,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.delete,
                                color: Theme.of(context).colorScheme.onError,
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                      secondaryBackground: Container(
                        color: Theme.of(context).colorScheme.error,
                        child: Row(
                          children: [
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.delete,
                                color: Theme.of(context).colorScheme.onError,
                              ),
                            ),
                          ],
                        ),
                      ),
                      key: UniqueKey(),
                      onDismissed: (direction) async {
                        await ref.watch(deleteNoteProvider(item.id));
                        ref.refresh(listNotesProvider);
                      },
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return ViewNotesPage(
                                  note: item,
                                );
                              },
                            ),
                          );
                        },
                        child: Card(
                          child: ListTile(
                            title: Text(item.data["title"]),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.data["body"],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const Divider(),
                                Text(readTimestamp(item.updated))
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              );
            }),
            error: ((error, stackTrace) => const Center(
                  child: Icon(Icons.error),
                )),
            loading: (() => const Center(
                  child: CupertinoActivityIndicator(
                    radius: 50,
                  ),
                )),
          ),
          const SizedBox(
            height: 80,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Theme.of(context).colorScheme.onBackground,
        foregroundColor: Theme.of(context).colorScheme.background,
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateNotesPage(),
            ),
          )
        },
        tooltip: 'Create a Note',
        icon: const Icon(
          Icons.add,
        ),
        label: const Text("Create a Note"),
      ),
    );
  }
}
