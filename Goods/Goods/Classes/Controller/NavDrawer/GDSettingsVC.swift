//
//  GDSettingsVC.swift
//  Goods
//
//  Created by Nabanita on 11/12/17.
//  Copyright © 2017 company. All rights reserved.
//

import UIKit
class GDSettingsItemCell: UITableViewCell {
    @IBOutlet weak var _titleLabel: UILabel!
}
class GDSettingsVC: GDBaseVC, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var _tableView: UITableView!
    let _cellReuseIdentifier = "GDSettingsItemCell"
    let _cellTitles = ["Policy", "Notifications", "Support", "Privacy Policy", "Terms of Services"]

    override func viewDidLoad() {
        super.viewDidLoad()
        setColorForTitleViews()
        // Do any additional setup after loading the view.
        _tableView.dataSource = self
        _tableView.delegate = self
        _tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton){
        let _ = self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return _cellTitles.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell: GDSettingsItemCell = _tableView.dequeueReusableCell(withIdentifier: _cellReuseIdentifier) as! GDSettingsItemCell
        cell._titleLabel.text = _cellTitles[indexPath.row]
        cell._titleLabel.textColor = UIColor.colorForHex(GDColor.ThemeColor as NSString)
        return cell
    }


}
