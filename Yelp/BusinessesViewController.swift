//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit
import MBProgressHUD

class BusinessesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate , FiltersViewControllerDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    var searchController: UISearchController!
    var refreshControl: UIRefreshControl!
    
    var businesses: [Business]!
    
    struct Storyboard {
        static let businessCell = "BusinessCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        tableView.delegate = self
        tableView.dataSource = self

        //call yelp api to populate some data
        callYelpAPI()
        
        //Create search bar
        createSearchbar()
        //add refresh control
        addRefreshControl()
    }
    
    func callYelpAPI() {
        Business.searchWithTerm(term: "Thai", completion: { (businesses: [Business]?, error: Error?) -> Void in
            
            self.businesses = businesses
            self.tableView.reloadData()
            if let businesses = businesses {
                for business in businesses {
                    print(business.name!)
                    print(business.address!)
                }
            }
            
        }
        )
    }
    
    func addRefreshControl() {
        // Initialize a UIRefreshControl
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        let refreshTitleAttr = [NSForegroundColorAttributeName: UIColor.black]
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh", attributes:refreshTitleAttr)
        
        // add refresh control to table view
        tableView.insertSubview(refreshControl, at: 0)
    }
    
    /**
    * Method responsible for creating search bar in navigation controller
    * Make sure to implement UISearchBarDelegate 
    */
    func createSearchbar() {
        // create the search bar programatically since you won't be
        // able to drag one onto the navigation bar
        let searchBar = UISearchBar()
        searchBar.showsCancelButton = false
        searchBar.placeholder = "Enter your search here!"
        searchBar.delegate = self
        searchBar.sizeToFit()
        // the UIViewController comes with a navigationItem property
        // this will automatically be initialized for you if when the
        // view controller is added to a navigation controller's stack
        // you just need to set the titleView to be the search bar
        navigationItem.titleView = searchBar

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as!    UINavigationController
        let filterViewController = navigationController.topViewController as! FiltersViewController
        filterViewController.delegate = self
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if businesses != nil {
            return businesses.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.businessCell, for: indexPath) as! BusinessCell
        cell.business = self.businesses?[indexPath.row]
        cell.selectionStyle = .blue
        return cell
    }
    
    // Makes a network request to get updated data
    // Updates the tableView with the new data
    // Hides the RefreshControl
    func refreshControlAction(_ refreshControl: UIRefreshControl) {
        print("Refreshing data...")
        callYelpAPI()
        refreshControl.endRefreshing()
    }
    
    func filtersViewController(filtersViewController: FiltersViewController, didUpdateFilters filters: [String : AnyObject]) {
        
        if  (filters["categories"] != nil  || filters["categories"] != nil
            || filters["categories"] != nil || filters["categories"] != nil) {
            let categories = filters["categories"] as! [String]
            let sortBy = filters["sortBy"] as? YelpSortMode
            let deals = filters["deals"] as? Bool
            print("Filters in BusineesViewController")
            print(filters)
            Business.searchWithTerm(term: "Restaurants", sort: sortBy, categories: categories, deals: deals) { (businesses: [Business]!, error: Error!) in
                print("printint search with term resposne - ", businesses)
                self.businesses = businesses
                //            self.tableView.reloadData()
            }
        }
    }
}
