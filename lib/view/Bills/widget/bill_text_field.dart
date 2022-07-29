import 'package:flutter/material.dart';

class BillTextField extends StatelessWidget {
  const BillTextField({
    Key? key,
    required this.titlecontroller,
    required this.title,
    this.keyType=TextInputType.name
  }) : super(key: key);
  final String title;
  final TextEditingController titlecontroller;
  final TextInputType keyType;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
         Text(
          '$title :',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        Container(
          margin: EdgeInsets.only(right: width / 10, left: width / 12),
          height: height / 15,
          width: width / 1.9,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(12.0),
              ),
              color: Colors.white),
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(left: width / 30),
              child: TextFormField(
                controller: titlecontroller,
                keyboardType: keyType,
                decoration:  InputDecoration.collapsed(
                  hintText: 'Enter the $title..',
                  hintStyle: const TextStyle(
                      fontWeight: FontWeight.w700, color: Colors.black54),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
