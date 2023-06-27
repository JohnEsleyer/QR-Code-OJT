import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    var $ScreenWidth = MediaQuery.of(context).size.width;
    var $ScreenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                color: Colors.blue,
                height: $ScreenWidth * (30 / 100),
                child: Image.asset(
                  'assets/placeholder.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Login',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 30
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: $ScreenWidth * (75/100),
              height: $ScreenHeight * (30/100),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(2.0, 2.0),
                    blurRadius: 3.0,
                    spreadRadius: 0.5
                  )
                ]
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: $ScreenWidth * (70/100),
                    height: $ScreenWidth * (15/100),
                    child: const TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                        label: Text('Username'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: $ScreenWidth * (70/100),
                    height: $ScreenWidth * (15/100),
                    child: const TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(),
                        label: Text('Password'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'Errors', //TODO: Replace for errors
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                    ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: $ScreenWidth * (50/100),
                    child: ElevatedButton(
                      onPressed: () {
                        print("REPLACEME"); //TODO: Replace for functionality
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 18
                        ),
                      )
                    ),
                  )
                ],
              ),
            )
          ],
        )
      ),
    );
  }
}
