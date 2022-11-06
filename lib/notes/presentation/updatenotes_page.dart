// ignore_for_file: use_build_context_synchronously, unused_result

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:pocketnotes/notes/data/note_model.dart';
import 'package:pocketnotes/notes/services/notes_services.dart';
import 'package:pocketnotes/shared/presentation/widgets/loader_dialog.dart';

class UpdateNotesPage extends ConsumerStatefulWidget {
  const UpdateNotesPage({
    super.key,
    required this.note,
  });

  final RecordModel note;

  @override
  ConsumerState<UpdateNotesPage> createState() => _UpdateNotesPageState();
}

class _UpdateNotesPageState extends ConsumerState<UpdateNotesPage> {
  @override
  initState() {
    super.initState();
    _titleController.text = widget.note.data['title'];
    _bodyController.text = widget.note.data['body'];
  }

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                    "Update the note.",
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                        color: Theme.of(context).colorScheme.background,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: "Title",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _bodyController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: const InputDecoration(
                labelText: "Body",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(
            height: 80,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          showLoaderDialog(context);
          String login = await ref.watch(
            updateNotesProvider(
              [
                widget.note.id,
                Note(
                  title: _titleController.text,
                  content: _bodyController.text,
                )
              ],
            ),
          );
          Navigator.pop(context);
          if (login == "Success") {
            ref.refresh(listNotesProvider);
            Navigator.pop(context);
            Navigator.pop(context);
          } else {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Error"),
                  content: const Text("Error! Note not saved"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Ok"),
                    ),
                  ],
                );
              },
            );
          }
        },
        backgroundColor: Theme.of(context).colorScheme.onBackground,
        foregroundColor: Theme.of(context).colorScheme.background,
        tooltip: "Update",
        child: const Icon(Icons.save),
      ),
    );
  }
}
