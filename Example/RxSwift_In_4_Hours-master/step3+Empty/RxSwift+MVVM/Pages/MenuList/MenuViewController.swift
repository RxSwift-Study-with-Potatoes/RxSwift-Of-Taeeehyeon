//
//  ViewController.swift
//  RxSwift+MVVM
//
//  Created by iamchiwon on 05/08/2019.
//  Copyright © 2019 iamchiwon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MenuViewController: UIViewController {
    
    // MARK: - Properties
    let viewModel = MenuListViewModel()
    let disposeBag = DisposeBag()
    
    let cellId = "MenuItemTableViewCell"
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Stream 생성
        // - 처음에 UI요소와 뷰모델+옵저버블이랑 연결만 시켜줬는데도 UpdataUI 하는거 없이 자동으로 UI가 업데이트 된다.
        viewModel.menuObservable
            .bind(to: tableView.rx.items(cellIdentifier: cellId,
                                         cellType: MenuItemTableViewCell.self)) { index, item, cell in
                // - item: menu array에서 들고 있었던 아이템 하나
                // - index: indexPath
                // - cell: cell instance
                cell.title.text = item.name
                cell.price.text = "\(item.price)"
                cell.count.text = "\(item.count)"
                
                cell.onChange = { [weak self] increase in
                    self?.viewModel.changeCount(item: item, increase: increase)
                }
            }
            .disposed(by: disposeBag)
        
        viewModel.itemsCount
            .map{ "\($0)"} // 문자열로 변환
            .observeOn(MainScheduler.instance)
            .bind(to: itemCountLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.totalPrice
            .map { $0.currencyKR() }
            .observeOn(MainScheduler.instance)
            .bind(to: totalPrice.rx.text)
            .disposed(by: disposeBag)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let identifier = segue.identifier ?? ""
        if identifier == "OrderViewController",
            let orderVC = segue.destination as? OrderViewController {
            // TODO: pass selected menus
        }
    }

    func showAlert(_ title: String, _ message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertVC, animated: true, completion: nil)
    }
    
    func updateUI() {
//        itemCountLabel.text = "\(viewModel.itemsCount)"
//        totalPrice.text = viewModel.totalPrice.currencyKR()
    }

    // MARK: - InterfaceBuilder Links

    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var itemCountLabel: UILabel!
    @IBOutlet var totalPrice: UILabel!

    @IBAction func onClear() {
        viewModel.clearAllItemSelections()
    }

    @IBAction func onOrder(_ sender: UIButton) {
        // TODO: no selection
        // showAlert("Order Fail", "No Orders")
        // performSegue(withIdentifier: "OrderViewController", sender: nil)
        
        viewModel.onOrder()
    }
}
