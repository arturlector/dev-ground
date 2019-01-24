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

//Создать observable из одной переменной
nextExample(topic: "just", execute: true) {
    
    let _ = Observable<String>
        .just("Первый observable")
        .subscribe { event in
            print(event)
    }
}
