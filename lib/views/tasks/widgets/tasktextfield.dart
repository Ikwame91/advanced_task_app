import 'package:advanced_taskapp/utils/strings.dart';
import 'package:flutter/material.dart';

class TaskTextField extends StatelessWidget {
  const TaskTextField({
    super.key,
    required this.controller,
    this.isForDescription = false,
    required this.onFieldSubmitted,
    required this.onChanged,
  });

  final TextEditingController controller;
  final bool isForDescription;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: ListTile(
        title: TextFormField(
          maxLines: isForDescription ? 1 : 3,
          cursorHeight: isForDescription ? 60 : null,
          controller: controller,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            prefixIcon: isForDescription
                ? const Icon(Icons.bookmark_border, color: Colors.grey)
                : null,
            border: InputBorder.none,
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade300)),
            hintText: MyString.addNote,
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade300)),
          ),
          onFieldSubmitted:onFieldSubmitted,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
