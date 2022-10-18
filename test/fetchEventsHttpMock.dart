
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http/testing.dart';
//import 'package:mocking/main.dart';
import 'package:CatCultura/data/network/networkApiServices.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:CatCultura/models/Events.dart';



import 'fetchEventsHttpMock.dart';

// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.
@GenerateMocks([http.Client])
void main() async {
  group('getGetApiResponse', () {
    test('returns an Album if the http call completes successfully', () async {
      final client = http.Client();/*MockClient((request)async{
        final mapJson = {'id':123};
        return Response(json.encode(mapJson), 200);
      });*/

      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client
          .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1')))
          .thenAnswer((_) async =>
          http.Response('{"userId": 1, "id": 2, "title": "mock"}', 200));

      expect(client.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1')), isA<Events>());
    });

    /*test('throws an exception if the http call completes with an error', () {
      final client = MockClient((request)async{
        final mapJson = {'id':123};
        return Response(json.encode(mapJson), 200);
      });

      // Use Mockito to return an unsuccessful response when it calls the
      // provided http.Client.
      when(client
          .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      //expect(fetchAlbum(client), throwsException);
    });*/
  });
}