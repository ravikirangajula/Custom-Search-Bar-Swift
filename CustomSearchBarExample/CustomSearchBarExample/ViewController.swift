//
//  ViewController.swift
//  CustomSearchBarExample
//
//  Created by Ravikiran on 02/09/2019.
//  Copyright © 2019 Ravikiran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchView: RKCustomSearchView!
    @IBOutlet weak var tableView: UITableView!
   //private var
    let dataArray = ["Ford", "Arthur", "Trillian", "Zaphod", "Marvin", "Deep Thought", "Eddie", "Slartibartfast", "Humma Kuvula"]
    private var searchArray = [String]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchArray = dataArray
        tableView.register(UINib(nibName: ListTableViewCell.kCell, bundle: nil), forCellReuseIdentifier: ListTableViewCell.kCell)
        searchView.textDidChange = { [weak self] (text) in
            guard let self = self, let text = text else { return }
            self.performAction(text: text)
        }
        //This is to remove empty cells
        self.tableView.tableFooterView = UIView()
        
    }
    
    private func performAction(text: String = "") {
        self.searchArray.removeAll()
        if text.isEmpty {
            self.searchArray.append(contentsOf: self.dataArray)
        } else {
            self.searchArray = self.dataArray.filter({ (item) -> Bool in
                let title = text
                return title.lowercased().contains(text.lowercased())
            })
        }
        self.searchArray = dataArray
            .filter { $0.lowercased().contains(text.lowercased()) }
            .sorted { ($0.lowercased().hasPrefix(text.lowercased()) ? 0 : 1) < ($1.lowercased().hasPrefix(text.lowercased()) ? 0 : 1) }
          self.tableView.reloadData()
   
    }

}


extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.kCell) as? ListTableViewCell {
            cell.dataLabel.text = searchArray[indexPath.row]
            return cell
        }
        return UITableViewCell()
        
    }
    
    
    
}
