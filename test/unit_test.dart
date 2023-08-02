import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

class MockClient extends Mock implements http.Client {}

@GenerateMocks([MockClient])
void main() {
  MockClient? mockClient;
  // RepoServices? repoServices;

  setUpAll(() {
    mockClient = MockClient();
    //  repoServices = RepoServices.instance;
  });

  test('getData returns a list of RepoModel', () async {
    final apiUrl = Uri.parse(
        'https://api.github.com/search/repositories?q=created:>2022-04-29&sort=stars&order=desc');

    const response = '''
      {
        "items": [
          {
            "name": "Repo 1",
            "owner": {"login": "User1"},
            "stargazers_count": 100,
            "created_at": "2022-05-01T12:00:00Z"
          },
          {
            "name": "Repo 2",
            "owner": {"login": "User2"},
            "stargazers_count": 200,
            "created_at": "2022-05-02T12:00:00Z"
          }
        ]
      }
    // ''';
    // final res = await mockClient?.get(apiUrl);
    // print(res?.body);
    when(
      mockClient!.get(apiUrl),
    ).thenAnswer((val) async {
      return http.Response(response, 200);
    });

    // expect(result.length, 2);
    // expect(result[0].name, 'Repo 1');
  });
}
