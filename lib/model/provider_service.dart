import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:news/model/news_model.dart';



   var day = DateTime.now();
   var t = DateFormat.yMd().format(day);
  String url = 'https://newsapi.org/v2/everything?q=bitcoin&from=$t&sortBy=publishedAt&apiKey=0033eec1ce834b8f93dbd041496980c9';
  
  
  Future<News> getNews() async{


    //  var day = DateTime.now();
    //  var t = DateFormat.yMd().format(day);
    //  print(t);

    final res = await http.get(url);
    if (res.statusCode == 200){
      return News.fromJson(jsonDecode(res.body));
    }
    else{
      throw Exception("This app was developed with a development API so if you're not seeing any news the API is expired");   
       }
     
} 