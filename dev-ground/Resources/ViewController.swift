import UIKit
import RxSwift
import RxCocoa

func nextExample(topic: String, execute: Bool = false ,action: ()->()) {
    if execute {
        print("\n---------- \(topic) ----------")
        action()
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        nextExample(topic: "debounce", execute: true) {
            
            let bag = DisposeBag()
            
            let observable = Observable<Int>.interval(1.5, scheduler: MainScheduler.instance)
            let debounceObservable = observable.debounce(1.0, scheduler: MainScheduler.instance)
            
            debounceObservable.subscribe({ event in
                print(event)
            }).disposed(by: bag)
        }

        nextExample(topic: "create", execute: true) {
            let seq1 = Observable<Any>.of(1, 2, 3)
            let seq2 = Observable<Any>.of("A", "B", "C")
            
            let seq3 = Observable<Any>.from(1)
            let seq4 = Observable<Any>.just(1)
            
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
    }


}

