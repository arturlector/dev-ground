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

nextExample(topic: "SubscribeOn + ObserveOn", execute: true) {
    
    let _ = Observable<Int>.create ({ (observer) -> Disposable in
        print("create -> \(Thread.current)")
        observer.onNext(1)
        observer.onNext(2)
        return Disposables.create()
        })
        .subscribeOn(MainScheduler.instance) //отрабатывается только первый subscribeOn (create -> main)
        .observeOn(MainScheduler.instance)
        .map {
            print("map -> \(Thread.current)")
            $0 + 1
        }
        //.subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background)) //это не влияет на create
        .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
        .subscribe({ event in
            print("subscribe -> \(Thread.current)")
            print(event)
        })
}
