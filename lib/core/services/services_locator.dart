import 'package:cubit_mvvm_clean/core/services/api_service.dart';
import 'package:cubit_mvvm_clean/features/data/data_sources/remote_datasource.dart';
import 'package:cubit_mvvm_clean/features/data/repositories/login_repo_impl.dart';
import 'package:cubit_mvvm_clean/features/data/repositories/questions_repo_impl.dart';
import 'package:cubit_mvvm_clean/features/data/repositories/reviews_repo_impl.dart';
import 'package:cubit_mvvm_clean/features/domain/repositories/loginRepository.dart';
import 'package:cubit_mvvm_clean/features/domain/repositories/questionsRepository.dart';
import 'package:cubit_mvvm_clean/features/domain/repositories/reviewsRepository.dart';
import 'package:cubit_mvvm_clean/features/domain/usecases/login_usecase.dart';
import 'package:cubit_mvvm_clean/features/domain/usecases/questions_usecase.dart';
import 'package:cubit_mvvm_clean/features/domain/usecases/reviews_usecase.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final GetIt instance = GetIt.instance;

void setUpServices() {
  instance.registerSingleton<Dio>(Dio());
  instance.registerSingleton<ApiService>(ApiServiceImpl());
  instance.registerSingleton<RemoteDataSource>(RemoteDataSourceImpl());
  instance.registerSingleton<LoginRepository>(LoginRepoImpl());
  instance.registerSingleton<LoginUseCase>(LoginUseCase());
  instance.registerSingleton<ReviewsRepository>(ReviewsRepoImpl());
  instance.registerSingleton<ReviewsUseCase>(ReviewsUseCase());
  instance.registerSingleton<QuestionsRepository>(QuestionsRepoImpl());
  instance.registerSingleton<QuestionsUseCase>(QuestionsUseCase());

}
