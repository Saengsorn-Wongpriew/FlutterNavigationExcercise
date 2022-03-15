import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {

  var curIndex = 0;
  List<Text> questionNum = [
    const Text('Question: 1'),
    const Text('Question: 2'),
    const Text('Question: 3'),
  ];
  List<MyQuestion> questions = [
    MyQuestion(
      questionText: 'What is 2+2?',
      imageEmbed: Image.network('https://www.gif-vif.com/Pizza-skill.gif'),
      choice1: const MyChoice(choiceText: '0', correctChoice: false, colors: Colors.pink,),
      choice2: const MyChoice(choiceText: '22', correctChoice: false, colors: Colors.cyan,),
      choice3: const MyChoice(choiceText: '2', correctChoice: false, colors: Colors.blueGrey,),
      choice4: const MyChoice(choiceText: '4', correctChoice: true, colors: Colors.lime,),
    ),
    MyQuestion(
      questionText: 'What is pi?',
      imageEmbed: Image.network('https://eip.gg/wp-content/uploads/2022/01/ITEM_VegePie.png'),
      choice1: const MyChoice(choiceText: '3.14', correctChoice: true, colors: Colors.pink,),
      choice2: const MyChoice(choiceText: '5', correctChoice: false, colors: Colors.cyan,),
      choice3: const MyChoice(choiceText: '9', correctChoice: false, colors: Colors.blueGrey,),
      choice4: const MyChoice(choiceText: '7', correctChoice: false, colors: Colors.lime,),
    ),
    MyQuestion(
      questionText: 'What is this?',
      imageEmbed: Image.network('https://i.imgur.com/SA9U4u5.jpeg'),
      choice1: const MyChoice(choiceText: 'Mike', correctChoice: false, colors: Colors.pink,),
      choice2: const MyChoice(choiceText: 'May', correctChoice: true, colors: Colors.cyan,),
      choice3: const MyChoice(choiceText: 'Wilson', correctChoice: false, colors: Colors.blueGrey,),
      choice4: const MyChoice(choiceText: 'Popeye', correctChoice: false, colors: Colors.lime,),
    ),
  ];

  Widget nextQuestion(MyQuestion question) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: screenSize.width > 600 ? null: AppBar(title: questionNum[curIndex],),
      body: Column(
        children: [
          question,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Visibility(
                visible: curIndex > 0,
                child: ElevatedButton(
                    onPressed: () => {
                      curIndex -= 1,
                      Navigator.of(context).pop(),
                    },
                    child: const Text('Previous')
                ),
              ),
              Visibility(
                visible: curIndex+1 < questions.length,
                child: ElevatedButton(
                    onPressed: () => {
                      curIndex += 1,
                      Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => nextQuestion(questions[curIndex])
                          )
                      )
                    },
                    child: const Text('Next')
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: screenSize.width > 600 ? null: AppBar(title: questionNum[curIndex],),
      body: Center(
        child: Column(
          children: [
            questions[curIndex],
            ElevatedButton(
                onPressed: () => {
                  curIndex += 1,
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => nextQuestion(questions[curIndex])
                    )
                  )
                },
                child: const Text('Next')
            ),
          ],
        ),
      ),
    );
  }
}

class MyQuestion extends StatelessWidget {
  final String questionText;
  final Image imageEmbed;
  final MyChoice choice1;
  final MyChoice choice2;
  final MyChoice choice3;
  final MyChoice choice4;
  const MyQuestion({Key? key, required this.questionText, required this.imageEmbed, required this.choice1, required this.choice2, required this.choice3, required this.choice4}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const SizedBox(height: 20,),
        Text(
          questionText,
          style: const TextStyle(
              fontSize: 20,
              color: Colors.pink
          ),
        ),
        SizedBox(
          width: screenSize.width > 600 ? 196: 240,
          height: screenSize.width > 600 ? 196: 240,
          child: imageEmbed,
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                choice1,
                screenSize.width > 600 ? const SizedBox(width: 25,): const SizedBox(width: 10,),
                choice2,
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                choice3,
                screenSize.width > 600 ? const SizedBox(width: 25,): const SizedBox(width: 10,),
                choice4,
              ],
            ),
          ],
        )
      ],
    );
  }
}

class MyChoice extends StatefulWidget {
  final bool correctChoice;
  final String choiceText;
  final Color colors;
  const MyChoice({Key? key, required this.choiceText, required this.correctChoice, required this.colors}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MyChoiceState();
  }
}

class _MyChoiceState extends State<MyChoice> {
  late Color myColor;
  void _revealAnswer(correctChoice) {
    setState(() {
      myColor = correctChoice ? Colors.green: Colors.red;
    });
  }

  @override
  void initState() {
    super.initState();
    myColor = widget.colors;
  }

  @override
  Widget build(BuildContext context) {
    // myColor = widget.colors;
    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        width: 150,
        height: 64,
        color: myColor,
        child: Text(
          widget.choiceText,
          style: const TextStyle(
              color: Colors.white
          ),
        ),
      ),
      onTap: () {
        _revealAnswer(widget.correctChoice);
        // log(widget.choiceText);
      },
    );
  }
}
