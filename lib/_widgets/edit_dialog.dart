import 'package:flutter/material.dart';
import 'package:note/models/note.dart';

class EditNoteDialog extends StatefulWidget {
  final Note note;

  const EditNoteDialog({Key? key, required this.note}) : super(key: key);

  @override
  _EditNoteDialogState createState() => _EditNoteDialogState();
}

class _EditNoteDialogState extends State<EditNoteDialog> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note.title);
    _contentController = TextEditingController(text: widget.note.content);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Note'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: _contentController,
            decoration: const InputDecoration(labelText: 'Content'),
            maxLines: 3,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            final updatedNote = Note(
              id: widget.note.id,
              title: _titleController.text,
              content: _contentController.text,
              createTime: widget.note.createTime,
            );
            Navigator.of(context).pop(updatedNote);
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}
