import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:satsangapp/models/channel_info.dart';
import 'package:satsangapp/models/videos_list.dart';
import 'package:satsangapp/utils/constants.dart';

class Hitapage extends StatefulWidget {
  const Hitapage({Key? key}) : super(key: key);

  @override
  State<Hitapage> createState() => _HitapageState();
}

class _HitapageState extends State<Hitapage> {
  late ChannelInfo _channelInfo;
  // late VideosList _videosList;
  late Item _item;
  late bool _loading;
  late String _playListId;
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

  getVideosList({required String playListId, required String pageToken}) async {
    Map<String, String> parameters = {
      'part': 'snippet',
      'playlistId': playListId,
      'maxResults': '8',
      'pageToken': pageToken,
      'key': Constants.API_KEY,
    };
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    Uri uri = Uri.https(
      'www.googleapis.com',
      '/youtube/v3/playlistItems',
      parameters,
    );
    Response response = await http.get(uri, headers: headers);
    print(response.body);
    Videolists videosList = videolistsFromJson(response.body);
    return videosList;
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
    _playListId = _item.contentDetails.relatedPlaylists.uploads;
    print(_playListId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: ListView(children: [
            Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(
                  Icons.arrow_back,
                  size: 32,
                  color: Colors.black54,
                ),
              ),
            ),
            Align(
                child: Text(
                  _item.snippet.title,
                  style: TextStyle(
                    fontSize: 36,
                  ),
                ),
                alignment: Alignment.topCenter),
            Image(
              image: CachedNetworkImageProvider(
                  _item.snippet.thumbnails.medium.url),
              height: 300,
            ),
            Divider(thickness: 2),
            Text(
              "Description",
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            Divider(thickness: 2),
            Container(
                width: 180,
                height: 110,
                child: ListView(
                  children: [
                    Text(
                      _item.snippet.description,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                )),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue.shade600)),
              onPressed: () {
                getVideosList(
                    playListId: _playListId, pageToken: _nextPageToken);
              },
              child: Padding(
                padding: EdgeInsets.all(14),
                child: Text(
                  'Verify',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ]),
        ));
  }
}
