import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:news/model/news_model.dart';




  String url = 'https://newsapi.org/v2/everything?q=bitcoin&from=2019-11-15&sortBy=publishedAt&apiKey=0033eec1ce834b8f93dbd041496980c9';
  
  
  Future<News> getNews() async{

    final res = await http.get(url);
    if (res.statusCode == 200){
      return News.fromJson(jsonDecode(res.body));
    }
    else{
      throw Exception("You lack internet");   
       }
} 