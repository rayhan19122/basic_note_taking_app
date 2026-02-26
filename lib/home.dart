import 'package:basic_note_taking_app/model/note_model.dart';
import 'package:flutter/material.dart';

import 'database/db_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Note> notes = [];
  bool isLoading = false;

  final titleController = TextEditingController();
  final contentController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   refreshNote();
  }

  Future<void> refreshNote()async{
    setState(() {
      isLoading = true;
    });
    notes = await DatabaseHelper.instance.readNotes();
    setState(() {
      isLoading = false;
    });
  }

  // For adding note
  void showAddNote(){
    titleController.clear();
    contentController.clear();

    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: Color(0xFFF4F0E4),
            title: const Text('Add a New Note'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(hintText: 'Enter Title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.blue,width: 2),
                  ),
                  ),
                ),

                SizedBox(height: 10,),

                TextField(
                  controller: contentController,
                  decoration: const InputDecoration(hintText: 'Enter Content',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.blue,width: 2),
                  ),
                  ),
                  maxLines: 4,
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel',style: TextStyle(fontSize: 17,color: Color(0xFFEC8F8D)),)
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF44A194),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () async{
                  final ttl = titleController.text;
                  final cont = contentController.text;

                  if(ttl.isNotEmpty && cont.isNotEmpty){
                    final note = Note(title: ttl, content: cont);
                    await DatabaseHelper.instance.insertNote(note);
                    Navigator.pop(context);
                    refreshNote();
                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Title and Content cannot be empty')));
                  }
                },
                child: Text('Add',style: TextStyle(fontSize: 16),),
              ),
            ],
          );
        }
    );
  }

  // For updating note
  void showUpdateNote(Note existingNote){
    titleController.text = existingNote.title;
    contentController.text = existingNote.content;

    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: Color(0xFFF4F0E4),
            title: const Text('Edit Note'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(hintText: 'Enter Title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.blue,width: 2),
                    ),
                  ),
                ),

                SizedBox(height: 10,),

                TextField(
                  controller: contentController,
                  decoration: const InputDecoration(hintText: 'Enter Content',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.blue,width: 2),
                  ),
                  ),
                  maxLines: 4,
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel',style: TextStyle(fontSize: 17,color: Color(0xFFEC8F8D)),)
              ),

              ElevatedButton(onPressed: () async {
                final newTitle = titleController.text;
                final newContent = contentController.text;

                if(newTitle.isNotEmpty && newContent.isNotEmpty){
                  final note = Note(id: existingNote.id, title: newTitle, content: newContent);
                  await DatabaseHelper.instance.updateNote(note);
                  Navigator.pop(context);
                  refreshNote();
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Title and Content cannot be empty')));
                }
              }, style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF44A194),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
                  child: const Text('Update',style: TextStyle(fontSize: 16),)),
            ],
          );
        }
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'NOTABLE',
          style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF44A194),
      ),
      body: isLoading? const Center(child: CircularProgressIndicator()):
      notes.isEmpty? const Center(child: Text('No note added yet!')):
          ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index){
                final n = notes[index];
                return Card(
                  color: Color(0xFFF4F0E4),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 18,
                      backgroundColor: Color(0xFFEC8F8D),
                      foregroundColor: Color(0xFFF4F0E4),
                      child: Text('${index+1}',style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),)),
                    title: Text(notes[index].title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22)),
                    subtitle: Text(notes[index].content,style: TextStyle(fontSize: 18),),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(onPressed: (){
                          showUpdateNote(n);
                          refreshNote();
                        }, icon: const Icon(Icons.edit,color: Colors.blue,size: 28,)),

                        IconButton(onPressed: () async{
                          await DatabaseHelper.instance.deleteNote(n.id!);
                          refreshNote();
                        }, icon: const Icon(Icons.delete,color: Colors.red,size: 30,)),
                      ],
                    ),
                  ),
                );
              },
          ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        
        showAddNote();
      },
        backgroundColor: Color(0xFF44A194),
        foregroundColor: Color(0xFFF4F0E4),
      child: const Icon(Icons.add,),),
    );
  }
}
