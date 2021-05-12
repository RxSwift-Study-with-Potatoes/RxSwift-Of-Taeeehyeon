//
//  Menu.swift
//  RxSwift+MVVM
//
//  Created by taehy.k on 2021/05/12.
//  Copyright © 2021 iamchiwon. All rights reserved.
//

import Foundation

// ViewModel
// Model: View를 위한 Model
// 실제로 서버에서 어떻게 오는지 모르는데, 이만큼의 데이터가 넘어온다.
struct Menu {
    var id: Int
    var name: String
    var price: Int
    var count: Int
}
