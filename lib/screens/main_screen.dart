import 'package:flutter/material.dart';
import 'package:flutter_study/config/palette.dart';

class LoginSignUpScreen extends StatefulWidget {
  const LoginSignUpScreen({super.key});

  @override
  State<LoginSignUpScreen> createState() => _LoginSignUpScreenState();
}

class _LoginSignUpScreenState extends State<LoginSignUpScreen> {
  bool isSignupScreen = true;
  final _formkey = GlobalKey<FormState>();

  String userName ="";
  String userEmail ="";
  String userPassword = "";
  void _tryValidation(){
    final isValid = _formkey.currentState!.validate();

    if(isValid){
      _formkey.currentState?.save();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            // 배경
            Positioned(
                top: 0,
                right: 0,
                left: 0,
                child: Container(
                  height: 300,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/red.jpg"), fit: BoxFit.fill)),
                  child: Container(
                      padding: EdgeInsets.only(top: 90, left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                              text: TextSpan(
                                  text: "Welcome",
                                  style: TextStyle(
                                      letterSpacing: 1,
                                      fontSize: 25,
                                      color: Colors.white),
                                  children: [
                                TextSpan(
                                  text:
                                      isSignupScreen ? " to Yummy chat" : " back",
                                  style: TextStyle(
                                      letterSpacing: 1,
                                      fontSize: 25,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )
                              ])),
                          SizedBox(height: 5),
                          Text(
                            "Sign up to continue",
                            style:
                                TextStyle(letterSpacing: 1, color: Colors.white),
                          )
                        ],
                      )),
                )),
            // 텍스트 폼 필드
            AnimatedPositioned(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeIn,
                top: 180,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                  padding: EdgeInsets.all(20),
                  height: isSignupScreen ? 280 : 250,
                  width: MediaQuery.of(context).size.width - 40,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 15,
                            spreadRadius: 5)
                      ]),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isSignupScreen = false;
                                });
                              },
                              child: Column(
                                children: [
                                  Text(
                                    "Login",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: !isSignupScreen
                                            ? Palette.activeColor
                                            : Palette.textColor1),
                                  ),
                                  if (!isSignupScreen)
                                    Container(
                                      margin: EdgeInsets.all(2),
                                      height: 2,
                                      width: 55,
                                      color: Colors.orange,
                                    )
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isSignupScreen = true;
                                });
                              },
                              child: Column(
                                children: [
                                  Text(
                                    "SignUp",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: isSignupScreen
                                            ? Palette.activeColor
                                            : Palette.textColor1),
                                  ),
                                  if (isSignupScreen)
                                    Container(
                                      margin: EdgeInsets.all(2),
                                      height: 2,
                                      width: 55,
                                      color: Colors.orange,
                                    )
                                ],
                              ),
                            )
                          ],
                        ),
                        if (isSignupScreen)
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Form(
                              key: _formkey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    key: ValueKey(1),
                                    validator: (value){
                                      if(value!.isEmpty || value.length < 4){
                                        return "Please enter at least 4 characters";
                                      }
                                    },

                                    onSaved: (value){
                                      userName = value!;
                                    },
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.account_circle,
                                        color: Palette.iconColor,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Palette.textColor1,
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(35))),
                                      hintText: "User name",
                                      hintStyle: TextStyle(
                                          fontSize: 14, color: Palette.textColor1),
                                      contentPadding: EdgeInsets.all(10),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  TextFormField(
                                    key: ValueKey(2),
                                    validator: (value){
                                      if(value!.isEmpty || !value.contains("@")){
                                        return "유효한 이메일 주소를 써주세요";
                                      }
                                    },
                                    onSaved: (value){
                                      userEmail = value!;
                                    },
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.mail,
                                          color: Palette.iconColor,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Palette.textColor1,
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(35))),
                                        hintText: "email",
                                        hintStyle: TextStyle(
                                            fontSize: 14,
                                            color: Palette.textColor1),
                                        contentPadding: EdgeInsets.all(10)),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  TextFormField(
                                    key: ValueKey(3),
                                    validator: (value){
                                      if(value!.isEmpty || value.length < 6){
                                        return "6자리 이상의 글자를 써주세요";
                                      }
                                    },
                                    onSaved: (value){
                                      userPassword = value!;
                                    },
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.password,
                                          color: Palette.iconColor,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Palette.textColor1,
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(35))),
                                        hintText: "password",
                                        hintStyle: TextStyle(
                                            fontSize: 14,
                                            color: Palette.textColor1),
                                        contentPadding: EdgeInsets.all(10)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        if (!isSignupScreen)
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Form(
                              key: _formkey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    key: ValueKey(4),
                                    validator: (value){
                                      if(value!.isEmpty || !value.contains("@")){
                                        return "유효한 이메일 주소를 써주세요";
                                      }
                                    },
                                    onSaved: (value){
                                      userEmail = value!;
                                    },
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.email,
                                          color: Palette.iconColor,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Palette.textColor1,
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(35))),
                                        hintText: "email",
                                        hintStyle: TextStyle(
                                            fontSize: 14,
                                            color: Palette.textColor1),
                                        contentPadding: EdgeInsets.all(10)),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  TextFormField(
                                    key: ValueKey(5),
                                    validator: (value){
                                      if(value!.isEmpty || value.length < 6){
                                        return "6자리 이상의 글자를 써주세요";
                                      }
                                    },
                                    onSaved: (value){
                                      userPassword = value!;
                                    },
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.password,
                                          color: Palette.iconColor,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Palette.textColor1,
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(35))),
                                        hintText: "password",
                                        hintStyle: TextStyle(
                                            fontSize: 14,
                                            color: Palette.textColor1),
                                        contentPadding: EdgeInsets.all(10)),
                                  ),
                                ],
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
                )),
            // 전송 버튼
            AnimatedPositioned(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeIn,
                top: isSignupScreen ? 430 : 390,
                right: 0,
                left: 0,
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(15),
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50)),
                    child: GestureDetector(
                      onTap: (){
                        _tryValidation();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Colors.orange, Colors.red],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight),
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: Offset(0, 1))
                            ]),
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )),
            // 구글 로그인 버튼
            AnimatedPositioned(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeIn,
                top: isSignupScreen ? MediaQuery.of(context).size.height - 125 : MediaQuery.of(context).size.height - 165,
                right: 0,
                left: 0,
                child: Column(
                  children: [
                    Text(isSignupScreen ? "or Signup with," : "or Signin with"),
                    SizedBox(
                      height: 10,
                    ),
                    TextButton.icon(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            minimumSize: Size(155, 40),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            backgroundColor: Palette.googleColor),
                        icon: Icon(Icons.add),
                        label: Text("Google"))
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
