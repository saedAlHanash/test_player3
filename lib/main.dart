import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_player/vimeo_pod.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final c1 = TextEditingController(text: 'k7cwH6I8q2X5JHBTkn8');
  final c2 = TextEditingController(
      text: 'bWhwWkwuF2F5bi4IIVdmHDt9ZFwhajxWdDU6KgAKFR0W');
  var loading = false;

  void load() {
    setState(() => loading = true);
    Future.delayed(
      Duration(seconds: 1),
      () {
        setState(() => loading = false);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: MediaQuery.of(context).size,
      // designSize: const Size(14440, 972),
      minTextAdapt: true,

      builder: (context, child) => MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Video id'),
                  controller: c1,
                ),
                SizedBox(height: 30.0),
                TextFormField(
                  decoration: InputDecoration(labelText: 'token'),
                  controller: c2,
                ),
                SizedBox(height: 30.0),
                ElevatedButton(
                  onPressed: () {
                    load();
                  },
                  child: Text('loade'),
                ),
                SizedBox(height: 30.0),
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: loading
                      ? SizedBox(
                          height: 30.0,
                          width: 30.0,
                          child: CircularProgressIndicator(),
                        )
                      : VimeoPod(
                          vimeoId: c1.text,
                          token: c2.text,
                        ),
                ),
              ]),
            ),
          )),
    );
  }
}
