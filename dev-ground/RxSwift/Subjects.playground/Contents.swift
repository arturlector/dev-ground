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

//PublishSubject - эмитит item-ы после подписки
nextExample(topic: "PublishSubject", execute: true) {
    
    let subject = PublishSubject<Int>()
    
    subject.subscribe( { event in
        print("первый[1] подписчик \(event)")
    })
    subject.onNext(1)
    
    _ = subject.subscribe({ event in
        print("второй[2] подписчик \(event)")
    })
    subject.onNext(2)
    subject.onNext(3)
    subject.onNext(4)
}

//ReplaySubject - эмитит последние n-значений
nextExample(topic: "ReplaySubject", execute: true) {
    
    let subject = ReplaySubject<Int>.create(bufferSize: 3)
    
    subject.subscribe({ event in
        print("первый подписчик[1] \(event)")
    })
    subject.onNext(1)
    
    subject.subscribe({ event in
        print("второй подписчик[2] \(event)")
    })
    subject.onNext(2)
    subject.onNext(3)
    subject.onNext(4)
    
    subject.subscribe({ event in
        print("третий подписчик[3] \(event)")
    })
}

//BehaviorSubject - эмитит стартовой значение (или предыдущее значение)
nextExample(topic: "BehaviorSubject", execute: true) {
    
    let subject = BehaviorSubject<Int>(value: 0)
    
    subject.subscribe({ event in
        print("первый подписчик[1] \(event)")
    })
    subject.onNext(1)
    
    subject.subscribe({ event in
        print("\nвторой подписчик[2] \(event)")
    })
    subject.onNext(2)
    subject.onNext(3)
    
    subject.subscribe({ event in
        print("\nтретий подписчик[3] \(event)")
    })
    
    subject.onNext(4)
}
