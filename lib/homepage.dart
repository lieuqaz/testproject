import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testproject/add_objectives.dart';
import 'package:testproject/item/button_widget.dart';
import 'package:testproject/item/preference.dart';
import 'package:testproject/item/random_string.dart';
import 'package:testproject/item/result_item.dart';

import 'package:testproject/item/form_field_widget.dart';
import 'package:testproject/object_modle.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController object = TextEditingController();
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  int count = 1;
  bool request = false;
  bool cache = false;
  String id = '';
  String getOb = '';
  List<ObjectModel> listResult = [];
  SharedPreferenceUtils preferenceUtils = SharedPreferenceUtils();
  Future<void> getObject() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? ob = prefs.getString('object') ?? '';
    setState(() {
      object.text = ob;
    });
  }

  Future<void> getResult() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final List<dynamic> jsonData =
        jsonDecode(prefs.getString('result') ?? '[]');
    listResult = jsonData.map((e) => ObjectModel.fromJson(e)).toList();
    if (listResult.length > 1) {
      count = listResult.length;
    }
  }

  @override
  void initState() {
    getObject();
    getResult();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Column(
              children: [
                Form(
                  key: globalKey,
                  child: FormFieldWidget(
                    fontStyle: true,
                    padding: false,
                    maxLength: true,
                    maxLines: 4,
                    controller: object,
                    hintText:
                        'Viết các định hướng và mục tiêu quan trọng sẽ đạt được',
                    labelText: 'Objectives',
                  ),
                ),
                Container(
                    padding: const EdgeInsets.only(top: 2, left: 1),
                    color: const Color.fromARGB(255, 211, 221, 230),
                    child: listResult.length > 0
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemBuilder: (context, index) => ResultItem(
                              listOb: listResult,
                              objectModel: count == listResult.length
                                  ? listResult[index]
                                  : ObjectModel(),
                              objectives: object.text,
                              cache: cache,
                              index: index,
                              request: request,
                              id: id,
                            ),
                            itemCount: count,
                            physics: const NeverScrollableScrollPhysics(),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemBuilder: (context, index) => ResultItem(
                              listOb: [],
                              objectModel: ObjectModel(),
                              objectives: object.text,
                              cache: cache,
                              index: index,
                              request: request,
                              id: id,
                            ),
                            itemCount: count,
                            physics: const NeverScrollableScrollPhysics(),
                          )),
                SizedBox(
                    width: double.infinity,
                    child: ButtonWidget(
                        onTap: () {
                          setState(() {
                            count++;
                          });
                        },
                        color: const Color.fromARGB(255, 165, 198, 228),
                        tittle: 'Add a more key result')),
                const SizedBox(
                  height: 20,
                ),
                orientation == Orientation.portrait
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buttonItem('COMFIRM AND SUBMIT OKR'),
                          const SizedBox(
                            height: 20,
                          ),
                          buttonItem('SAVE AS DRAFT'),
                        ],
                      )
                    : Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: buttonItem('COMFIRM AND SUBMIT OKR'),
                          ),
                          const Spacer(),
                          Expanded(
                            flex: 4,
                            child: buttonItem('SAVE AS DRAFT'),
                          )
                        ],
                      ),
              ],
            ),
          ],
        ),
      ),
    ));
  }

  ButtonWidget buttonItem(String tittle) {
    return ButtonWidget(
      color: Colors.white,
      onTap: () async {
        if (globalKey.currentState!.validate()) {
          AddObject addObject = AddObject();
          if (tittle == 'COMFIRM AND SUBMIT OKR') {
            final uid = getRandomString(20);

            await addObject.addObject(object.text, uid);
            setState(() {
              id = uid;
              request = true;
            });
          } else if (tittle == 'SAVE AS DRAFT') {
            setState(() {
              cache = true;
            });
          }
        }
      },
      tittle: tittle,
    );
  }
}
