import 'dart:io';

void main() async{
  print("주문 주세요");
  print(await createMyOreder());
}

Future<String> createMyOreder() async{

  var myOrder = await order();
  return "나의 주문은 $myOrder";
}

Future<String> order(){
  return Future.delayed(
    Duration(seconds: 2), () => "큰라떼"
  );
}