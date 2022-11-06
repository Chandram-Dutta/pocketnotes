import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:pocketnotes/notes/presentation/updatenotes_page.dart';
import 'package:pocketnotes/shared/services/timestamps.dart';

class ViewNotesPage extends ConsumerWidget {
  const ViewNotesPage({super.key, required this.note});

  final RecordModel note;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
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
                      Expanded(
                        child: SelectableText(
                          note.data['title'],
                          style: Theme.of(context)
                              .textTheme
                              .headline3
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.background,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    "Created ${readTimestamp(note.created)}",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.background,
                        ),
                  ),
                  Text(
                    "Updated ${readTimestamp(note.updated)}",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.background,
                        ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SelectableText(note.data['body']),
          ),
          const SizedBox(
            height: 80,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return UpdateNotesPage(
                  note: note,
                );
              },
            ),
          );
        },
        tooltip: "Edit",
        backgroundColor: Theme.of(context).colorScheme.onBackground,
        foregroundColor: Theme.of(context).colorScheme.background,
        child: const Icon(Icons.edit),
      ),
    );
  }
}
