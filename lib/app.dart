
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:log_page/main.dart';
import 'package:log_page/textform.dart';

class Postapi extends StatelessWidget {
  const Postapi({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController qu = TextEditingController();
    TextEditingController an1 = TextEditingController();
    TextEditingController an2 = TextEditingController();
    TextEditingController an3 = TextEditingController();
    TextEditingController an4 = TextEditingController();
    TextEditingController indexanser = TextEditingController();
    // double sizeWidth = MediaQuery.sizeOf(context).width;
    double sizeheight = MediaQuery.sizeOf(context).height;
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xffAD88c6), Color(0xFFF3BD6B)])),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(height: sizeheight / 7),
              MyTextField(hintText: 'Enter the question', controller: qu),
              MyTextField(hintText: 'Enter the first option', controller: an1),
              MyTextField(hintText: 'Enter the second option', controller: an2),
              MyTextField(hintText: 'Enter the third option', controller: an3),
              MyTextField(hintText: 'Enter the fourth option', controller: an4),
              MyTextField(
                hintText: 'Enter the correct answer number',
                controller: indexanser,
                textInputType: TextInputType.number,
              ),
              SizedBox(height: sizeheight / 7),

ElevatedButton(onPressed:  () async {
                  await addDataToApi({
                    "question": qu.text,
                    "answer": [
                      an1.text,
                      an2.text,
                      an3.text,
                      an4.text,
                    ],
                    "indexOfCorrect": int.tryParse(indexanser.text),
                  });
                  qu.clear();
                  an1.clear();
                  an2.clear();
                  an3.clear();
                  an4.clear();
                  indexanser.clear();

                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NextPage(),
                      ));
                }, child: Text('Send')

              
              ),
              SizedBox(height: sizeheight),
              // ElevatedButton(
              //     onPressed: () async {
              //       await addDataToApi(newData);
              //       qu.clear();
              //       an1.clear();
              //       an2.clear();
              //       an3.clear();
              //       an4.clear();
              //       indexanser.clear();
              //     },
              //     child: const Text('Send'))
            ],
          ),
        ),
      ),
    ));
  }
}

Future<void> addDataToApi(Map<String, dynamic> data) async {
  Dio dio = Dio();

  const String url = ("https://6655e8f93c1d3b60293b8f1c.mockapi.io/quiz");

  final response = await dio.post(url, data: data);

  if (response.statusCode! >= 200 && response.statusCode! <= 210) {
    print('Data added successfully');
  } else {
    print('Failed to add data ------ ${response.statusCode}');
  }
}
