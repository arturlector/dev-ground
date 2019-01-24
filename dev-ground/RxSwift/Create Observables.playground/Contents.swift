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
 Что такое Observable?
 Observable - это основа Rx, которая асинхронно генерирует последовательность неизменяемых данных и позволяет подписаться на нее другим
 
 Observable - это "холодный" тип, тоесть не не "эмитит" item-ы пока на него не подпишутся
 
 Observable существует до тех пор, пока не пошлет сообщение об ошибки (error) или успешном завершении (completed)
 
*/

//Создать observable из одной переменной (из T)
nextExample(topic: "just", execute: true) {
    
    let _ = Observable<String>
        .just("Первый observable")
        .subscribe { event in
            print(event)
        }
}

//Создать observable из variadic переменных
nextExample(topic: "of", execute: true) {
    
    let _ = Observable<Int>
        .of(1, 2, 3, 4, 5, 6)
        .subscribe { event in
            print(event)
        }
}

//Создать observable из массива
nextExample(topic: "from", execute: true) {
    
    let array = [1, 2, 3]
    let _ = Observable<[Int]>
        .from(array)
        .debug()
        .subscribe { event in
            print(event)
        }
}

//Явная отписка
nextExample(topic: "dispose", execute: true) {
    
    let array = [1, 2, 3]
    let observable = Observable<Int>.from(array)
    let subscription = observable.subscribe { event in
        print(event)
    }
    subscription.dispose()
}

//Правильная отписка
nextExample(topic: "DisposeBag", execute: true) {
    
    let bag = DisposeBag() //сумка утилизации
    let array = [1, 2, 3]
    let _ = Observable<Int>
        .from(array)
        .subscribe{ (event) in
            print(event)
        }
        .disposed(by: bag)
}

nextExample(topic: "asObservable", execute: true) {
    
    let variable = Variable<Int>(0) //Variable - deprecated, BehaviorRelay -
    
    variable.asObservable().subscribe({ event in
        print(event)
    })
    variable.value = 1
}

nextExample(topic: "create", execute: true) {
    let seq1 = Observable<Any>.of(1, 2, 3)
    let seq2 = Observable<Any>.of("A", "B", "C")
    
    let multipleSeq = Observable<Observable<Any>>.create{ observer in
        observer.onNext(seq1)
        observer.onNext(seq2)
        return Disposables.create { print("disposed") }
    }
    
    let concatSeq = multipleSeq.concat()
    concatSeq.subscribe({ event in
        print(event)
    })
}

nextExample(topic: "just vs from vs of", execute: true) {
    
    let observableJust = Observable<Int>.just(7)
    observableJust.map({ element in
        print(element)
    })
    
    let observableFrom = Observable<Int>.from([1, 2, 3])
    observableFrom.map({ element in
        print(element)
    })
    
    
    let observableOf = Observable<Int>.of(1, 2, 3)
    observableOf.map({ element in
        print(element)
    })
}

//nextExample(topic: "deferred", execute: true) {
//    var i = 1
//    let justObservable = Observable.just(1)
//    i = 2
//    _ = justObservable.subscribe(onNext: print("i = \($0)"))
//}

nextExample(topic: "deferred", execute: true) {
    var i: Int?
    let justObservable = Observable.from(optional: i)
    i = 2
    //let _ = justObservable.subscribe(onNext: print("i = \($0)"))
    let observable = justObservable.subscribe({ event in
        print("i = \(event)")
    })
    
    var j = 1
    let defferedObservable = Observable.deferred({
        Observable.from([j])
    })
    j = 2
    let _ = defferedObservable.subscribe({ event in
        print("j = \(event)")
    })
}

