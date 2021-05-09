import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:language_app/components/appbar/appbar.dart';
import 'package:language_app/components/appbar/code/appbarCode.dart';
import 'package:language_app/components/common/commonComponents.dart';
import 'package:language_app/components/drawer/drawer.dart';
import 'package:language_app/models/lessonModel.dart';
import 'package:language_app/utils/global_const/globalLayout.dart';
import 'package:language_app/views/notes_view/notesModel.dart';
import 'package:provider/provider.dart';

import 'notesStyle.dart';
//TODO załaczniki

class NotesView extends StatefulWidget {
  NotesView(LessonModel selectedModel, {Key key, this.title})
      : super(key: key) {
    NotesViewModel.instance.selectedLesson = selectedModel;
  }

  final String title;

  @override
  _NotesViewState createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  final NotesViewModel _notesViewModel = NotesViewModel.instance;

  @override
  void initState() {
    super.initState();
    _notesViewModel.getNotes();
  }

  @override
  Widget build(BuildContext context) {
    final logoPath = "assets/images/paper1.png";
    final submitButton = OnPressButton("Submit", () async {
      await _notesViewModel.submitNotes();
    }, context);

    List<Widget> widgetList = [
      submitButton,
    ];

    return ChangeNotifierProvider.value(
      value: _notesViewModel,
      child: Consumer<NotesViewModel>(
        builder: (context, viewModel, child) => Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(50),
              child: MainAppBar(code: AppbarCode.New(notesTitle))),
          drawer: MainDrawer(),
          body: SingleChildScrollView(
            child: Center(
                child: Container(
                    child: Form(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: height1),
                          SizedBox(
                              height: imageHeight,
                              child: InsertImage(logoPath)),
                          SizedBox(height: height1),
                          Text(_notesViewModel.selectedLesson.name,
                              style: textStyle),
                          TextInputComponent2(
                              "Title",
                              false,
                              null, (val) {
                            _notesViewModel.note.title = val;
                          },
                              TextEditingController(
                                  text: _notesViewModel.note.title)),
                          SizedBox(height: height1),
                          TextField(
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              onChanged: (val) {
                                _notesViewModel.note.content[0] = val;
                              },
                              controller: TextEditingController(
                                  text: _notesViewModel.note.content[0]),
                              decoration: InputDecoration(
                                  labelText: 'Your note',
                                  helperText:
                                      'Enter the text and then accept with the submit button',
                                  hintText: 'Please enter notes',
                                  prefixIcon: const Icon(
                                      FontAwesomeIcons.bookOpen,
                                      color: Colors.teal),
                                  border: new OutlineInputBorder(
                                      borderSide:
                                          new BorderSide(color: Colors.teal)))),
                          SizedBox(height: height1),
                          widgetList[0],
                          SizedBox(height: height2),
                          MaterialButtonComponent()
                        ],
                      ),
                    )
                  ]),
            ))),
          ),
        ),
      ),
    );
  }
}
