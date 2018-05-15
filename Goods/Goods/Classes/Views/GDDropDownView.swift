//
//  GDDropDownView.swift
//  GoodsOwner
//
//  Created by Nabanita on 21/02/18.
//  Copyright © 2018 company. All rights reserved.
//

import UIKit

protocol GDDropDownViewDelegate {
    func donePressed(selectedValue: String, pickerHeader: String)
}

class GDDropDownView: UIView {
    
    @IBOutlet weak var _headerTitle: UILabel!
    @IBOutlet weak var _pickerView: UIPickerView!
    
    var delegate: GDDropDownViewDelegate?
    var selectedPickerValue: String? = ""
    
    var pickerDataSource = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func doneButtonPressed(_ sender: UIButton) {
        if selectedPickerValue?.count == 0 {
            selectedPickerValue = pickerDataSource[0]
        }
        delegate?.donePressed(selectedValue: selectedPickerValue!, pickerHeader: _headerTitle.text!)
    }
    
}

extension GDDropDownView: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row] as String
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(pickerDataSource[row])
        selectedPickerValue = pickerDataSource[row]
    }
}
