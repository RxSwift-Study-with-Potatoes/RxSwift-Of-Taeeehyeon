//
//  ViewController.swift
//  RxSwift-Filtering-Operators
//
//  Created by taehy.k on 2021/05/05.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    var disposeBag = DisposeBag()

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Ignore Action (무시하기 ~)

    // ignoreElements()
    // - subscribe 하고 있는 라인에서 어떠한 데이터도 이벤트도 전달받지 못하고 무시된다.
    // -- .next이벤트를 무시한다.
    // - 종료(.completed)나 에러(.error)와 같은 정지 이벤트만 하용된다.
    @IBAction func ignoreElementsTapped(_ sender: Any) {
        let strikes:[String] = ["X", "X", "X"]
        
        Observable.from(strikes)
            .ignoreElements()
            .subscribe(onNext: { _ in
//                print("(event) you're out!")
            }, onCompleted: {
                print("(complete) you're out!")
            })
            .disposed(by: disposeBag)
    }
    
    // elementAt
    // - 특정 요소만 처리하고 싶을 때 사용한다.
    // - 다음 예시에서는 1번째 원소는 스트림에 값이 넘어가는 것을 확인할 수 있다.
    @IBAction func elementAtTapped(_ sender: Any) {
        let strikes:[String] = ["1X", "2X", "3X"]
        
        Observable.from(strikes)
            .element(at: 1)
            .subscribe(onNext : { n in
                print("\(n) You're out!")
            })
            .disposed(by: disposeBag)
    }
    
    // filter()
    // - 말 그대로 데이터를 걸러준다는 느낌이 드는 오퍼레이터
    // - 곰튀김님 4시간 강좌에서 예시 코드 등장
    @IBAction func filterTapped(_ sender: Any) {
        Observable.from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
            // True일때만 값을 밑으로 내려보내고, False일때는 내려보내지 않는다.
            .filter{ $0 % 2 == 0 }
            .subscribe(onNext: { n in
                print(n)
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Skip Action (건너띄기~)
    
    // skip()
    // - 원하는 n개의 요소를 skip하고 싶을 때 사용하는 오퍼레이터
    // - 선착순 3명 제외하고, 나머지 1명은 벌칙을 줄거야
    @IBAction func skipTapped(_ sender: Any) {
        Observable.from(["사람1", "사람2", "사람3", "사람4"])
            .skip(3)
            .subscribe(onNext: {
                print("\($0)는 벌칙준비해라")
            })
            .disposed(by: disposeBag)
    }
    
    // skipWhile() (= .skip(while: _))
    // - filter와 유사
    // - filter와 반대로 검사를 통과하지 못한(False) 요소를 전달!!
    // ‼️ 중요한건 검사를 통과하지 못한 요소 이후부터는 T/F 관계없이 전부 전달
    // - cf) filter는 검사를 통과한(True) 요소만 전달
    @IBAction func skipWhileTapped(_ sender: Any) {
        Observable.of(2,2,3,4,4)
            // 짝수인지 검사하고, 홀수가 나온 순간부터는 전부 전달
            .skip(while: { $0 % 2 == 0 })
            .subscribe(onNext: {
                print($0)
            })
            .disposed(by: disposeBag)
    }
    
    // skipUntil() (= .skip(until: _))
    @IBAction func skipUntilTapped(_ sender: Any) {
        // 옵저버블 2개 생성
        let subject = PublishSubject<String>()
        let trigger = PublishSubject<String>()
        
        subject
            .skip(until: trigger)
            .subscribe(onNext: {
                print($0)
            })
            .disposed(by: disposeBag)
        
        // 여기까지는 다 무시되겠져?
        subject.onNext("A")
        subject.onNext("B")
        
        // skip 종료!
        // 왜냐면 다른 옵저버블이 요소를 emit(방출)했기 때문!
        trigger.onNext("X")
    
        subject.onNext("C")
    }
    
    // take()
    // - skip()이랑 반대되는 개념으로 n번째 요소까지 방출한다.
    // - 앞에 2명나와라
    @IBAction func takeTapped(_ sender: Any) {
        Observable.from(["은영", "지원", "태현", "혜령"])
            .take(2)
            .subscribe(onNext: {
                print("\($0) ✋")
            })
            .disposed(by: disposeBag)
    }
    
    // takeWhile()
    // - 약간 디버깅의 중단점같은 느낌인 것 같아요.
    @IBAction func takeWhileTapped(_ sender: Any) {
        Observable.from(["성공", "성공", "에러", "성공", "성공"])
            .take(while: { $0 != "에러" })
            .subscribe(onNext: {
                print($0)
            })
            .disposed(by: disposeBag)
    }
    
    // enumerated()
    // - 이 친구는 파이썬을 했다면 정말 자주 보았겠지만, 그렇지 않을 수 있으니
    // [a,b,c,d,e]의 배열이 있을 때 요소의 값 뿐만 아니라 인덱스도 같이 참조하고 싶을 때!!
    @IBAction func enumeratedTapped(_ sender: Any) {
        Observable.of(2,2,4,4,6,6)
            .enumerated()
            .take(while: { index, value in
                value % 2 == 0 && index < 3
            })
//            .map { $0.element }
            .subscribe(onNext: {
                print($0)
            })
            .disposed(by: disposeBag)
    }
    
    // takeUntil()
    @IBAction func takeUntilTapped(_ sender: Any) {
        // 옵저버블 2개 생성
        let subject = PublishSubject<String>()
        let trigger = PublishSubject<String>()
        
        subject
            .take(until: trigger)
            .subscribe(onNext: {
                print($0)
            })
            .disposed(by: disposeBag)
        
        // 여기까지는 다 출력되겠죠!>!
        subject.onNext("A")
        subject.onNext("B")
        subject.onNext("B")
        subject.onNext("C")
        
        // take 종료!
        // 왜냐면 다른 옵저버블이 요소를 emit(방출)했기 때문!
        trigger.onNext("X")
    
        subject.onNext("C")
    }
    
    // distinctUntilChanged()
    // - 연달아 이어지는, 중복되는 값을 막아주는 역할을 한다.
    @IBAction func distinctUntilChangedTapped(_ sender: Any) {
        Observable.of("A", "A", "B", "B", "C", "C", "A")
            // 중복제거
            .distinctUntilChanged()
            .subscribe(onNext: {
                print($0)
            })
            .disposed(by: disposeBag)
    }
}

