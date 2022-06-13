import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testproject/add_objectives.dart';
import 'package:testproject/item/form_field_widget.dart';
import 'package:testproject/item/preference.dart';
import 'package:testproject/object_modle.dart';

class ResultItem extends StatefulWidget {
  const ResultItem(
      {Key? key,
      required this.objectModel,
      required this.cache,
      required this.index,
      required this.listOb,
      required this.request,
      required this.id,
      required this.objectives})
      : super(key: key);
  final int index;
  final bool request;
  final String objectives;
  final String id;
  final bool cache;
  final ObjectModel objectModel;
  final List<ObjectModel> listOb;
  @override
  State<ResultItem> createState() => _ResultItemState();
}

class _ResultItemState extends State<ResultItem> {
  TextEditingController keyrs = TextEditingController();
  TextEditingController start = TextEditingController();
  TextEditingController target = TextEditingController();
  TextEditingController unit = TextEditingController();
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  DateFormat month = DateFormat.MMMM('en_US');
  String date = DateTime.now().day.toString() +
      "-" +
      DateFormat.MMMM('en_US').format(DateTime.now()) +
      "-" +
      DateTime.now().year.toString();
  List<String> typeofKR = ['Numberic', 'Work milestones', 'Percent', 'Money'];
  List<String> criterias = ['High is the best', 'Low is the best'];
  String type = '';
  String criter = '';
  AddObject addObject = AddObject();
  List<ObjectModel> listResult = [];
  bool load = true;
  SharedPreferenceUtils preferenceUtils = SharedPreferenceUtils();
  ObjectModel? objectModel;
  @override
  void initState() {
    super.initState();

    type = typeofKR[0];
    criter = criterias[0];
    if (widget.objectModel.criteria != null) {
      keyrs.text = widget.objectModel.result!;
      start.text = widget.objectModel.start!;
      target.text = widget.objectModel.target!;
      unit.text = widget.objectModel.unit!;
      type = widget.objectModel.typekr!;
      criter = widget.objectModel.criteria!;
    }
  }

  Future<void> addList() async {
    objectModel = ObjectModel(
        result: keyrs.text,
        typekr: type,
        criteria: criter,
        start: start.text,
        target: target.text,
        unit: unit.text,
        date: date);
    listResult.add(objectModel!);
  }

  void saveObject() {
    preferenceUtils.init(widget.objectives, objectModel, listResult);
  }

  void validate() {
    if (globalKey.currentState!.validate()) {
      // await addObject.addObject(widget.objectives, getRandomString(20));
      addObject.addResult(widget.id, keyrs.text, type, criter, start.text,
          target.text, unit.text, date);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.request) {
      validate();
      preferenceUtils.clear();
    }
    addList();
    print(jsonEncode(listResult));
    if (widget.cache) {
      saveObject();
    }
    final orientation = MediaQuery.of(context).orientation;
    return Column(
      children: [
        Align(
          child: Text('Key result ${widget.index + 1}'),
          alignment: Alignment.bottomLeft,
        ),
        Form(
          key: globalKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: FormFieldWidget(
                    padding: false,
                    fontStyle: true,
                    maxLength: false,
                    maxLines: 4,
                    controller: keyrs,
                    hintText:
                        'Viết các hành động chính yếu để đạt được Objectives ở trên',
                    labelText: ''),
              ),
              const SizedBox(
                height: 30,
              ),
              orientation == Orientation.portrait
                  ? Column(
                      children: [
                        itemDropdown(
                          'Type of KR',
                          typeofKR,
                        ),
                        itemDropdown(
                          'Criterias',
                          criterias,
                        )
                      ],
                    )
                  : Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: itemDropdown(
                              'Type of KR',
                              typeofKR,
                            )),
                        Expanded(
                            flex: 1,
                            child: itemDropdown(
                              'Criterias',
                              criterias,
                            ))
                      ],
                    ),
              const SizedBox(
                height: 30,
              ),
              orientation == Orientation.portrait
                  ? Column(
                      children: [
                        itemFormField('Start', start),
                        itemFormField('Target', target),
                        itemFormField('Unit', unit),
                        itemDate(context)
                      ],
                    )
                  : SizedBox(
                      height: 120,
                      child: Row(
                        children: [
                          Expanded(child: itemFormField('Start', start)),
                          Expanded(child: itemFormField('Target', target)),
                          Expanded(child: itemFormField('Unit', unit)),
                          Expanded(child: itemDate(context))
                        ],
                      ),
                    ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        )
      ],
    );
  }

  Padding itemDate(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 5),
      child: Column(
        children: [
          const Align(
            alignment: Alignment.bottomLeft,
            child: Text('Due date'),
          ),
          Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(width: 1), borderRadius: BorderRadius.zero),
            child: InkWell(
              onTap: () async {
                final newDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(DateTime.now().year - 10),
                    lastDate: DateTime(DateTime.now().year + 10));
                if (newDate == null) return;
                setState(() {
                  date = newDate.day.toString() +
                      "-" +
                      month.format(newDate) +
                      "-" +
                      newDate.year.toString();
                });
              },
              child: Row(
                children: [
                  const Icon(Icons.calendar_view_day_rounded),
                  Text(date)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding itemDropdown(String label, List<String> listobject) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 5, bottom: 5),
      child: Column(
        children: [
          Align(alignment: Alignment.bottomLeft, child: Text(label)),
          Container(
            height: 30,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.zero, border: Border.all(width: 1)),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: listobject == typeofKR ? type : criter,
                items: listobject.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  if (listobject == typeofKR) {
                    setState(() {
                      type = newValue!;
                    });
                  } else {
                    setState(() {
                      criter = newValue!;
                    });
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding itemFormField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: FormFieldWidget(
          padding: true,
          controller: controller,
          hintText: '',
          labelText: label,
          maxLength: false,
          maxLines: 1,
          fontStyle: false),
    );
  }
}
