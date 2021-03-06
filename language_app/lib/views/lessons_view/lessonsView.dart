import 'package:flutter/material.dart';
import 'package:language_app/components/appbar/appbar.dart';
import 'package:language_app/components/appbar/code/appbarCode.dart';
import 'package:language_app/components/common/commonComponents.dart';
import 'package:language_app/components/drawer/drawer.dart';
import 'package:language_app/utils/global_const/globalLayout.dart';
import 'package:language_app/views/notes_view/notesView.dart';
import 'package:provider/provider.dart';

import 'lessonsModel.dart';
import 'lessonsStyle.dart';

class LessonsView extends StatefulWidget {
  LessonsView({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LessonsViewState createState() => _LessonsViewState();
}

class _LessonsViewState extends State<LessonsView> {
  final LessonsViewModel _lessonsViewModel = LessonsViewModel.instance;

  @override
  void initState() {
    super.initState();
    _lessonsViewModel.getUsersLesson();
  }

  @override
  Widget build(BuildContext context) {
    final logoPath = "assets/images/book5.png";
    final addLessonButton = OnPressButton("Add lesson", () {
      _lessonsViewModel.addNewLesson();
    }, context);
    List<Widget> widgetList = [addLessonButton];

    return ChangeNotifierProvider.value(
      value: _lessonsViewModel,
      child: Consumer<LessonsViewModel>(
        builder: (context, viewModel, child) => Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(50),
              child: MainAppBar(code: AppbarCode.New(lessonsTitle))),
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
                          Container(
                            width: containerValue,
                            height: containerValue,
                            child: Scrollbar(
                              child: ListView.separated(
                                itemCount: _lessonsViewModel.userLessons.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return new GestureDetector(
                                    onTap: () => {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => NotesView(
                                                  _lessonsViewModel
                                                      .userLessons[index])))
                                    },
                                    child: new Card(
                                      child: new Column(
                                        children: <Widget>[
                                          new Container(
                                            height: 50,
                                            color: colorList[colorCodes[
                                                index % colorCodes.length]],
                                            child: Center(
                                                child: Text(
                                                    '${_lessonsViewModel.userLessons[index].name}')),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        const Divider(),
                              ),
                            ),
                          ),
                          SizedBox(height: height1),
                          widgetList[0],
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
