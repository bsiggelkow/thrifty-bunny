exception DivideByZeroException {
  1: string message
}

service CalculatorService {
  string say_hello(1: string name),
  i32 add(1: i32 value1, 2: i32 value2),
  double divide(1: i32 dividend, 2: i32 divisor)
    throws (1: DivideByZeroException),
  void ping()
}
