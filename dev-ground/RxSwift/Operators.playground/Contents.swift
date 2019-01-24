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

//Трансформируем все полученные item-ы
nextExample(topic: "map", execute: true) {
    
    let bag = DisposeBag()
    let array = [1, 2, 3]
    let _ = Observable<Int>
        .from(array)
        .map { $0 * 2 } //$0 - название item-ы по умолчанию
        .subscribe { event in
            print(event)
        }.disposed(by: bag)
}

nextExample(topic: "filter", execute: true) {
    
    let bag = DisposeBag()
    let array = [1, 2, 3, 4, 5, 6, 7]
    let _ = Observable<Int>
        .from(array)
        .filter { $0 > 2 }
        .subscribe { event in
            print(event)
        }.disposed(by: bag)
}

nextExample(topic: "filter + map", execute: true) {
    
    let bag = DisposeBag()
    let array = [1, 2, 3, 4, 5, 6, 7]
    let _ = Observable<Int>
        .from(array)
        .filter { $0 > 2}
        .map { $0 * 2 }
        .subscribe { event in
            print(event)
        }.disposed(by: bag)
}

//Фильтрующий оператор, пропускает только измененные данные
nextExample(topic: "distinctUntilChanged", execute: true) {
    
    let bag = DisposeBag()
    let array = [1, 1, 1, 1, 1, 2, 2, 2, 3, 4, 5, 5, 5, 5, 6]
    let _ = Observable<Int>
        .from(array)
        .distinctUntilChanged()
        .subscribe { e in
            print(e)
        }.disposed(by: bag)
}

//Берет n-ое количество элементов с конца
nextExample(topic: "takeLast", execute: true) {
    
    let bag = DisposeBag()
    let array = [1, 1, 1, 2, 3, 3, 5, 5, 6]
    let _ = Observable<Int>
        .from(array)
        .takeLast(1)
        .subscribe({ event in
            print(event)
        }).disposed(by: bag)
}

nextExample(topic: "throttle + interval", execute: true) {
    
    let bag = DisposeBag()
    let _ = Observable<Int>
        .interval(0.5, scheduler: MainScheduler.instance) //генерирует item каждые 0.5 секунд c шагом 1
        .throttle(1.0, scheduler: MainScheduler.instance) //берет паузу в 1 секунду между захваторм item-ов
        .subscribe { event in
            print(event)
        }
        //.disposed(by: bag)
}

nextExample(topic: "debounce", execute: true) {
    
    let bag = DisposeBag()
    let _ = Observable<Int>
        .interval(1.5, scheduler: MainScheduler.instance) //генерирует item каждые 0.5 секунд
        .debounce(1.0, scheduler: MainScheduler.instance) //берет паузу в 1 секунду и если изменений небыло - эмитит (кейс: ввод данных с клавиатуры)
        .subscribe({ event in
            print(event)
        })
        //.disposed(by: bag)
}

nextExample(topic: "flatMap", execute: true) {
    
    let seq1 = Observable.of(1, 2)
    let seq2 = Observable.of(1, 2)
    let sequences = Observable.of(seq1, seq2)
    sequences
        .flatMap({ return $0 }) //transform to observable sequence (asObservable)
        .subscribe({ print($0) })
}
