//
//  GDProductVC.swift
//  Goods
//
//  Created by Nabanita on 10/12/17.
//  Copyright © 2017 company. All rights reserved.
//

import UIKit

class GDProductVC: GDBaseVC {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descriptionLabel2: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setColorForTitleViews()
        
        descriptionLabel.text = "One of the finest places to dine A book shop that would give you the word of information. The store has provision for people to sit there and read books and you can buy if you like a few. You get varities of fruits and veggies copared to other shops and the freshness of the products would make you a loyal customer in no time. The best jeweller who provides attractive discounts and EMI options as well. The best branded paints and painting services. One of the finest places to dine. A book shop that would give you the word of information. The store has provision for people to sit there and read books and you can buy if you like a few. You get varities of fruits and veggies copared to other shops and the freshness of the products would make you a loyal customer in no time."
        
        descriptionLabel2.text = "d dcidc cdhcd dciuhdc cuhdmcuidc diuchdmic diuhcdjc duhmdc dviufhvmifv fuvh fvifhv fvuifhviurthg efopgiyer giuerg rejngeufg weuhv wev ieouwg irue gureiwhg vjwuhvu wuiwh viurwv rwiuhv rwibvn oiu nifn...."
    }

    @IBAction func backPressed(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
}

