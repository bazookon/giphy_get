import 'package:flutter/material.dart';
import 'package:giphy_get/giphy_get.dart';
import 'package:giphy_get_demo/providers/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
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

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    themeProvider = Provider.of<ThemeProvider>(context);
  }

  @override
  Widget build(BuildContext context) {
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
                    value: Theme.of(context).brightness == Brightness.dark,
                    onChanged: (value) {
                      themeProvider.setCurrentTheme(
                          value ? ThemeMode.dark : ThemeMode.light);
                    })
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Selected GIF",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            currentGif != null
                ? Image.network(
                    currentGif.images.original.webp,
                    headers: {'accept': 'image/*'},
                  )
                : Text("No GIF")
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            GiphyGif gif = await GiphyGet.getGif(
              context: context,
              apiKey: "your API KEY HERE",
              lang: GiphyLanguage.spanish,
            );
            if (gif != null && mounted) {
              setState(() {
                currentGif = gif;
              });
            }
          },
          tooltip: 'Open Sticker',
          child: Icon(Icons.insert_emoticon)), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
