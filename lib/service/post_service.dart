import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../core/api/api.dart';
import '../core/dio/dio_error_exception.dart';
import '../model/post_model.dart';
import 'log_service.dart';

class GetPostService {

  static Future<Either<String,List<PostModel>>> getPosts() async {
    try {
      Response res = await Dio().get(Urls.getPosts);

      Log.i(res.data.toString());
      Log.i(res.statusCode.toString());

      if (res.statusCode == 200) {
        List<PostModel> postList = [];
        for (var e in (res.data as List)) {
          postList.add(PostModel.fromJson(e));
        }
        return right(postList);
      } else {
        Log.e("${res.statusMessage} ${res.statusCode}");
        return left('Something is wrong');
      }
    }on DioError catch (e) {
      Log.e(DioExceptions.fromDioError(e).toString());
      return left(DioExceptions.fromDioError(e).toString());
    } catch (m) {
      Log.e(m.toString());
      return left(m.toString());
    }
  }

  static Future<Either<String,bool>> createPost(PostModel newPost) async {
    try {
      Response res = await Dio().post(
          Urls.addPost, data: {
        "userId": newPost.userId,
        "title": newPost.title,
        "body": newPost.body
      });
      Log.i(res.data.toString());
      Log.i(res.statusCode.toString());

      if (res.statusCode == 200 || res.statusCode == 201) {
        return right(true);
      } else {
        Log.e("${res.statusMessage} ${res.statusCode}");
        return left(res.statusMessage.toString());
      }
    } on DioError catch (e) {

        Log.e(e.response!.toString());
        return left(e.response!.toString());
    } catch (e) {
      Log.e(e.toString());
      return left(e.toString());
    }
  }


  static Future<Either<String,bool>> deletePost(int id) async {
    try {
      Response res = await Dio().delete(Urls.deletePost + id.toString());
      Log.i(res.statusCode.toString());

      if (res.statusCode == 200 || res.statusCode == 201) {
        return right(true);
      } else {
        Log.e("${res.statusMessage} ${res.statusCode}");
        return left(res.statusMessage.toString());
      }
    } on DioError catch (e) {
      Log.e(e.response!.toString());
      return left(e.response!.toString());
    } catch (e) {
      Log.e(e.toString());
      return left(e.toString());
    }
  }
}
