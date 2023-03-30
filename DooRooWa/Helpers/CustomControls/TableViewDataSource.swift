//
//  TableViewDataSource.swift
//  DooRooWa
//
//  Created by Wve iOS Developer on 3/30/23.
//

import UIKit

class TableViewDataSource<Cell : UITableViewCell, Items>: NSObject, UITableViewDataSource {
    
    typealias ConfigureCellHandler = (Cell, Items, IndexPath) -> Void

    //MARK: - Variables
    
    private var cellIdentifier : String?
    private var arrItems:[Items]?
    private var cellConfigureHandler: ConfigureCellHandler


    //MARK: - View Life Cycle
    
    /// Initial settings when view loads
    init(identifier : String, items : [Items], configureCell : @escaping ConfigureCellHandler) {
        cellIdentifier = identifier
        arrItems =  items
        cellConfigureHandler = configureCell
    }
    
    //MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrItems?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellIdentifier,
              let items = arrItems,
              let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? Cell
        else {
            return UITableViewCell()
        }
        cellConfigureHandler(cell, items[indexPath.row], indexPath)
        return cell
    }
}
