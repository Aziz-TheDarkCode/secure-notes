import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:note/_widgets/add_note_dialog.dart';
import 'package:note/_widgets/edit_dialog.dart';
import 'package:note/models/note.dart';
import 'package:note/services/note_service.dart';

class NotesPage extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  late Future<List<Note>> _notes;

  @override
  void initState() {
    super.initState();
    _notes = NoteService.getAllNotes();
  }

  void _refreshNotes() {
    setState(() {
      _notes = NoteService.getAllNotes();
    });
  }

  // Method to add a new note
  void _addNote() async {
    final newNote = await showDialog<Note>(
      context: context,
      builder: (BuildContext context) {
        return AddNoteDialog(); // Opens dialog for adding a note
      },
    );

    if (newNote != null) {
      await NoteService.addNote(newNote);
      _refreshNotes();
    }
  }

  void _editNote(Note oldNote) async {
    final updatedNote = await showDialog<Note>(
      context: context,
      builder: (BuildContext context) {
        return EditNoteDialog(note: oldNote); // Opens dialog for editing
      },
    );

    if (updatedNote != null) {
      await NoteService.updateNote(oldNote: oldNote, newNote: updatedNote);
      _refreshNotes();
    }
  }

  void _deleteAllNotes() async {
    await NoteService.deleteAllNotes();
    _refreshNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My notes'),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.delete),
            color: Colors.redAccent,
            onPressed: _deleteAllNotes,
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addNote,
          ),
        ],
      ),
      body: FutureBuilder<List<Note>>(
        future: _notes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No notes available.'));
          } else {
            return Padding(
              padding: const EdgeInsets.only(left: 0, right: 0),
              child: ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(height: 6),
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Note note = snapshot.data![index];
                  return ListTile(
                    subtitleTextStyle: const TextStyle(
                        color: Colors.indigoAccent,
                        fontWeight: FontWeight.w200),
                    title: Text(note.title),
                    subtitle: Text(note.content),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(
                            LucideIcons.pencil,
                            size: 20,
                          ),
                          color: Colors.black54,
                          onPressed: () => _editNote(note),
                        ),
                        IconButton(
                          icon: const Icon(LucideIcons.trash, size: 20),
                          color: Colors.redAccent,
                          onPressed: () async {
                            await NoteService.deleteNote(note);
                            _refreshNotes();
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
