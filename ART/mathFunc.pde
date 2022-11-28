long fib(long number) {
    if ((number == 0) || (number == 1))
        return number;
    else
        return fib(number - 1) + fib(number - 2);
}

float reciprocal(float number){
    return 3 / number;
}

float parabolic(float number){
    return number * number;
}

float linear(float number){
    return number;
}

