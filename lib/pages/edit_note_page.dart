import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/controllers/note_controller.dart';

class EditNotePage extends StatelessWidget {
  final controller = Get.put(NoteController());
  @override
  Widget build(BuildContext context) {
    final i = ModalRoute.of(context).settings.arguments;
    controller.titleController.text = controller.notes[i].title;
    controller.contentController.text = controller.notes[i].content;
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Edit Note",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 15, left: 15, right: 15),
          child: Column(
            children: [
              TextField(
                controller: controller.titleController,
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                    hintText: "Title",
                    hintStyle: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600],
                        letterSpacing: 1),
                    border: InputBorder.none),
              ),
              TextField(
                controller: controller.contentController,
                style: TextStyle(
                  fontSize: 22,
                ),
                decoration: InputDecoration(
                  hintText: "Title",
                  hintStyle: TextStyle(
                    fontSize: 17,
                  ),
                  border: InputBorder.none,
                ),
                maxLines: null,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.updateNote(
              controller.notes[i].id, controller.notes[i].dateTimeCreated);
        },
        child: Icon(Icons.save),
      ),
    );
  }
}
