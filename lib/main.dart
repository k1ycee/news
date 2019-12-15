import 'dart:async';
import 'package:flutter/material.dart';
import 'package:news/model/news_model.dart';
import 'package:news/model/provider_service.dart';
import 'package:url_launcher/url_launcher.dart';





void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
Future<News> news;

  @override
  void initState() {
    super.initState();
    news = getNews();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('News'),
        ),
        body: Container(
          child: FutureBuilder<News>(
            future: news,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data.articles.length,
                  itemBuilder: (context,index){
                    return ListTile(
                      contentPadding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                      title: Text(snapshot.data.articles[index].title),
                      subtitle: Text(snapshot.data.articles[index].source.name),
                      onTap: ()async{
                        final url = snapshot.data.articles[index].url;
                        if (await canLaunch(url)) 
                        {await launch(url);} 
                        else {throw 'Could not launch $url';}
                      },
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}