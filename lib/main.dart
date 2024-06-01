import 'dart:convert';
import 'package:dio/dio.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:log_page/app.dart';
import 'package:log_page/config/get_it_config.dart';

import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  init();
  runApp(MyApp());
}

late double width;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.sizeOf(context).width;

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        // home: LayoutBuilder(builder: (context, screeninfo) {
        //   if (screeninfo.maxWidth < 300) {
        //     return MobileHomePage();
        //   } else {
        //     return TabletHomePage();
        //   }
        // }),
        home: (core.get<SharedPreferences>().getString('name') == null)
            ? LoginScreen()
            : NextPage());
  }
}

class LoginScreen extends StatelessWidget {
  final TextEditingController name = TextEditingController();

  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.sizeOf(context).width / 2;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: MediaQuery.of(context).size.height * -0.04,
              left: MediaQuery.of(context).size.height * 0,
              child: Image.asset(
                'images/img.png',
                height: 350,
                width: 350,
              )),
          Positioned(
              top: MediaQuery.of(context).size.height * -0.01,
              left: MediaQuery.of(context).size.height * 0.06,
              child: Image.asset(
                'images/img_5.png',
                height: 300,
                width: 300,
              )),
          Positioned(
              top: MediaQuery.of(context).size.height * -0.01,
              left: MediaQuery.of(context).size.height * -0.01,
              child: Image.asset(
                'images/img_2.png',
                height: 120,
                width: 120,
              )),
          Positioned(
              top: MediaQuery.of(context).size.height * 0.25,
              left: MediaQuery.of(context).size.height * 0.04,
              child: Image.asset(
                'images/img_4.png',
                height: 50,
                width: 50,
              )),
          Positioned(
              top: MediaQuery.of(context).size.height * 0.08,
              left: MediaQuery.of(context).size.height * 0.43,
              child: Image.asset(
                'images/img_3.png',
                height: 25,
                width: 25,
              )),
          Positioned(
              bottom: MediaQuery.of(context).size.height * 0,
              right: MediaQuery.of(context).size.height * 0,
              child: Image.asset(
                'images/img_6.png',
                height: 100,
                width: 100,
              )),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'LOGIN',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),
                SizedBox(height: 180),
                TextFormField(
                  controller: name,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'user@gmail.com',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        30,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: password,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      core
                          .get<SharedPreferences>()
                          .setString('name', name.text);

                      core
                          .get<SharedPreferences>()
                          .setString('pass', password.text);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NextPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.pinkAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text('LOGIN'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NextPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff7469b6),
        title:
            Text("Hello Mr.${core.get<SharedPreferences>().getString('name')}"),
      ),
      body: FutureBuilder(
        future: getQuiz(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return PageView(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: pageController,
                   physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Scaffold(
                        backgroundColor: Color(0xffAD88c6),
                        body: Padding(
                          padding: const EdgeInsets.all(50.0),
                          child: Column(
                            children: [
                              ListTile(
                                title: Container(
                                    width: 50,
                                    height: 40,
                                    decoration: const BoxDecoration(
                                        color: Color(0xffE1AFD1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Center(
                                        child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(snapshot.data![index].question),
                                    ))),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: snapshot.data![index].answer.length,
                                  itemBuilder: (context, ind) {
                                    return ListTile(
                                      title: InkWell(
                                        onTap: () {
                                          if (ind ==
                                              snapshot
                                                  .data![index].indexOfCorrect) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              duration:
                                                  const Duration(seconds: 1),
                                              content: Text(
                                                "Correct answer",
                                              ),
                                            ));
                
                                            pageController.nextPage(
                                                duration:
                                                    const Duration(seconds: 1),
                                                curve: Curves.decelerate);
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              duration:
                                                  const Duration(seconds: 1),
                                              content: Text("Wrong answer"),
                                            ));
                                          }
                                        },
                
                                        ///////////////////////
                
                                        child: Container(
                                            width: 3,
                                            decoration: BoxDecoration(
                                                color: Color(0xffFFE6E6),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(snapshot
                                                  .data![index].answer[ind]),
                                            )),
                                      ),
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
        
        
        
        
        Postapi()
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

Future<List<QuizModel>> getQuiz() async {
  Dio req = Dio();
  Response response =
      await req.get("https://6655e8f93c1d3b60293b8f1c.mockapi.io/quiz");
  print(response);
  List<QuizModel> quiz = List.generate(
    response.data.length,
    (index) => QuizModel.fromMap(response.data[index]),
  );
  print(quiz);
  return quiz;
}

class QuizModel {
  String question;
  List<String> answer;
  num indexOfCorrect;

  QuizModel({
    required this.question,
    required this.answer,
    required this.indexOfCorrect,
  });

  QuizModel copyWith({
    String? question,
    List<String>? answer,
    num? indexOfCorrect,
  }) {
    return QuizModel(
      question: question ?? this.question,
      answer: answer ?? this.answer,
      indexOfCorrect: indexOfCorrect ?? this.indexOfCorrect,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'question': question,
      'answer': answer,
      'indexOfCorrect': indexOfCorrect,
    };
  }

  factory QuizModel.fromMap(Map<String, dynamic> map) {
    return QuizModel(
      question: map['question'] as String,
      answer: List.generate(
        map['answer'].length,
        (index) => map['answer'][index],
      ),
      indexOfCorrect: map['indexOfCorrect'] as num,
    );
  }

  String toJson() => json.encode(toMap());

  factory QuizModel.fromJson(String source) =>
      QuizModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'QuizModel(question: $question, answer: $answer, indexOfCorrect: $indexOfCorrect)';

  @override
  bool operator ==(covariant QuizModel other) {
    if (identical(this, other)) return true;

    return other.question == question &&
        listEquals(other.answer, answer) &&
        other.indexOfCorrect == indexOfCorrect;
  }

  @override
  int get hashCode =>
      question.hashCode ^ answer.hashCode ^ indexOfCorrect.hashCode;
}


