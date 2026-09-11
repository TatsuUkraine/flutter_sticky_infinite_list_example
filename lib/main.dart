import 'dart:async';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:sticky_infinite_list/sticky_infinite_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      routes: {
        SingleChildScrollPage.route: (_) => SingleChildScrollPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final StreamController<Settings> _streamController = StreamController<Settings>.broadcast();
  final ScrollController _scrollController = ScrollController();
  final Settings _settings = Settings();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(widget.title),
    ),
    drawer: Drawer(
      child: SafeArea(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Settings",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            ListTile(
              title: Text("Scroll anchor"),
              trailing: DropdownButton<double>(
                value: _settings.anchor,
                items: const [
                  DropdownMenuItem<double>(
                    value: 0,
                    child: Text("0"),
                  ),
                  DropdownMenuItem<double>(
                    value: .5,
                    child: Text("0.5"),
                  ),
                  DropdownMenuItem<double>(
                    value: 1,
                    child: Text("1"),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _settings.anchor = value ?? 0;
                  });
                },
              ),
            ),
            SwitchListTile(
              title: Text("Render negative infinite list"),
              value: _settings.multiDirection,
              onChanged: (value) {
                setState(() {
                  _settings.multiDirection = value;
                });
              },
            ),
            ListTile(
              title: Text("Max positive number of items"),
              trailing: DropdownButton<int>(
                value: _settings.posCount ?? -1,
                items: [
                  DropdownMenuItem(
                    value: -1,
                    child: Text("Infinite"),
                  ), ...[0, 10, 20, 30, 40].map((value) => DropdownMenuItem(
                        value: value,
                        child: Text(value.toString())
                    )),
                ],
                onChanged: (value) {
                  setState(() {
                    _settings.posCount = value == -1 ? null : value;
                  });
                },
              ),
            ),
            ListTile(
              title: Text("Max negative number of items"),
              trailing: DropdownButton<int>(
                value: _settings.negCount ?? -1,
                items: [
                  DropdownMenuItem(
                    value: -1,
                    child: Text("Infinite"),
                  ), ...[0, 10, 20, 30, 40].map((value) => DropdownMenuItem(
                        value: value,
                        child: Text(value.toString())
                    )),
                ],
                onChanged: (value) {
                  setState(() {
                    _settings.negCount = value == -1 ? null : value;
                  });
                },
              ),
            ),
            SwitchListTile(
              title: Text("Overlay header"),
              value: _settings.overlay,
              onChanged: (value) {
                setState(() {
                  _settings.overlay = value;
                });
              },
            ),
            ListTile(
              title: Text("Header position alignment"),
              trailing: DropdownButton<HeaderPositionAxis>(
                value: _settings.positionAxis,
                items: [
                  DropdownMenuItem(
                    value: HeaderPositionAxis.mainAxis,
                    child: Text("Main axis"),
                  ),
                  DropdownMenuItem(
                    value: HeaderPositionAxis.crossAxis,
                    child: Text("Cross axis"),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _settings.positionAxis = value!;
                  });
                },
              ),
            ),
            ListTile(
              title: Text("Header main axis alignment"),
              trailing: DropdownButton<HeaderMainAxisAlignment>(
                value: _settings.mainAxisAlignment,
                items: [
                  DropdownMenuItem(
                    value: HeaderMainAxisAlignment.start,
                    child: Text("Start"),
                  ),
                  DropdownMenuItem(
                    value: HeaderMainAxisAlignment.end,
                    child: Text("End"),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _settings.mainAxisAlignment = value!;
                  });
                },
              ),
            ),
            ListTile(
              title: Text("Header cross axis alignment"),
              trailing: DropdownButton<HeaderCrossAxisAlignment>(
                value: _settings.crossAxisAlignment,
                items: [
                  DropdownMenuItem(
                    value: HeaderCrossAxisAlignment.start,
                    child: Text("Start"),
                  ),
                  DropdownMenuItem(
                    value: HeaderCrossAxisAlignment.center,
                    child: Text("Center"),
                  ),
                  DropdownMenuItem(
                    value: HeaderCrossAxisAlignment.end,
                    child: Text("End"),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _settings.crossAxisAlignment = value!;
                  });
                },
              ),
            ),
            ListTile(
              title: Text("Scroll direction"),
              trailing: DropdownButton<Axis>(
                value: _settings.scrollDirection,
                items: [
                  DropdownMenuItem(
                    value: Axis.vertical,
                    child: Text("Vertical"),
                  ),
                  DropdownMenuItem(
                    value: Axis.horizontal,
                    child: Text("Horizontal"),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _settings.scrollDirection = value;
                  });
                },
              ),
            ),
            ListTile(
              title: Text("Scroll physics"),
              trailing: DropdownButton<ScrollPhysicsEnum>(
                value: _settings.physicsType,
                items: [
                  DropdownMenuItem(
                    value: ScrollPhysicsEnum.platform,
                    child: Text("Platform"),
                  ),
                  DropdownMenuItem(
                    value: ScrollPhysicsEnum.android,
                    child: Text("Android"),
                  ),
                  DropdownMenuItem(
                    value: ScrollPhysicsEnum.ios,
                    child: Text("iOS"),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _settings.physicsType = value;
                  });
                },
              ),
            ),
            Center(
              child: ElevatedButton(
                  child: Text("Scroll to center"),
                  onPressed: () {
                    _scrollController.animateTo(
                      0,
                      duration: Duration(seconds: 1),
                      curve: Curves.linearToEaseOut,
                    );
                  }
              ),
            ),
            Center(
              child: ElevatedButton(
                  child: Text("Go to single example"),
                  onPressed: () {
                    Navigator.of(context).pushNamed(SingleChildScrollPage.route);
                  }
              ),
            ),
          ],
        ),
      ),
    ),
    body: ScrollWidget(
      settings: _settings,
      scrollController: _scrollController,
      stream: _streamController.stream,
    ),
  );

  @override
  void dispose() {
    super.dispose();

    _streamController.close();
  }
}

