//
//  FiltersViewController.swift
//  Yelp
//
//  Created by Singh, Uttam on 4/8/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol FiltersViewControllerDelegate {
    @objc optional func filtersViewController(filtersViewController: FiltersViewController, didUpdateFilters filters: [String:AnyObject])
}

class FiltersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, FilterTableViewCellDelegate
{
    
    @IBOutlet weak var tableView: UITableView!
    
    var categoris:  [[String:String]]!
    var distances:  [[String:String]]!
    var sortBy:  [[String:String]]!
    var offeringADeal: String!
    
    var swtichStates = [Int:Bool]()
    var distanceStates = [Int:Bool]()
    var sortByStates = [Int:Bool]()
    
    
//    var offeringADealValue: Bool!
//    var distanceValue: Double!
//    var sortByValue:String!

    var offeringADealFilter: Bool = false
    var distanceFilter: String? = nil
    var sortByFilter: String = "Auto"
    
    
    weak var delegate: FiltersViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoris = yelpCategories()
        sortBy = yelpSortBy()
        distances = yelpDistances()
        offeringADeal = yelpOfferingADeal()
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    func yelpCategories() -> [[String:String]]{
        return [["name": "Afgan", "code": "afgan"],
                ["name": "African", "code": "african"]
        ]
    }
    
    func yelpDistances() -> [[String:String]]{
        return [["name": "1 Mile", "value": "1.00"],
                ["name": "2 Miles", "Value": "2.00"],
                ["name": "3 Miles", "Value": "3.00"],
                ["name": "4 Miles", "Value": "4.00"],
                ["name": "5 Miles", "Value": "5.00"]
        ]
    }
    
    func yelpSortBy() -> [[String:String]]{
        return [["name": "Auto", "value": "None"],
                ["name": "Best Match", "code": "best match"],
                ["name": "Highest Ratedh", "code": "highest rated"]
        ]
    }
    
    func yelpOfferingADeal() -> String {
        return "Offering a Deal"
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: YelpContants.filterViewControllerTableCell) as! FilterTableViewCell
        
        
        if indexPath.section == 0 {
            cell.filterLabel.text = offeringADeal
            cell.onSwitch.isOn = offeringADealFilter
        }

        else if indexPath.section == 1 {
            cell.filterLabel.text = distances[indexPath.row]["name"]
            cell.onSwitch.isOn = distanceStates[indexPath.row] ?? false
        }
        
        else if indexPath.section == 2 {
            cell.filterLabel.text = sortBy[indexPath.row]["name"]
           cell.onSwitch.isOn = sortByStates[indexPath.row] ?? false
        }
        else if indexPath.section == 3 {
            cell.filterLabel.text = categoris[indexPath.row]["name"]
            //Set the value is already selected else false
            cell.onSwitch.isOn = swtichStates[indexPath.row] ?? false
        } else {
            print("Could not find the section")
        }
        
        cell.delegate = self
        cell.selectionStyle = .none
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        } else if section == 1{
            return distances.count
        } else if section == 2{
            return sortBy.count
        }  else if section == 3{
            return categoris.count
        }
        else {
            return 0
        }
    }

    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            return ""
        } else if section == 1{
            return  "Distance"
        } else if section == 2{
            return  "Sort By"
        }  else if section == 3{
            return  "Category"
        }
        else {
           return  nil
        }
    }
    
    
    func filterTableViewCell(filterTableViewCell: FilterTableViewCell, didChangeValue value: Bool) {
        let indexPath = tableView.indexPath(for: filterTableViewCell)!
        
        let section: Int = indexPath.section
        
        if section == 0 {
            offeringADealFilter = value
            
        } else if section == 1{
            if value ==  true {
                distanceFilter = filterTableViewCell.filterLabel.text!
                distanceStates.keys.forEach({ (distanceStates[$0] = false)})
                print(distanceStates)
            } else{
                distanceFilter = nil
            }
            distanceStates[indexPath.row] = value
        } else if section == 2{
            if value ==  true {
                sortByFilter = filterTableViewCell.filterLabel.text!
                sortByStates.keys.forEach({ (sortByStates[$0] = false)})
            } else {
                sortByFilter = "Auto"
            }
            sortByStates[indexPath.row] = value
        }  else if section == 3{
            swtichStates[indexPath.row] = value
        }
        else {
            print("Couldn't find case of switch action")
        }
        
        self.tableView.reloadData()
    }
    
    @IBAction func cancelSearch(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func search(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        var filters = [String: AnyObject]()
        
        var selectedCategories = [String] ()
        for (row, isSelected) in swtichStates {
            if isSelected {
                selectedCategories.append(categoris[row]["code"]!)
            }
        }
        
        if selectedCategories.count > 0 {
            filters["categories"] = selectedCategories as AnyObject
        }
        
        if offeringADealFilter == true {
            filters["deals"] = offeringADealFilter as AnyObject
        }
        
        if  distanceFilter != nil {
            filters["distance"] = distanceFilter as AnyObject
        }
        if sortByFilter != "Auto" {
            filters["sortBy"] = sortByFilter as AnyObject
        }
        print("Before delegating from FilterViewController")
        print(filters)
        delegate?.filtersViewController?(filtersViewController: self, didUpdateFilters: filters)
        
    }
}
