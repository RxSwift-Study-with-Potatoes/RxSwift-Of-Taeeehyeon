//
//  ViewController.swift
//  RxSwift+MVVM
//
//  Created by iamchiwon on 05/08/2019.
//  Copyright © 2019 iamchiwon. All rights reserved.
//

import RxSwift
import SwiftyJSON
import UIKit

let MEMBER_LIST_URL = "https://my.api.mockaroo.com/members_with_avatar.json?key=44ce18f0"

class ViewController: UIViewController {
    
    // MARK: - Properties
    let disposeBag = DisposeBag()
    
    // MARK: - IBOutlets
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var editView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            self?.timerLabel.text = "\(Date().timeIntervalSince1970)"
        }
    }

    private func setVisibleWithAnimation(_ v: UIView?, _ s: Bool) {
        guard let v = v else { return }
        UIView.animate(withDuration: 0.3, animations: { [weak v] in
            v?.isHidden = !s
        }, completion: { [weak self] _ in
            self?.view.layoutIfNeeded()
        })
    }
    
//    func downloadJson(_ url: String, _ completion: ((String?) -> Void)?) {
//        DispatchQueue.global().async {
//            let url = URL(string: MEMBER_LIST_URL)!
//            let data = try! Data(contentsOf: url)
//            let json = String(data: data, encoding: .utf8)
//            DispatchQueue.main.async {
//                completion?(json)
//            }
//        }
//    }
    
    // Observable의 생명주기
    // 1. Create    (Create 됐다고 해서 실행되는건 아님)
    // 2. Subscribe (이 때 옵저버블이 동작함)
    // 3. onNext    (데이터 전달)
    // --- 끝 ---
    // 4. onCompleted / onError (동작이 끝남)
    // 5. Disposed
    // 동작이 끝난 옵저버블은 재사용 불가 (한 번 completed 되거나 error난 녀석들)
    
    func downloadJson(_ url: String) -> Observable<String?> {
        // 1. 비동기로 생기는 데이터를 Observable로 감싸 리턴하는 방법
        return Observable.create() { emitter in
            let url = URL(string: url)!
            let task = URLSession.shared.dataTask(with: url) { (data, _, err) in
                guard err == nil else {
                    emitter.onError(err!)
                    return
                }
                
                if let data = data, let json = String(data: data, encoding: .utf8) {
                    emitter.onNext(json)
                }
                
                emitter.onCompleted()
            }
            
            task.resume()
            
            return Disposables.create() {
                task.cancel()
            }
        }
    }

    // MARK: SYNC

    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    @IBAction func onLoad() {
        
        editView.text = ""
        setVisibleWithAnimation(self.activityIndicator, true)
        
//        let observable = downloadJson(MEMBER_LIST_URL)
//
//        // 옵저버블이 종료되면 클로저도 종료됨, 순환참조가 끊어짐
//        _ = observable.subscribe { event in
//            switch event {
//            case .next(let json):
//                DispatchQueue.main.async {
//                    self.editView.text = json
//                    self.setVisibleWithAnimation(self.activityIndicator, false)
//                }
//            case .completed:
//                break
//            case .error(_):
//                break
//            }
//        }
        
        // sugar API를 이용해서 더 짧게 코드작성가능
        // - observeOn: 스케쥴러 지정
        // - subscribe에서도 원하는 이벤트만 지정해서 클로저 처리
        // - subscribe는 끝나고 나면 diposable을 리턴
        downloadJson(MEMBER_LIST_URL)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { json in
                self.editView.text = json
                self.setVisibleWithAnimation(self.activityIndicator, false)
            })
            .disposed(by: disposeBag)
        
        // Operator 중에서 .zip() 사용
    }
}