class ScrollWidget extends StatelessWidget {
  final Stream<Settings>? stream;
  final ScrollController? scrollController;
  final Settings settings;

  const ScrollWidget({
    super.key,
    this.stream,
    this.scrollController,
    required this.settings,
  });

  @override
  Widget build(BuildContext context) => InfiniteList(
    /// when direction changes dynamically, Flutter
    /// won't rerender scroll completely,
    /// which means that gesture detector on scroll itself
    /// remains from original direction
    key: Key(settings.scrollDirection.toString()),
    scrollDirection: settings.scrollDirection!,
    anchor: settings.anchor,
    controller: scrollController,
    direction: settings.multiDirection ? InfiniteListDirection.multi : InfiniteListDirection.single,
    negChildCount: settings.negCount,
    posChildCount: settings.posCount,
    physics: settings.physics,
    builder: (context, index) {
      final date = DateTime.now().add(
          Duration(
            days: index,
          )
      );

      if (settings.overlay) {
        return InfiniteListItem.overlay(
          mainAxisAlignment: settings.mainAxisAlignment,
          crossAxisAlignment: settings.crossAxisAlignment,
          headerStateBuilder: (context, state) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.orange.withValues(alpha: 1 - state.position),
              ),
              height: 70,
              width: 70,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    date.day.toString(),
                    style: TextStyle(
                      fontSize: 21,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    DateFormat.MMM().format(date),
                    style: TextStyle(
                      height: .7,
                      fontSize: 17,
                      color: Colors.black87,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
            ),
          ),
          contentBuilder: (context) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blueAccent,
              ),
              height: settings.contentHeight,
              width: settings.contentWidth,
              child: Center(
                child: Text(
                  DateFormat.yMMMMd().format(date),
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white
                  ),
                ),
              ),
            ),
          ),
        );
      }

      return InfiniteListItem(
        mainAxisAlignment: settings.mainAxisAlignment,
        crossAxisAlignment: settings.crossAxisAlignment,
        positionAxis: settings.positionAxis,
        headerStateBuilder: (context, state) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.orange.withValues(alpha: 1 - state.position),
            ),
            height: 70,
            width: 70,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  date.day.toString(),
                  style: TextStyle(
                    fontSize: 21,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  DateFormat.MMM().format(date),
                  style: TextStyle(
                    height: .7,
                    fontSize: 17,
                    color: Colors.black87,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
          ),
        ),
        contentBuilder: (context) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.blueAccent,
            ),
            height: settings.contentHeight,
            width: settings.contentWidth,
            child: Center(
              child: Text(
                DateFormat.yMMMMd().format(date),
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white
                ),
              ),
            ),
          ),
        ),
      );
    },
  );

}

