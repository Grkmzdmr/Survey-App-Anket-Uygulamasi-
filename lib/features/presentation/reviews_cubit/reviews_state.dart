part of 'reviews_cubit.dart';



@immutable
abstract class ReviewsState {
  
}

class ReviewsInitial extends ReviewsState {
 



}

class ReviewsLoading extends ReviewsState {

}

class ReviewsError extends ReviewsState {

}


class ReviewsFinished extends ReviewsState{
   //final LoginResponseData loginResponseData;
    final ReviewsResponseData reviewResponseData;

     ReviewsFinished({required this.reviewResponseData});
  
 
}
