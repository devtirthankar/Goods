//
//  ArrayExtension.swift
//  Naher
//
//  Created by Amaresh on 20/02/17.
//  Copyright © 2017 NAHER. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {
    
    // Remove first collection element that is equal to the given `object`:
    mutating func remove(object: Element) {
        if let index = index(of: object) {
            if index >= 0 {
               let _ = remove(at: index)
            }
        }
    }
}
