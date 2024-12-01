import 'dart:math';

String generateRandomPassword(int length) {
  const chars =
      'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!_@#%*.,';
  final random = Random();

  return List.generate(length, (index) => chars[random.nextInt(chars.length)])
      .join();
}

String generateRandomString(int length) {
  const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
  final random = Random();

  return List.generate(length, (index) => chars[random.nextInt(chars.length)])
      .join();
}

String generateRandomNumber(int length) {
  const chars = '0123456789';
  final random = Random();

  return List.generate(length, (index) => chars[random.nextInt(chars.length)])
      .join();
}
