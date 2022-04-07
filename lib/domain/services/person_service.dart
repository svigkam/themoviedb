import 'package:themoviedb/domain/api_client/account_api_client.dart';
import 'package:themoviedb/domain/data_providers/session_data_provider.dart';
import 'package:themoviedb/domain/entity/popular_movie_response.dart';

class PersonService {
  final _accountApiClient = AccountApiClient();
  final _sessionDataProvider = SessionDataProvider();

  Future<PopularMovieResponse> favoriteMovies(String locale) async {

    final accountId = await _sessionDataProvider.getAccountId();
    final sessionId = await _sessionDataProvider.getSessionId();
    return await _accountApiClient.getFavoriteMovies(
      language: locale,
      accountId: accountId.toString(),
      sessionId: sessionId.toString(),
    );
  }
}
