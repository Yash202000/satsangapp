import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'package:flutter/material.dart';
import 'package:satsangapp/models/channel_info.dart';
import 'package:satsangapp/pages/Hitapage.dart';
import 'package:satsangapp/utils/services.dart';

import '../models/videos_list.dart';
import '../utils/constants.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late ChannelInfo _channelInfo;
  // late VideosList _videosList;
  late Item _item;
  late bool _loading;
  // late String _playListId;
  late String _nextPageToken;
  // late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _loading = true;
    _nextPageToken = '';
    //_scrollController = ScrollController();
    // _videosList = VideosList(
    //     etag: '', kind: '', nextPageToken: '', pageInfo: null, videos: []);
    // _videosList.videos = [];
    getChannelInfo();
  }

  getChannelInfo() async {
    Map<String, String> parameters = {
      'part': 'snippet,contentDetails,statistics',
      'id': 'UC3gnhko-qhwOdUDh_DcZaAw',
      'key': Constants.API_KEY,
    };
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    Uri uri = Uri.https(
      'www.googleapis.com',
      '/youtube/v3/channels',
      parameters,
    );
    Response response = await http.get(uri, headers: headers);
    ChannelInfo channelInfo = channelInfoFromJson(response.body);
    _channelInfo = channelInfo;
    _item = channelInfo.items[0];
  }

  // _loadVideos() async {
  //   VideosList tempVideosList = await Services.getVideosList(
  //     playListId: _playListId,
  //     pageToken: _nextPageToken,
  //   );
  //   _nextPageToken = tempVideosList.nextPageToken;
  //   _videosList.videos.addAll(tempVideosList.videos);
  //   print('videos: ${_videosList.videos.length}');
  //   print('_nextPageToken $_nextPageToken');
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Column(
        children: [
          Card(
              child: Container(
            width: 180,
            height: 180,
            child: Column(
              children: [
                CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(
                      _item.snippet.thumbnails.medium.url),
                  radius: 60,
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  _item.snippet.title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )),
          SizedBox(
            height: 180,
          ),
          Align(
            child: Text(
              'Popular Satsang',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            alignment: Alignment.centerLeft,
          ),
          Row(
            children: [
              Card(
                  child: InkWell(
                onTap: () => {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Hitapage()))
                },
                child: Container(
                  width: 180,
                  height: 180,
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundImage: CachedNetworkImageProvider(
                            _item.snippet.thumbnails.medium.url),
                        radius: 60,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        _item.snippet.title,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              )),
              Card(
                  child: Container(
                width: 180,
                height: 180,
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(
                          _item.snippet.thumbnails.medium.url),
                      radius: 60,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      _item.snippet.title,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ))
            ],
          ),
          SizedBox(
            width: 40,
          ),
          SizedBox(
            width: 70,
            height: 70,
          ),
          Align(
            child: Icon(
              Icons.person_pin,
              size: 70,
              color: Colors.black54,
            ),
            alignment: Alignment.bottomCenter,
          ),
        ],
      )),
    );
  }
}
