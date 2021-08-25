

import 'package:careerfinder/client/api_client.dart';
import 'package:careerfinder/data/wrapper/Register_wrapper.dart';
import 'package:careerfinder/data/wrapper/all_jobs_wrapper.dart';
import 'package:careerfinder/event/home_page_event.dart';
import 'package:careerfinder/utils/api_response.dart';

class HomePageRepository {
  final ApiClient client = ApiClient();

  Future<AllJobsWrapper> getAllJobsRepo() async {
    print('on register of repo');
    final resultAPI = await client.getRequest("/job/api/all_job/",);
    return AllJobsWrapper.fromJson(apiResponse(resultAPI));
  }
}

