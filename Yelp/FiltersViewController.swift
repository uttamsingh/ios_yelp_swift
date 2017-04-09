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
    var swtichStates = [Int:Bool]()
    
    weak var delegate: FiltersViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoris = yelpCategories()
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    func yelpCategories() -> [[String:String]]{
        return [["name": "Afgan", "code": "Thai"],
                ["name": "African", "code": "Thai"]]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoris.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: YelpContants.filterViewControllerTableCell) as! FilterTableViewCell
        
        cell.filterLabel.text = categoris[indexPath.row]["name"]
        cell.delegate = self

        //Set the value is already selected else false
        cell.onSwitch.isOn = swtichStates[indexPath.row] ?? false
        
        return cell
    }
    
    func filterTableViewCell(filterTableViewCell: FilterTableViewCell, didChangeValue value: Bool) {
        let indexPath = tableView.indexPath(for: filterTableViewCell)!
        swtichStates[indexPath.row] = value
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
        
        print(selectedCategories)
        delegate?.filtersViewController?(filtersViewController: self, didUpdateFilters: filters)
        
    }
    
    
}
