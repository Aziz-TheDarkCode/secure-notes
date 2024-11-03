import 'package:flutter/material.dart';
import 'package:note/models/note.dart';
import 'package:note/services/database_service.dart';

class NoteService {
  static final DatabaseService _db = DatabaseService.instance;

  static Future<List<Note>> getAllNotes() async {
    final db = await _db.database;
    final List<Map<String, dynamic>> maps =
        await db.query('notes', orderBy: "created_time");

    return List.generate(maps.length, (index) {
      return Note(
        id: maps[index]['id'],
        title: maps[index]['title'],
        content: maps[index]['content'],
        createTime: DateTime.fromMillisecondsSinceEpoch(
            int.parse(maps[index]['created_time'])),
      );
    });
  }

  static Future<void> deleteAllNotes() async {
    try {
      final db = await _db.database;
      await db.delete('notes');
      debugPrint('All notes deleted successfully');
    } catch (e) {
      debugPrint('Error deleting all notes: $e');
      throw Exception('Failed to delete all notes: $e');
    }
  }

  static Future<Note?> addNote(Note note) async {
    final db = await _db.database;
    final noteData = {
      'title': note.title,
      'content': note.content,
      'created_time': DateTime.now().millisecondsSinceEpoch,
    };
    try {
      final id = await db.insert('notes', noteData);
      return Note(
        id: id,
        title: note.title,
        content: note.content,
        createTime: DateTime.now(),
      );
    } catch (e) {
      debugPrint('Error creating note: $e');
      return null;
    }
  }

  static Future<void> deleteNote(Note note) async {
    final db = await _db.database;
    try {
      await db.delete(
        'notes',
        where: 'id = ?',
        whereArgs: [note.id],
      );
      debugPrint('note with the ${note.id} has been deleted successfully');
    } catch (e) {
      debugPrint('Error deleting the note: $e');
      throw Exception('Failed to delete the note: $e');
    }
  }

  static Future<Note> updateNote({
    required Note oldNote,
    required Note newNote,
  }) async {
    try {
      final db = await _db.database;

      final noteData = {
        'title': newNote.title,
        'content': newNote.content,
        'created_time': oldNote.createTime.millisecondsSinceEpoch.toString(),
      };

      // Perform the update
      await db.update(
        'notes',
        noteData,
        where: 'id = ?',
        whereArgs: [oldNote.id],
      );

      debugPrint('Note with ID ${oldNote.id} updated successfully');
      return Note(
        id: oldNote.id,
        title: newNote.title,
        content: newNote.content,
        createTime: oldNote.createTime,
      );
    } catch (e) {
      debugPrint('Error updating the note: $e');
      throw Exception('Failed to update the note: $e');
    }
  }
}
