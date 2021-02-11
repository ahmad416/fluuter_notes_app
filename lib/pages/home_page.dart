import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:notes/controllers/note_controller.dart';
import 'package:notes/pages/add_new_note_page.dart';
import 'package:notes/pages/note_detail.dart';
import 'package:notes/widgets/alert_dialogue_widget.dart';
import 'package:notes/widgets/search_bar.dart';

class HomePage extends StatelessWidget {
  final controller = Get.put(NoteController());

  Widget emptyNote() {
    return Container(
      child: Center(
        child: Text("You don't have any Notes"),
      ),
    );
  }

  Widget viewNotes() {
    return Scrollbar(
      child: Container(
        padding: EdgeInsets.only(top: 10, right: 10, left: 10),
        child: StaggeredGridView.countBuilder(
          itemCount: controller.notes.length,
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          staggeredTileBuilder: (index) => StaggeredTile.fit(1),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Get.to(NoteDetailPage(), arguments: index);
              },
              onLongPress: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDailogueWidget(
                        contentText:
                            'Are you sure you want to delete the note?',
                        confirmFunction: () {
                          controller.deleteNote(controller.notes[index].id);
                          Get.back();
                        },
                        declineFunction: () {
                          Get.back();
                        },
                      );
                    });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text(
                      controller.notes[index].title,
                      style:
                          TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      controller.notes[index].content,
                      style: TextStyle(
                        fontSize: 17,
                      ),
                      maxLines: 6,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(controller.notes[index].dateTimeEdited)
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        title: Text(
          "Home",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: SearchBar());
            },
          ),
          PopupMenuButton(
            onSelected: (val) {
              if (val == 0) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDailogueWidget(
                        contentText:
                            "Are you sure you want to delete all notes?",
                        confirmFunction: () {
                          Get.back();
                        },
                        declineFunction: () {
                          Get.back();
                        },
                      );
                    });
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 0,
                child: Text(
                  "Delete All Notes",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              )
            ],
          )
        ],
      ),
      body: GetBuilder<NoteController>(
        builder: (_) => controller.isEmpty() ? emptyNote() : viewNotes(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(AddNewNotePage());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
