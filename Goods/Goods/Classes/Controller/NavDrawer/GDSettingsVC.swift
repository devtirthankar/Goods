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
    var _cellTitles = ["Policy".translate, "Notifications".translate, "Support".translate, "Privacy Policy".translate, "Terms of Services".translate]

    override func viewDidLoad() {
        super.viewDidLoad()
        setColorForTitleViews()
        setFlipViewForLanguage()
        decideChangeLanguageOption()
        // Do any additional setup after loading the view.
        _tableView.dataSource = self
        _tableView.delegate = self
        _tableView.reloadData()
    }
    
    func decideChangeLanguageOption() {
        if GDUtilities.isPreferredLanguageArabic() {
            _cellTitles.append("Change language to English".translate)
        }
        else {
            _cellTitles.append("Change language to Arabic".translate)
        }
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if indexPath.row == _cellTitles.count-1 {
            changeLanguage()
        }
    }
    
    func changeLanguage() {
        let actionSheet = UIAlertController(title: NSLocalizedString("App restart required", comment: "App restart required"), message: NSLocalizedString("In order to change the language, the App must be closed and reopened by you.", comment: "In order to change the language, the App must be closed and reopened by you."), preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: "Cancel"), style: .cancel, handler: { action in
            self.dismiss(animated: true) {
            }
        }))
        
        var lang = ""
        let preferredLanguage = NSLocale.preferredLanguages[0]
        if preferredLanguage == "en" {
            lang = "ar"
        } else if preferredLanguage == "ar" {
            lang = "en"
        }
        actionSheet.addAction(UIAlertAction(title: NSLocalizedString("Restart", comment: "Restart"), style: .destructive, handler: { action in
            UserDefaults.standard.set([lang], forKey: "AppleLanguages")
            UserDefaults.standard.synchronize()
            exit(EXIT_SUCCESS)
        }))
        present(actionSheet, animated: true)
    }

}
