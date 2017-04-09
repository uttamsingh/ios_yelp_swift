//
//  FilterCell.swift
//  Yelp
//
//  Created by Singh, Uttam on 4/9/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

public class FilterCell {
    public var cellkey: String
    public var cellValue: Bool
    
    init(cellKey: String, cellValue: Bool) {
        self.cellkey = cellKey
        self.cellValue = cellValue
    }
}
