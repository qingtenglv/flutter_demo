import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

import 'exception.dart';

enum ViewState {
  idle,
  loading,
  error,
  empty,
  unAuth,
}

enum ErrorType { defaultError, networkError }

class ViewStateError {
  ErrorType errorType;
  String message;
  String errorMessage;

  ViewStateError(this.errorType, {this.message, this.errorMessage}) {
    errorType ??= ErrorType.defaultError;
    message ??= errorMessage;
  }


  get isNetworkError => errorType == ErrorType.networkError;
}

class ViewStateModel extends ChangeNotifier {
  bool _disposed = false;
  ViewState _viewState;
  ViewStateError _viewStateError;

  ViewStateModel({ViewState viewState})
      : _viewState = viewState ?? ViewState.idle;

  get viewState => _viewState;

  set viewState(ViewState state) {
    _viewState = state;
    _viewStateError = null;
    notifyListeners();
  }

  get viewStateError => _viewStateError;

  get errorMessage => _viewStateError?.message;

  bool get isLoading => viewState == ViewState.loading;

  bool get isIdle => viewState == ViewState.idle;

  bool get isError => viewState == ViewState.error;

  bool get isEmpty => viewState == ViewState.empty;

  bool get isUnAuth => viewState == ViewState.unAuth;

  void setIdle() {
    viewState = ViewState.idle;
  }

  void setLoading() {
    viewState = ViewState.loading;
  }

  void setEmpty() {
    viewState = ViewState.empty;
  }

  void setUnAuth() {
    viewState = ViewState.unAuth;
    onUnAuthorizedException();
  }

  void onUnAuthorizedException() {}

  void setError(e, stackTrace, {String msg}) {
    ErrorType errorType = ErrorType.defaultError;
    if (e is DioError) {
      e = e.error;
      if (e is UnAuthException) {
        setUnAuth();
        return;
      } else if (e is FailedException) {
        msg = e.msg;
      } else {
        errorType = ErrorType.networkError;
        msg = "network error";
      }
    }
    viewState = ViewState.error;
    _viewStateError =
        ViewStateError(errorType, message: msg, errorMessage: e.toString());
    if (msg != null) {
      print("error:" + msg);
    } else {
      print("error:" + e.toString());
    }
  }

  showErrorToast(context, {String msg}) {
    if (viewStateError != null || msg != null) {
      if (viewStateError.isNetworkError) {
        msg ??= "network error";
      } else {
        msg ??= viewStateError.msg;
      }
      showToast(msg, context: context);
    }
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
