import 'dart:io';

import 'package:flutter/material.dart';
import 'package:giphy_get/giphy_get.dart';
import 'package:giphy_get/l10n.dart';
import 'package:giphy_get_demo/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await dotenv.load(fileName: ".env", mergeWith: Platform.environment);
  } catch (e) {
    await dotenv.load(mergeWith: Platform.environment);
    print(e);
  }

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
        create: (ctx) => ThemeProvider(currentTheme: ThemeMode.system))
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Giphy Get Demo',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GiphyGetUILocalizations.delegate
      ],
      supportedLocales: [
        Locale('en', ''),
        Locale('es', ''),
      ],
      home: MyHomePage(title: 'Giphy Get Demo'),
      themeMode: Provider.of<ThemeProvider>(context).currentTheme,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ThemeProvider themeProvider;

  //Gif
  GiphyGif currentGif;

  // Giphy Client
  GiphyClient client;

  // Random ID
  String randomId = "";

  String giphy_api_key = dotenv.env["giphy_api_key"];

  @override
  void initState() {
    super.initState();

    client = GiphyClient(apiKey: giphy_api_key, randomId: '');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      client.getRandomId().then((value) {
        setState(() {
          randomId = value;
        });
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    themeProvider = Provider.of<ThemeProvider>(context);
  }

  @override
  Widget build(BuildContext context) {
    return GiphyGetWrapper(
        giphy_api_key: giphy_api_key,
        builder: (stream, giphyGetWrapper) {
          stream.listen((gif) {
            setState(() {
              currentGif = gif;
            });
          });

          return Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  Image.asset("assets/img/GIPHY Transparent 18px.png"),
                  SizedBox(
                    width: 20,
                  ),
                  Text("GET DEMO")
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: Text("Dark Mode")),
                      Switch(
                          value:
                              Theme.of(context).brightness == Brightness.dark,
                          onChanged: (value) {
                            themeProvider.setCurrentTheme(
                                value ? ThemeMode.dark : ThemeMode.light);
                          })
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Random ID: $randomId"),
                  Text(
                    "Selected GIF",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  currentGif != null
                      ? SizedBox(
                          child: GiphyGifWidget(
                            imageAlignment: Alignment.center,
                            gif: currentGif,
                            giphyGetWrapper: giphyGetWrapper,
                            borderRadius: BorderRadius.circular(30),
                            showGiphyLabel: true,
                          ),
                        )
                      : Text("No GIF")
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
                onPressed: () async {
                  giphyGetWrapper.getGif('', context);
                },
                tooltip: 'Open Sticker',
                child: Icon(Icons
                    .insert_emoticon)), // This trailing comma makes auto-formatting nicer for build methods.
          );
        });
  }
}
