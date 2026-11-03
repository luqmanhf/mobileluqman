import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mobileluqman/noteapp/db/note_db.dart';
import 'package:mobileluqman/noteapp/models/note.dart';
import 'package:mobileluqman/noteapp/pages/add_edit_note_page.dart';
import 'package:mobileluqman/noteapp/pages/note_detail_page.dart';
import 'package:mobileluqman/noteapp/widgets/note_card_widgets.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});
  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  late List<Note> notes;
  var isLoading = false;
  Future refreshNotes() async {
    setState(() {
      isLoading = true;
    });
    notes = await NoteDatabase.instance.getAllNotes();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    refreshNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes")
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
          )
          : notes.isEmpty
            ? const Text("Notes kosong")
            : MasonryGridView.count(
              crossAxisCount: 2,
              itemCount: notes.length,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              itemBuilder: (context, index) {
                final note = notes[index];
                return GestureDetector(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            NoteDetailPage(id: note.id!),
                      ),
                    );
                  refreshNotes();
                  },
                  child: NoteCardWidget(note: note, index: index,));
              }),
              floatingActionButton: FloatingActionButton(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddEditNotePage()));
                  refreshNotes();
                },
                child: const Icon(Icons.add),
              ),
    );
  }
}