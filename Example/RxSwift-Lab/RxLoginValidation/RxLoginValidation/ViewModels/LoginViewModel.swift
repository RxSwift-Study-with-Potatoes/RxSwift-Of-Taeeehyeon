//
//  LoginViewModel.swift
//  RxLoginValidation
//
//  Created by taehy.k on 2021/05/07.
//

import Foundation
import RxCocoa
import RxSwift

// 비즈니스 로직을 처리
class LoginViewModel {
    
    // MARK: - Properties
    let idPublishSubject = PublishSubject<String>()
    let pwPublishSubject = PublishSubject<String>()
    
    // MARK: - Helpers
    func isValid() -> Observable<Bool> {
        Observable.combineLatest(idPublishSubject.asObservable(), pwPublishSubject.asObservable())
            .map { id, pw in
                return id.count > 3 && pw.count > 3
            }
    }
    
}
