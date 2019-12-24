import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
      debugShowCheckedModeBanner: false,
      title: 'News',
      theme: ThemeData(
        primarySwatch: Colors.green,
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
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
                      child:Column(
                          children: <Widget>[
                            ListTile(
                            contentPadding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                            title: Text(snapshot.data.articles[index].title, style: TextStyle(fontSize: 20),),
                            subtitle: Text(snapshot.data.articles[index].source.name),
                            ),
                            SizedBox(height: 8,),
                            Center(child: FlatButton.icon(icon: Icon(Icons.launch,color: Colors.green,),onPressed: ()async{
                              final url = snapshot.data.articles[index].url;
                              if (await canLaunch(url)) 
                              {await launch(url);} 
                              else {throw 'Could not launch $url';}
                            },
                           label: Text('Read'),
                          ),
                            ),
                          ],
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Center(child: Container(child: Text("${snapshot.error}")));
              }
              // By default, show a loading spinner.
              return SpinKitHourGlass(color: Colors.red, size: 30,);
            },
          ),
        ),
      ),
    );
  }
}