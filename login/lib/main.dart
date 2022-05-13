import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // main 함수에서 async 사용하기 위함
  await Firebase.initializeApp(); // firebase 앱 시작
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthService>().currentUser();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: user == null ? LoginPage() : HomePage(),
    );
  }
}

/// 로그인 페이지
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(
      builder: (context, authService, child) {
        final user = authService.currentUser();
        return Scaffold(
          appBar: AppBar(
            leading: BackButton(color: Colors.grey),
            title: Text(
              "로그인",
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.grey[200],
            elevation: 0.0,
          ),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.grey[200],
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  /// 현재 유저 로그인 상태
                  Center(
                    child: Text(
                      user == null ? "" : "${user.email}님 맥가이버에 오신 것을 환영합니다.",
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ),
                  SizedBox(height: 32),

                  /// 이메일
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                        hintText: "이메일을 입력해주세요.",
                        labelText: "이메일",
                        labelStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        )),
                  ),
                  SizedBox(height: 40),

                  /// 비밀번호
                  TextField(
                    controller: passwordController,
                    obscureText: false, // 비밀번호 안보이게
                    decoration: InputDecoration(
                      hintText: "비밀번호를 입력해주세요.",
                      labelText: "비밀번호",
                      labelStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 230),

                  /// 로그인 버튼
                  ElevatedButton(
                    child: Text("로그인", style: TextStyle(fontSize: 21)),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      // 로그인
                      authService.signIn(
                        email: emailController.text,
                        password: passwordController.text,
                        onSuccess: () {
                          // 로그인 성공
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("로그인 성공"),
                          ));

                          // HomePage로 이동
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        },
                        onError: (err) {
                          // 에러 발생
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(err),
                          ));
                        },
                      );
                    },
                  ),

                  /// 회원가입 버튼
                  ElevatedButton(
                    child: Text("회원가입", style: TextStyle(fontSize: 21)),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      // 회원가입
                      authService.signUp(
                        email: emailController.text,
                        password: passwordController.text,
                        onSuccess: () {
                          // 회원가입 성공
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("회원가입 성공"),
                          ));
                        },
                        onError: (err) {
                          // 에러 발생
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(err),
                          ));
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

/// 홈페이지
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController jobController = TextEditingController();

//위젯
  Widget _information() {
    return Padding(
      padding: const EdgeInsets.all(9.0),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        width: 400,
        height: 100,
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.transparent,
                  backgroundImage: Image.network(
                          "https://image.zdnet.co.kr/2022/03/03/e5c4619a509cbb6dcbd3713a6baee749.png")
                      .image,
                ),
                SizedBox(width: 15),
                _informationTwo()
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _informationTwo() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "한입먹은사과",
            style: const TextStyle(
                fontSize: 17, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Text(
            "ABC@apple.com",
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              _informationThree('수리이력 ', 2),
              SizedBox(width: 15),
              _informationThree('리뷰작성 ', 1),
            ],
          ),
        ],
      ),
    );
  }

  Widget _informationThree(String title, int value) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 13, color: Colors.black),
        ),
        Text(
          value.toString(),
          style: const TextStyle(fontSize: 13, color: Colors.black),
        ),
      ],
    );
  }

  Widget _myApple() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "내 디바이스",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  "+디바이스 추가하기",
                  style: TextStyle(fontSize: 13, color: Colors.blueGrey),
                ),
              ),
            ],
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            "수리하기",
            style: TextStyle(fontSize: 13, color: Colors.blueGrey),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey[200],
        elevation: 0.0,
        title: Text("마이페이지", style: TextStyle(color: Colors.black)),
        actions: [
          TextButton(
            child: Text(
              "로그아웃",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            onPressed: () {
              // 로그아웃
              context.read<AuthService>().signOut();

              // 로그인 페이지로 이동
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.grey[200],
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _information(),
                _myApple(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProblemPage {}
