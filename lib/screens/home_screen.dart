import 'package:flutter/material.dart';
import 'package:webtoon/services/api_service.dart';
import 'package:webtoon/models/webtoon_model.dart';

import '../widgets/webtoon_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('오늘의 웹툰'),
      ),
      body: FutureBuilder(
        future: webtoons,
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return Column(
              children: [
                const SizedBox(height: 50,),
                Expanded(child: makeList(snapshot),)
              ],
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  ListView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data!.length,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            itemBuilder: (context, index) {
              var webtoon = snapshot.data![index];
              return Webtoon(title: webtoon.title, thumb: webtoon.thumb, id: webtoon.id);
            },
            separatorBuilder: (context, index) => const SizedBox(width: 40,),
          );
  }
}
