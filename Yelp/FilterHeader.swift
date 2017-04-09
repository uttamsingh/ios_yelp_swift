//
//  FilterHeader.swift
//  Yelp
//
//  Created by Singh, Uttam on 4/9/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

public class FilterHeader {
    
    public var headerText : String
    public var headerData : [NSObject]
    public var sectionCells : [FilterCell]
    
    init(headerText: String, headerData: [NSObject], sectionCells: [FilterCell]) {
        self.headerText = headerText
        self.headerData = headerData
        self.sectionCells = sectionCells
    }
}
