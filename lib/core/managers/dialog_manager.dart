import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:intl/intl.dart';
import 'package:todoist/core/services/dialog/dialog_service.dart';

import '../../locator.dart';

class DialogManager extends StatefulWidget {
  final Widget child;
  const DialogManager({Key key, this.child}) : super(key: key);
  @override
  _DialogManagerState createState() => _DialogManagerState();
}

class _DialogManagerState extends State<DialogManager> {
  final _dialogService = locator<DialogService>();
  final _formKey = GlobalKey<FormState>();
  var data = <String, dynamic>{};
  final time_format = DateFormat("HH:mm a");
  final date_format = DateFormat("yyyy-MM-dd");
  var time = "";
  var date = "";

  @override
  void initState() {
    super.initState();
    _dialogService.registerDialogListener(_showDialog);
    _dialogService.registerDialogListener(_showModalSheet);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void _showDialog(String type) {
    showDialog(
        context: context,
        builder: (context) => WillPopScope(
              onWillPop: () async {
                _dialogService.dialogComplete({});
                return false;
              },
              child: getDialog(type, _formKey),
            ));
  }

  void _showModalSheet(String type) {
    showPlatformModalSheet(
        androidShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        androidIsScrollControlled: true,
        androidBackgroundColor: Colors.transparent,
        context: context,
        builder: (context) => WillPopScope(
              onWillPop: () async {
                _dialogService.dialogComplete({});
                return false;
              },
              child: Container(
                margin:
                    const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Form(
                      key: _formKey,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8.0),
                                topRight: Radius.circular(8.0)),
                            color: Colors.white),
                        padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.only(
                                  left: 16.0, right: 16.0),
                              margin: const EdgeInsets.only(
                                  left: 16.0, right: 16.0, top: 12.0),
                              decoration: BoxDecoration(
                                  color: Color(0xfff3f3f4),
                                  borderRadius: BorderRadius.circular(12.0)),
                              child: TextFormField(
                                decoration: InputDecoration.collapsed(
                                  hintText: "Your awesome title",
                                ),
                                autofocus: true,
                                onSaved: (String v) {
                                  data['title'] = v;
                                },
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                  left: 16.0, right: 16.0),
                              margin: const EdgeInsets.only(
                                  left: 16.0, right: 16.0, top: 12.0),
                              decoration: BoxDecoration(
                                  color: Color(0xfff3f3f4),
                                  borderRadius: BorderRadius.circular(12.0)),
                              child: TextFormField(
                                decoration: InputDecoration.collapsed(
                                  hintText: "Description",
                                ),
                                autofocus: true,
                                onSaved: (String v) {
                                  data['description'] = v;
                                },
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(16.0),
                                    margin: const EdgeInsets.only(
                                        left: 16.0, top: 12.0),
                                    decoration: BoxDecoration(
                                        color: Color(0xfff3f3f4),
                                        borderRadius:
                                            BorderRadius.circular(12.0)),
                                    child: GestureDetector(
                                      onTap:() async{
                                        final cdate = await showDatePicker(
                                          context: context,
                                          initialDate:DateTime.now(),
                                          firstDate: DateTime(1900),
                                          lastDate: DateTime(2100)
                                        );
                                          
                                        setState(() {
                                          final month = cdate.month < 10 ? "0${cdate.month}" : cdate.month;
                                          date = "${cdate.day}-$month-${cdate.year}";
                                          data['date'] = date;
                                        });
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: <Widget>[
                                          Icon(Icons.calendar_today),
                                          const SizedBox(width: 8),
                                          Text('Date:'),
                                          Spacer(),
                                          Text('${date}')
                                        ],
                                      ),
                                    ),        
                                    // child: DateTimeField(
                                    //   format: date_format,
                                    //   onShowPicker: (context, currentValue) {
                                    //     return showDatePicker(
                                    //         context: context,
                                    //         initialDate:
                                    //             currentValue ?? DateTime.now(),
                                    //         firstDate: DateTime(1900),
                                    //         lastDate: DateTime(2100));
                                    //   },
                                    //   onSaved: (DateTime v) {
                                    //     data['date'] =
                                    //         "${v.year}-${v.month}-${v.day}";
                                    //   },
                                    //   decoration: InputDecoration.collapsed(
                                    //     hintText: "Date",
                                    //   ),
                                    // ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8.0,
                                ),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(16.0),
                                    margin: const EdgeInsets.only(
                                        right: 16.0, top: 12.0),
                                    decoration: BoxDecoration(
                                        color: Color(0xfff3f3f4),
                                        borderRadius:
                                            BorderRadius.circular(12.0)),
                                    child: GestureDetector(
                                      onTap:() async{
                                        final ctime = await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.fromDateTime(DateTime.now()),
                                        );
                                        setState(() {
                                          time = time_format.format(DateTimeField.convert(ctime));
                                          data['time'] = time;
                                        });
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: <Widget>[
                                          Icon(Icons.access_time),
                                          const SizedBox(width: 8),
                                          Text('Time:'),
                                          Spacer(),
                                          Text('${time}')
                                        ],
                                      ),
                                    ),
                                    // child: DateTimeField(
                                    //   format: time_format,
                                    //   onShowPicker:
                                    //       (context, currentValue) async {
                                    //     final time = await showTimePicker(
                                    //       context: context,
                                    //       initialTime: TimeOfDay.fromDateTime(
                                    //           currentValue ?? DateTime.now()),
                                    //     );
                                    //     return DateTimeField.convert(time);
                                    //   },
                                    //   onSaved: (DateTime t) {
                                    //     data['time'] =
                                    //         "${t.hour}-${t.minute}-${t.second}";
                                    //   },
                                    //   decoration: InputDecoration.collapsed(
                                    //       hintText: "Time"),
                                    // ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: GestureDetector(
                        onTap: () {
                          _formKey.currentState.save();
                          setState(() {
                            time="";
                            date="";
                          });
                          _dialogService.dialogComplete(data);
                        },
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(8.0),
                                  bottomRight: Radius.circular(8.0)),
                              color: Colors.blueGrey,
                            ),
                            padding: const EdgeInsets.all(16.0),
                            child: Center(
                                child: Text(
                              "SAVE",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800),
                            ))),
                      ),
                    )
                  ],
                ),
                // child: Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   mainAxisSize: MainAxisSize.max,
                //   children: <Widget>[
                //     IconButton(
                //       icon: Icon(Icons.account_circle),
                //       onPressed: () {},
                //     ),
                //     Column(
                //         mainAxisSize: MainAxisSize.min,
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: <Widget>[
                //           const SizedBox(height: 8,),
                //           IconButton(
                //             icon: Icon(Icons.add_shopping_cart),
                //             onPressed: () {},
                //           ),

                //         ]),
                //     IconButton(
                //       icon: Icon(Icons.more_horiz),
                //       onPressed: () {},
                //     ),
                //   ],
                // ),
              ),
            ));
  }

  Widget getDialog(dialogType, formKey) {
    switch (dialogType) {
      case "simple":
        {
          return getSimpleDialog(formKey);
        }
        break;
      default:
        {
          return PlatformAlertDialog();
        }
        break;
    }
  }

  // Simple Dialog
  Widget getSimpleDialog(formKey) {
    return PlatformAlertDialog(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {},
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.account_circle),
                onPressed: () {},
              ),
              SizedBox(
                height: 8,
              ),

              // SizedBox(
              //   height:48,
              //   child: TextFormField(
              //     decoration: InputDecoration(
              //       border: OutlineInputBorder()
              //     ),
              //   ),
              // )
            ],
          ),
          IconButton(
            icon: Icon(Icons.more_horiz),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
