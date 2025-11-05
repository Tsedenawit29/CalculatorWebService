package com.calculator;

import javax.jws.WebService;
import javax.jws.WebMethod;
import javax.jws.WebParam;

@WebService(serviceName = "CalculatorService")
public class CalcWebService {
    
    @WebMethod(operationName = "add")
    public double add(@WebParam(name = "a") double a, @WebParam(name = "b") double b) {
        return a + b;
    }
    
    @WebMethod(operationName = "subtract")
    public double subtract(@WebParam(name = "a") double a, @WebParam(name = "b") double b) {
        return a - b;
    }
    
    @WebMethod(operationName = "multiply")
    public double multiply(@WebParam(name = "a") double a, @WebParam(name = "b") double b) {
        return a * b;
    }
    
    @WebMethod(operationName = "divide")
    public double divide(@WebParam(name = "a") double a, @WebParam(name = "b") double b) {
        if (b == 0) {
            throw new IllegalArgumentException("ERROR: Cannot divide by zero");
        }
        return a / b;
    }
    
    @WebMethod(operationName = "power")
    public double power(@WebParam(name = "base") double base, @WebParam(name = "exponent") double exponent) {
        return Math.pow(base, exponent);
    }
    
    @WebMethod(operationName = "squareRoot")
    public double squareRoot(@WebParam(name = "number") double number) {
        if (number < 0) {
            throw new IllegalArgumentException("ERROR: Cannot calculate square root of negative number");
        }
        return Math.sqrt(number);
    }
    
    @WebMethod(operationName = "percentage")
    public double percentage(@WebParam(name = "number") double number, @WebParam(name = "percent") double percent) {
        return (number * percent) / 100;
    }
    
    @WebMethod(operationName = "modulo")
    public double modulo(@WebParam(name = "a") double a, @WebParam(name = "b") double b) {
        if (b == 0) {
            throw new IllegalArgumentException("ERROR: Cannot modulo by zero");
        }
        return a % b;
    }
    
    @WebMethod(operationName = "absolute")
    public double absolute(@WebParam(name = "number") double number) {
        return Math.abs(number);
    }
}
