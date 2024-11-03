import 'package:flutter/material.dart';
import 'package:note/_widgets/shared/custom_input.dart';
import 'package:note/models/note.dart';

class AddNoteDialog extends StatefulWidget {
  @override
  _AddNoteDialogState createState() => _AddNoteDialogState();
}

class _AddNoteDialogState extends State<AddNoteDialog> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('New Note'),
          Text(
            'Organize Thoughts, Never Miss a Moment.',
            style: TextStyle(
                fontWeight: FontWeight.w100,
                color: Colors.black26,
                fontSize: 16),
          )
        ],
      ),
      content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomInput(
                hintText: 'Enter your title',
                icon: Icons.title,
                controller: _titleController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Title is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              CustomInput(
                hintText: 'Enter description',
                icon: Icons.description,
                controller: _contentController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Description is required';
                  }
                  return null;
                },
                maxLines: 3,
              ),
            ],
          )),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context)
                .pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final newNote = Note(
                title: _titleController.text,
                content: _contentController.text,
                createTime: DateTime.now(),
              );
              Navigator.of(context)
                  .pop(newNote);
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
