import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:giphy_get/giphy_get.dart';
import 'package:giphy_get/l10n.dart';
import 'package:giphy_get_demo/providers/theme_provider.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
        create: (ctx) => ThemeProvider(currentTheme: ThemeMode.system))
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Giphy Get Demo',
      theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          useMaterial3: Provider.of<ThemeProvider>(context).material3),
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.purple,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          useMaterial3: Provider.of<ThemeProvider>(context).material3),
      localizationsDelegates: [
        ...GlobalMaterialLocalizations.delegates,
        GlobalWidgetsLocalizations.delegate,
        GiphyGetUILocalizations.delegate
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('es', ''),
        Locale('da', ''),
        Locale('fr', ''),
      ],
      home: const MyHomePage(title: 'Giphy Get Demo'),
      themeMode: Provider.of<ThemeProvider>(context).currentTheme,
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({required this.title, super.key});
  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

  //Gif
  GiphyGif? currentGif;

  // Random ID
  String randomId = "";

  late String giphyApiKey = dotenv.env['GIPHY_API_KEY'] ?? "";

  // Giphy Client
  late GiphyClient client = GiphyClient(apiKey: giphyApiKey, randomId: '');

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      client.getRandomId().then((value) {
        setState(() {
          randomId = value;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (giphyApiKey.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Giphy Get Demo"),
        ),
        body: const Center(
          child: Text(
              "Please set your GIPHY API KEY in the environment variables"),
        ),
      );
    }

    return GiphyGetWrapper(
        giphy_api_key: giphyApiKey,
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
                  const SizedBox(
                    width: 20,
                  ),
                  const Text("GET DEMO")
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Expanded(child: Text("Dark Mode")),
                      Switch(
                          value:
                              Theme.of(context).brightness == Brightness.dark,
                          onChanged: (value) {
                            themeProvider.setCurrentTheme(
                                value ? ThemeMode.dark : ThemeMode.light);
                          })
                    ],
                  ),
                  Row(
                    children: [
                      const Expanded(child: Text("Material 3")),
                      Switch(
                          value: themeProvider.material3,
                          onChanged: (value) {
                            themeProvider.setMaterial3(value);
                          })
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text("Random ID: $randomId"),
                  const Text(
                    "Selected GIF",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  currentGif != null
                      ? SizedBox(
                          child: GiphyGifWidget(
                            imageAlignment: Alignment.center,
                            gif: currentGif!,
                            giphyGetWrapper: giphyGetWrapper,
                            borderRadius: BorderRadius.circular(30),
                            showGiphyLabel: true,
                          ),
                        )
                      : const Text("No GIF")
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                giphyGetWrapper.getGif('', context,
                    showGIFs: true,
                    showStickers: true,
                    showEmojis: true,
                    loadingWidget: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    failedWidget: Container(
                      color: Theme.of(context).cardColor,
                      child: const Center(
                        child: Text("Load Failed"),
                      ),
                    ));
              },
              tooltip: 'Open Sticker',
              child: const Icon(Icons.insert_emoticon),
            ), // This trailing comma makes auto-formatting nicer for build methods.
          );
        });
  }
}
