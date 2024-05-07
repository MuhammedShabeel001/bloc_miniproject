import 'package:bloc_project/domain/api/api_calling/api_functions.dart';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EditScreen extends StatelessWidget {
  final int id;
  final int userId;
  final String title;
  final String body;

  EditScreen(
      {super.key,
      required this.id,
      required this.userId,
      required this.title,
      required this.body});

  final _formKey = GlobalKey<FormState>();
  TextEditingController titleCont = TextEditingController();
  TextEditingController bodyCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    titleCont.text = title;
    bodyCont.text = body;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Edit Data',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 8),
            child: TextFormField(
              onChanged: (val) {
                _formKey.currentState!.validate();
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please Enter a Title";
                } else {
                  return null;
                }
              },
              controller: titleCont,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), label: Text("Title")),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 8),
            child: TextFormField(
              maxLines: 5,
              onChanged: (val) {
                _formKey.currentState!.validate();
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please Enter a Body";
                } else {
                  return null;
                }
              },
              controller: bodyCont,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), label: Text("Body")),
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                bool val;
                if (_formKey.currentState!.validate()) {
                  val = await updateData(id, bodyCont.text, titleCont.text);
                  if (val) {
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Updated Successfully'),
                      backgroundColor: Colors.green,
                      behavior: SnackBarBehavior.floating,
                    ));
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pop();
                  } else {
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Something Went Wrong'),
                      backgroundColor: Color.fromARGB(255, 255, 0, 0),
                      behavior: SnackBarBehavior.floating,
                    ));
                  }
                }
              },
              child: const Text('Update'))
        ]),
      ),
    );
  }
}
