//
//  MenuListViewModel.swift
//  RxSwift+MVVM
//
//  Created by taehy.k on 2021/05/12.
//  Copyright © 2021 iamchiwon. All rights reserved.
//

import Foundation
import RxSwift

// 데이터를 뷰 컨트롤러에 넣지 말자 -> 따로 빼자
class MenuListViewModel {
    
    // - PublishSubject 대신 BehaviorSubject를 사용해야하는 이유
    var menuObservable = BehaviorSubject<[Menu]>(value: [])
    
    // - [] lazy 써주는 이유?
    // - reduce(): 모든 이벤트를 다 더한 총합을 방출
    lazy var itemsCount = menuObservable.map {
        $0.map { $0.count }.reduce(0, +)
    }
    
    lazy var totalPrice = menuObservable.map {
        $0.map { $0.price * $0.count }.reduce(0, +)
    }
    
    init() {
        APIService.fetchAllMenusRx()
            .map { data -> [MenuItem] in
                struct Response: Decodable {
                    let menus: [MenuItem]
                }
                let response = try! JSONDecoder().decode(Response.self, from: data)
                
                return response.menus
            }
            .map { menuItems -> [Menu] in
                menuItems.map { Menu.fromMenuItems(id: 0, item: $0) }
            }
            .take(1)
            .bind(to: menuObservable)
 
    }
    
    func onOrder() {
        
    }
    
    func clearAllItemSelections() {
        menuObservable.map { menus in
            menus.map { m in
                Menu(id: m.id,
                     name: m.name,
                     price: m.price,
                     count: 0)
            }
        }
        .take(1) // 한번만 수행할거야
        .subscribe(onNext: {
            self.menuObservable.onNext($0)
        })
    }
   
    func changeCount(item: Menu, increase: Int) {
        menuObservable.map { menus in
            menus.map { m in
                if m.id == item.id {
                    return Menu(id: m.id,
                                name: m.name,
                                price: m.price,
                                count: max(m.count + increase, 0)) // 와,, 이 생각을 왜 못했지??
                } else {
                    return Menu(id: m.id,
                                name: m.name,
                                price: m.price,
                                count: m.count)
                }
            }
        }
        .take(1) // 한번만 수행할거야
        .subscribe(onNext: {
            self.menuObservable.onNext($0)
        })
    }

}
