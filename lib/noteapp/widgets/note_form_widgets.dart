import 'package:flutter/material.dart';

class NoteFormWidget extends StatelessWidget {
  const NoteFormWidget(
    {super.key,
    required this.isImportant,
    required this.number,
    required this.title,
    required this.description,
    required this.onChangeIsImportant,
    required this.onChangeNumber,
    required this.onChangeTitle,
    required this.onChangeDescription,});
    
    final bool isImportant;
    final int number;
    final String title;
    final String description;
    final ValueChanged<bool> onChangeIsImportant;
    final ValueChanged<int> onChangeNumber;
    final ValueChanged<String> onChangeTitle;
    final ValueChanged<String> onChangeDescription;

    @override
    Widget build(BuildContext context) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            children: [
              Row(
                children: [
                  Switch(value: isImportant, onChanged: onChangeIsImportant,),
                  Expanded(
                    child: Slider(
                      value: number.toDouble(),
                      min: 0,
                      max: 5,
                      divisions: 5,
                      onChanged: (value) => onChangeNumber(value.toInt()),
                    )
                  )
                ],
              ),
              buildTitleField(),
              const SizedBox(
                height: 8,
              ),
              buildDescriptionField()
            ]
          ),
        ),
      );
    }

    Widget buildTitleField() {
      return TextFormField(
        maxLines: 1,
        initialValue: title,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Title',
          hintStyle: TextStyle(
            color: Colors.grey,)),
        validator: (title) {
          return title != null && title.isEmpty
              ? 'Silahkan isi kolom judul ini'
              : null;
        },
        onChanged: onChangeTitle,
      );
    }

    Widget buildDescriptionField() {
      return TextFormField(
        maxLines: null,
        initialValue: description,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.normal,
          fontSize: 16,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Description',
          hintStyle: TextStyle(
            color: Colors.grey)),
        validator: (description) {
          return description != null && description.isEmpty
              ? 'Isi kolom ini bray'
              : null;
        },
        onChanged: onChangeDescription,
      );
    }    
}