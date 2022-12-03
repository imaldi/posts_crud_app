import 'package:posts_crud_app/core/error/failures.dart';

String getErrorBasedOnFailureType(Failure failure){
  if(failure is NoInternetFailure) return "Internet Disconnected";
  if(failure is ServerFailure) return "Server Error";
  return "Unknown Error";
}