enum ScrollPhysicsEnum {
  platform,
  ios,
  android,
}

class Settings {
  int? negCount;
  int? posCount;
  bool multiDirection;
  HeaderMainAxisAlignment mainAxisAlignment;
  HeaderCrossAxisAlignment crossAxisAlignment;
  HeaderPositionAxis positionAxis;
  double anchor;
  Axis? scrollDirection;
  ScrollPhysicsEnum? physicsType;
  bool overlay;

  bool get scrollVertical => scrollDirection == Axis.vertical;

  ScrollPhysics? get physics {
    switch (physicsType) {
      case ScrollPhysicsEnum.android:
        return ClampingScrollPhysics();

      case ScrollPhysicsEnum.ios:
        return BouncingScrollPhysics();

      case ScrollPhysicsEnum.platform:
      case null:
        return null;
    }
  }

  double get contentHeight {
    if (scrollVertical) {
      return 300;
    }

    return double.infinity;
  }

  double get contentWidth {
    if (scrollVertical) {
      return double.infinity;
    }

    return 300;
  }

  Settings({
    this.negCount,
    this.posCount,
    this.mainAxisAlignment = HeaderMainAxisAlignment.start,
    this.crossAxisAlignment = HeaderCrossAxisAlignment.start,
    this.positionAxis = HeaderPositionAxis.mainAxis,
    this.multiDirection = false,
    this.anchor = 0,
    this.scrollDirection = Axis.vertical,
    this.physicsType = ScrollPhysicsEnum.platform,
    this.overlay = false,
  });
}



class SingleChildScrollPage extends StatefulWidget {
  static const String route = "/single-child";

  const SingleChildScrollPage({super.key});

  @override
  _SingleChildScrollPageState createState() => _SingleChildScrollPageState();
}

class _SingleChildScrollPageState extends State<SingleChildScrollPage> {
  static const double _headerHeight = 50;

  final StreamController<StickyState<String>> _headerStream = StreamController<StickyState<String>>.broadcast();
  final StreamController<StickyState<String>> _headerOverlayStream = StreamController<StickyState<String>>.broadcast();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Single element example'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: height,
              color: Colors.lightBlueAccent,
              child: Placeholder(),
            ),
            StickyListItem<String>(
              streamSink: _headerStream.sink,
              header: Container(
                height: _headerHeight,
                width: double.infinity,
                color: Colors.orange,
                child: Center(
                  child: StreamBuilder<StickyState<String>>(
                    stream: _headerStream.stream,
                    builder: (_, snapshot) {
                      if (!snapshot.hasData) {
                        return Container();
                      }

                      final position = (snapshot.data!.position * 100).round();

                      return Text('Positioned relative. Position: $position%');
                    },
                  ),
                ),
              ),
              content: Container(
                height: height,
                color: Colors.blueAccent,
                child: Placeholder(),
              ),
              itemIndex: "single-child",
            ),
            StickyListItem<String>.overlay(
              streamSink: _headerOverlayStream.sink,
              header: Container(
                height: _headerHeight,
                width: double.infinity,
                color: Colors.orange,
                child: Center(
                  child: StreamBuilder<StickyState<String>>(
                    stream: _headerOverlayStream.stream,
                    builder: (_, snapshot) {
                      if (!snapshot.hasData) {
                        return Container();
                      }

                      final position = (snapshot.data!.position * 100).round();

                      return Text('Positioned overlay. Position: $position%');
                    },
                  ),
                ),
              ),
              content: Container(
                height: height,
                color: Colors.lightBlueAccent,
                child: Placeholder(),
              ),
              itemIndex: "single-overlayed-child",
            ),
            Container(
              height: height,
              color: Colors.cyan,
              child: Placeholder(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();

    _headerStream.close();
    _headerOverlayStream.close();
  }
}
