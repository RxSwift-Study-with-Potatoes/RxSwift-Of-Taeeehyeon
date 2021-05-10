//
//  RxTableViewController.swift
//  RxTableViewSetup
//
//  Created by taehy.k on 2021/05/10.
//

import UIKit
import RxSwift
import RxCocoa

/*
 우리는 테이블뷰를 구현하기 위해서 항상 Delegate Pattern을 사용했죠.. RxCocoa의 bind 기능을 사용하면 정말 간단하게 테이블뷰를 구현할 수 있습니다..! 👍
 */

class RxTableViewController: UIViewController {
    
    // MARK: - Properties
    let people: [String] = [
        "은영", "지원", "혜령", "태현"
    ]
    let disposeBag = DisposeBag()
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bindTableView()
    }
    
    private func bindTableView() {
        // (사람 정보가 담긴)옵저버블을 UI요소(테이블뷰)에 바인딩한다.
        Observable.of(people)
            .bind(to: tableView.rx.items(
                    cellIdentifier: "cell",
                    cellType: UITableViewCell.self)) { (row, element, cell) in
                cell.textLabel?.text = "\(element)"
            }
            .disposed(by: disposeBag)
        
        // tableView delegate
        // - didSelectRowAt에 해당하는 기능..
        // - 셀 클릭 시 데이터 출력
        tableView.rx
            .modelSelected(String.self)
            .subscribe(onNext: { item in
                print("\(item)")
            })
            .disposed(by: disposeBag)
    }
}
