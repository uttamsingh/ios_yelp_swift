//
//  FiltersViewController.swift
//  Yelp
//
//  Created by Singh, Uttam on 4/8/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

class FiltersViewController: UIViewController , UITableViewDataSource, UITableViewDelegate{
    @IBOutlet weak var tableView: UITableView!
    
    let data = [("", ["Offering a Deal"]),
                ("Distance", ["5 miles", "2 miles"]),
                ("Sort By", ["Miami", "Jacksonville"]),
                ("Category", ["Afgan", "African"])]
    
    var checked: [Bool]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checked = [Bool](repeating: false, count: data.count)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: YelpContants.filterViewControllerTableCell)
        tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: YelpContants.filterViewControllerTableHeaderCell)
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        checked[indexPath.row] = !checked[indexPath.row]
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: YelpContants.filterViewControllerTableCell, for: indexPath) as UITableViewCell
        let citiesInSection = data[indexPath.section].1
        cell.textLabel?.text = citiesInSection[indexPath.row]
        
        if checked[indexPath.row] {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: YelpContants.filterViewControllerTableHeaderCell)!
        header.textLabel?.text = data[section].0
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    @IBAction func cancelSearch(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func search(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
