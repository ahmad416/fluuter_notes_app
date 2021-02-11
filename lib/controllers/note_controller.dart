import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'package:string_stats/string_stats.dart';

import 'package:notes/models/note.dart';
import 'package:notes/services/database_services/database_healper.dart';

class NoteController extends GetxController {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  List<Note> notes = [];
  int contentCount = 0;
  int contentCharCount = 0;

  // initilizing onint
  @override
  void onInit() {
    getAllNotes();
    super.onInit();
  }

  // checking is empty
  bool isEmpty() {
    if (notes.length == 0) {
      return true;
    } else {
      return false;
    }
  }

  void updateNote(int id, String dTCreated) async {
    final title = titleController.text;
    final content = contentController.text;
    Note note = Note(
      id: id,
      title: title,
      content: content,
      dateTimeEdited:
          DateFormat("MMM dd, yyyy HH:mm:ss").format(DateTime.now()),
      dateTimeCreated: dTCreated,
    );
    await DatabaseHelper.instance.updateNote(note);
    contentCount = wordCount(content);
    contentCharCount = charCount(content);
    titleController.text = "";
    contentController.text = "";
    getAllNotes();
    Get.back();
  }

  // adding new note
  void addNoteToDatabase() async {
    String title = titleController.text;
    String content = contentController.text;
    if (title.isBlank) {
      title = 'Unnamed Title';
    }
    Note note = Note(
        title: title,
        content: content,
        dateTimeCreated:
            DateFormat("MMM dd, yyy HH:mm:ss").format(DateTime.now()),
        dateTimeEdited:
            DateFormat("MMM dd, yyy HH:mm:ss").format(DateTime.now()));
    await DatabaseHelper.instance.addNote(note);
    contentCount = wordCount(content);
    contentCharCount = charCount(content);
    titleController.text = '';
    contentController.text = '';
    getAllNotes();
    Get.back();
  }

  // gtting all notes
  void getAllNotes() async {
    notes = await DatabaseHelper.instance.getNoteList();
    update();
  }

  // delete note
  void deleteNote(int id) async {
    Note note = Note(id: id);
    await DatabaseHelper.instance.deleteNote(note);
    getAllNotes();
  }

  // chare note
  void shareNote(String title, String content, String dateTimeEdited) {
    Share.share("$title \n\n $dateTimeEdited \n\n$content");
  }
}
