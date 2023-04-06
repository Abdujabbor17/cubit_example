import 'package:bloc/bloc.dart';
import 'package:bloc_example/bloc/post_state.dart';
import 'package:bloc_example/service/post_service.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit() : super(PostInit());

  void getPosts() async {
    emit(PostLoading());
    final response = await GetPostService.getPosts();

    response.fold((l) {
      emit(PostError(error: l));
     // EasyLoading.showError(l);
    }, (r) {
      emit(PostLoaded(posts: r));
    });
  }

  void deletePost(int id) async {
    emit(PostLoading());
    final response = await GetPostService.deletePost(id);

    response.fold((l) {
      //EasyLoading.showError(l);
      emit(PostError(error: l));
    }, (r) {
      EasyLoading.showSuccess('Successfully deleted');
      getPosts();
    });
  }
}
