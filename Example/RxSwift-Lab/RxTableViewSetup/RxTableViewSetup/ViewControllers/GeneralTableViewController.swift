//
//  GeneralTableViewController.swift
//  RxTableViewSetup
//
//  Created by taehy.k on 2021/05/10.
//

import UIKit

class GeneralTableViewController: UIViewController {
    
    // MARK: - Properties
    let people: [String] = [
        "은영", "지원", "혜령", "태현"
    ]
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension GeneralTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = people[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(people[indexPath.row])클릭↖️")
    }
}
