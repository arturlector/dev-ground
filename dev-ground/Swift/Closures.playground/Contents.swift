import UIKit
import RxSwift
import RxCocoa
import PlaygroundSupport
import XCPlayground

PlaygroundPage.current.needsIndefiniteExecution = true

func nextExample(topic: String, execute: Bool = false ,action: ()->()) {
    if execute {
        print("\n---------- \(topic) ----------")
        action()
    }
}

/*
 Closure -> Замыкание -> Анонимные функции (блоки кода с определенным функционалом)
 
 Блок команд в С или Objective-C.
 
 Closure - это блок команд который может иметь параметры и вид возврата
 block: () -> () = {}
 
 Closure - анонимная функция
 
 Синтаксис Closure:
 { (parameters) -> returntype in
    //statements
 }
 
 Closure:
 var myClosure = { (a: Int, b: Int) -> Int in
    return a + b
 }
 var value = myClosure(1, 2)
 
 Function:
 func sum(a: Int, b: Int) -> Int {
    return a+ b
 }
 var value = sum(1, 2)
 
 }
*/

nextExample(topic: "Basic Closures", execute: true) {
    
    let myVar1: () -> () = {
        print("Hello from Closure 1")
    }
    myVar1()
    
    let myVar2: () -> (String) = { () -> (String) in
        return "Hello from Closure 2"
    }
    print(myVar2())
    
    let myVar3: (Int, Int) -> (Int) = { (a: Int, b: Int) -> (Int) in
        let c: Int = a + b
        return c
    }
    print("Hello from Closure 3 -> \(myVar3(1, 2))")
    
}

nextExample(topic: "Anonymous closure arguments/parameters", execute: true) {
    
    //Анонимные параметры используются только в анонимных кложурах
    let anonymousClosure: (String, String) -> (String) = {
        // $0 - первый анонимный параметр
        // $1 - второй анонимный параметр
        return $0 + $1
    }
    print(anonymousClosure("easy", "peasy"))
    
}

nextExample(topic: "Implicit return value", execute: true) {
    
    let closureWithReturn = { (a: Int, b: Int) -> Int in
        return a + b
    }
    print(closureWithReturn(1, 2))
    
    let closureWithoutReturn = { (a: Int, b: Int) -> Int in
        a + b //Если выражение единственное (expression) можно пропустить ключевое слово 'return'
    }
    print(closureWithoutReturn(1, 2))
}

nextExample(topic: "Simplify closure", execute: true) {
    
    //let noParameterNoReturn: () -> () = { () -> Void in print("Something!") }
    let noParameterNoReturn = {
        print("Told you I return nothing")
    }
    noParameterNoReturn()
    
    let _ = {
        print("Nothing return but call now")
    }()
}

nextExample(topic: "Capture values", execute: true) {
   
    //Closures can capture values
    var number = 0
    let addOne = { number += 1 }
    let printNumber = { print(number) }
    
    printNumber() // -> 0
    addOne()
    printNumber() // -> 1
    addOne()
    addOne()
    addOne()
    addOne()
    addOne()
    addOne() // 7
    print(number)
    printNumber()
}

nextExample(topic: "Closures are reference types", execute: true) {
    
    let double: (Int) -> (Int) = { x in
        return 2 * x
    }
    print(double(2))
    
    let alsoDouble = double //same address
    print(alsoDouble(3))
}

nextExample(topic: "Higher order function", execute: true) {
    
    //Higher order function - does at least one of the following:
    //1. takes a function as input
    //2. outputs a function
    
    let numbers = [1, 2, 3]
    let strings = numbers.map { "\($0)" }
    print(strings)
}

nextExample(topic: "Trailing function", execute: true) {
    
    //Trailing closure - closure as the final parameter
    func sum(from: Int, to: Int, closure: (Int) -> (Int)) -> Int {
        var sum = 0
        for i in from...to {
            sum += closure(i)
        }
        return sum
    }
    
    print(sum(from: 0, to: 10, closure: { $0 * 10 })) //Trailing closure
    print(sum(from: 0, to: 10) { $0 * 10 }) //Trailing closure (short version)
}

nextExample(topic: "Capture List", execute: true) {
    
    var a = 0
    var b = 0
    
    let newClosure: () -> () = { print(a, b) } //Type explicitly stated
    let closure = { print(a, b) } //Type inferred (предпологаемый)
    let smartClosure: () -> () = { [a, b] in print(a, b) } //CAPTURE LIST
    
    newClosure()
    closure()
    
    a = 6
    b = 9
    closure()
    
    a = 1
    b = 2
    smartClosure()
}

nextExample(topic: "Escaping closure", execute: true) {
    
    var number = 10
    var add: (Int) -> Int = { otherNumber in return number + otherNumber }
    
    func multiply(someNumber: Int, completion: @escaping (Int) -> Int) {
        completion(someNumber) * 10
    }
    
    multiply(someNumber: 65, completion: add)
}

nextExample(topic: "Capture List with struct", execute: true) {
    
    struct Calculator {
        var a: Int
        var b: Int
        //calculated property
        var sum: Int {
            return a + b
        }
    }
    
    let calculator = Calculator(a: 3, b: 5)
    
    let closure = { [calculator] in
        print("The result is \(calculator.sum)")
    }
    closure()
}

nextExample(topic: "Solve retain cycle in closures", execute: true) {
    
    class Obj {
        func doSomething() { print("doSomething") }
    }
    
    class SomeClass {
        
        var obj = Obj()
        var closure: (() -> ())?
        
        init(obj: Obj) {
            self.obj = obj
        }
        
        func someFunction() {
            closure = { [weak self] in                      // weak self in capture list
                guard let strongSelf = self else { return } // strong self to weak
                strongSelf.obj.doSomething
            }
            closure!()
        }
    }
}

//https://www.programiz.com/swift-programming/closures


