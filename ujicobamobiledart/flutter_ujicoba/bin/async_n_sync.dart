import 'dart:async';
void main(List<String> args) {
  print('Synchronous code start');

  Future.delayed(Duration(seconds: 2), () {
    print('Asynchronous code executed after 2 seconds');
  });

  print('Synchronous code end');
}