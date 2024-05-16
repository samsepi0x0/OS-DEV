int callee_function(int argument) {
  return argument;
}

void caller_function() {
  callee_function(0xdec0de);
}

