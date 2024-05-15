import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sqlliteoperation/db_handler.dart';
import 'package:sqlliteoperation/db_handler.dart';

import 'package:sqlliteoperation/note_model.dart';

import '../db_handler.dart';



class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key});


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController titleEtController = TextEditingController();
  TextEditingController descriptionctrl = TextEditingController();
  TextEditingController AgeCTRL = TextEditingController();
  TextEditingController emailCTRL = TextEditingController();
  DBHelper? dbHelper;
 late Future<List<NoteModel>>  noteList ;
 // NoteModel ob = NoteModel(title: "hey", age: 20, description: "hello bhai", email: "Ji@gmail.com");
  @override
  void initState() {

    dbHelper= DBHelper();
    loadData();
    // TODO: implement initState
    super.initState();

  }
  loadData ()async
  {
   noteList =  dbHelper!.getNoteList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes APP"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(

          children: [
            Expanded(
              child: FutureBuilder(future: noteList, builder: (context,AsyncSnapshot<List<NoteModel>> snapshot) {
                if(snapshot.data==null)
                  {
                    return Text("bye");
                  }
                else{
                  return ListView.builder(
                    reverse: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                     return Container(
                       child: Card(
                         color: Colors.orangeAccent,
                         child: Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               Expanded(
                                 flex:5,
                                 child: Container(
                                   color: Colors.green,
                                   child: Column(
                                     children: [
                                       Text("Title:"+snapshot.data![index].title.toString()),
                                       Text("Age:"+snapshot.data![index].age.toString()),
                                       Text("Description:"+snapshot.data![index].description.toString()),
                                       Text("Email:"+snapshot.data![index].email.toString()),
                                     ],
                                   ),
                                 ),
                               ),
                              Expanded(
                                flex:1,
                                child: Text("Testing"),),
                               
                              // IconButton(onPressed: (){}, icon: Icon(Icons.delete)),
                             ],
                           ),
                         ),
                       ),


                     );
                });
                }

              
              },)
            )

          ],

        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        _showForm(context,null);



      },child: Icon(Icons.add) ,),

    );
  }
  void _showForm(BuildContext cntxt ,int? itemKey)
  {

    // if(itemKey!=null)
    // {
    //   final existingNote = _notesListss.firstWhere((element) => element['key']==itemKey);
    //   _titeController.text=existingNote['title'];
    //   _description.text=existingNote['description'];
    // }
    showModalBottomSheet(context: cntxt,
      backgroundColor: Colors.white,

      elevation: 5,
      isScrollControlled: true,

      builder: (context) {
        return Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(cntxt).viewInsets.bottom ,//**,
            top: 15,
            left: 15,
            right: 15,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,//*******
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: titleEtController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(width: 3,color: Colors.white)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(width: 3,color: Colors.white)
                  ),
                  border: OutlineInputBorder(

                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(width: 3,color: Colors.white)

                  ),
                  hintText: 'Title',
                ),
              ),
              SizedBox(height: 10,),
              TextField(
                controller: AgeCTRL,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(width: 3,color: Colors.white)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(width: 3,color: Colors.white)
                  ),
                  border: OutlineInputBorder(

                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(width: 3,color: Colors.white)

                  ),
                  hintText: 'Age',
                ),
              ),
              SizedBox(height: 10,),
              TextField(
                controller: descriptionctrl,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(width: 3,color: Colors.white)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(width: 3,color: Colors.white)
                  ),
                  border: OutlineInputBorder(

                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(width: 3,color: Colors.white)

                  ),
                  hintText: 'Description',
                ),
              ),
              SizedBox(height: 10,),
              TextField(
                controller: emailCTRL,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(width: 3,color: Colors.white)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(width: 3,color: Colors.white)
                  ),
                  border: OutlineInputBorder(

                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(width: 3,color: Colors.white)

                  ),
                  hintText: 'Email',
                ),
              ),

              SizedBox(height: 20,),
              ElevatedButton(onPressed: () {
                NoteModel noteModel = NoteModel(title: titleEtController.text.toString(), age: int.parse(AgeCTRL.text.toString()), description: descriptionctrl.text.toString(), email: emailCTRL.text.toString());
                dbHelper!.insert(noteModel);
                noteList =  dbHelper!.getNoteList();
                titleEtController.text="";
               AgeCTRL.text='';
               descriptionctrl.text='';
               emailCTRL.text='';
                Navigator.of(context).pop();

                setState(() {

                });
                //   if(itemKey==null)
                //   {
                //
                //     _createNote({
                //       'title': _titeController.text.toString(),
                //       'description': _description.text.toString()
                //
                //     });
                //   }
                //   if(itemKey!=null)
                //   {
                //     _updateNote(itemKey, {'title':_titeController.text.trim(),'description':_description.text.trim()});
                //   }
                //   _titeController.text='';
                //   _description.text='';
                //   Navigator.of(context).pop();
                // },
              },
                  child: Text("Add")),
              const SizedBox(height: 20,),

            ],
          ),
        );

      },);
  }

}
