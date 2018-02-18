//
//  GDNavDrawerVC.swift
//  Goods
//
//  Created by Nabanita on 09/12/17.
//  Copyright © 2017 company. All rights reserved.
//

import UIKit


class GDNavDrawerItemCell: UITableViewCell {
    @IBOutlet weak var _titleLabel: UILabel!
}

enum NavDrawerItemType {
    //case home
    case search
    case myCart
    case myAccount
    case settings
}

protocol GDNavDrawerDelegate {
    func didSelectCloseDrawer()
    func didSelectItemType (_ type: NavDrawerItemType)
}
class GDNavDrawerVC: GDBaseVC, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var _tableView: UITableView!
    var delegate: GDNavDrawerDelegate?
    let _cellReuseIdentifier = "GDNavDrawerItemCell"
    let _cellTitles = ["My Cart", "My Account", "Settings"]
    override func viewDidLoad() {
        super.viewDidLoad()
        setColorForTitleViews()
        
        let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(backPressed))
        swipeGestureRecognizer.direction = .left
        _tableView.addGestureRecognizer(swipeGestureRecognizer)
        _tableView.dataSource = self
        _tableView.delegate = self
        _tableView.reloadData()
    }
    
    func backPressed() {
        self.delegate?.didSelectCloseDrawer()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return _cellTitles.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell: GDNavDrawerItemCell = _tableView.dequeueReusableCell(withIdentifier: _cellReuseIdentifier) as! GDNavDrawerItemCell
        cell._titleLabel.text = _cellTitles[indexPath.row]
        cell._titleLabel.textColor = UIColor.colorForHex(GDColor.ThemeColor as NSString)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.delegate?.didSelectItemType(.myCart)
        }
        else if indexPath.row == 1 {
            self.delegate?.didSelectItemType(.myAccount)
        }
        else {
            self.delegate?.didSelectItemType(.settings)
        }
    }
}

