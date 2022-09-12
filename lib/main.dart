import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './thema/main_thema.dart' as thema;

void main() {
  runApp(
    // provider 사용
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (c)=>Store1()),
          ChangeNotifierProvider(create: (c)=>Store2()),
        ],
        child: MaterialApp(
          home: MyApp(),
          theme: thema.mainThema,
        ),
      )
  );
}

// 마이앱 ------------------------------------------------------------------------
class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  var pageIndex = 0;

  @override
  Widget build(BuildContext context) {

    print(context.read<Store2>().store2);
    return Scaffold(
      appBar: AppBar(),

      body: Center(child: bodyWidget[pageIndex]),

      bottomNavigationBar: BottomNavigationBar(

        //바텀네비게이션바 아이콘 눌렀을때 실행
        onTap: (index){
          context.read<Store1>().changeIndex(index);
          setState(() {
            pageIndex=index;
          });
        },

        //현재 인덱스를 설정
        currentIndex: pageIndex,

        //현재 아이콘의 색상
        selectedItemColor: Colors.green,

        //아이콘 종류
        items: NavigatorItems,
      )
    );
  }
}
//------------------------------------------------------------------------------

// 바텀 네비게이션 아이템
List<BottomNavigationBarItem> NavigatorItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.add),
      label: 'add',
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'home'
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.markunread),
        label: 'massage'
    )
];

// body 페이지
List<Widget> bodyWidget = [
  FirstPage(),
  SecondPage(),
  ThirdPage(),
];

class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(context.read<Store1>().pageIndexNum.toString());
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(context.read<Store2>().store2);
  }
}

class ThirdPage extends StatelessWidget {
  const ThirdPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(context.read<Store1>().pageIndexNum.toString());
  }
}

// provider 저장소
class Store1 extends ChangeNotifier{
  var pageIndexNum=0;
  changeIndex(index){
    pageIndexNum=index+1;
    notifyListeners();
  }
}

class Store2 extends ChangeNotifier{
  var store2='store2';
}











