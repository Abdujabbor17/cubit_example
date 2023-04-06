
import 'package:equatable/equatable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../model/post_model.dart';

abstract class PostState extends Equatable{

  @override
  List<Object> get props => [];
}

class PostInit extends PostState{}

class PostLoading extends PostState{

}

class PostLoaded extends PostState{

  final List<PostModel>? posts;

  PostLoaded({this.posts});
}

class PostError extends PostState{
  final error;


  PostError({this.error});
}

