exception DivideByZeroException {
  1: string message
}

struct Pet {
  1: string kind,
  2: string name
}

service CalculatorService {
  string say_hello(1: string name),
  i32 add(1: i32 value1, 2: i32 value2),
  double divide(1: i32 dividend, 2: i32 divisor) throws (1: DivideByZeroException ex),
  void ping(),
  list<string> dwarves(),
  set<Pet> my_pets(),
  i32 age(1: i32 age_min, 2: i32 age_max)
}
