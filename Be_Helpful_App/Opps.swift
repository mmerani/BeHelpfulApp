//
//  Opps.swift
//  Be_Helpful_App
//
//  Created by Michael Merani on 7/27/16.
//  Copyright © 2016 Michael Merani. All rights reserved.
//

import UIKit
import Firebase

class Opps: UITableViewController {
    
    let searchController = UISearchController(searchResultsController: nil)

    let cellId = "cellId"
    
    var opportunities = [Opportunities]()
    var filteredOpps = [Opportunities]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        getOpportunities()
    }
    
    func getOpportunities(){
        FIRDatabase.database().reference().child("opportunities").observeEventType(.ChildAdded, withBlock: { (snapshot) in
            
            print(snapshot)
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let opp = Opportunities()
                
                opp.setValuesForKeysWithDictionary(dictionary)
                self.opportunities.append(opp)
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                })
                
            }
            
            }, withCancelBlock: nil)
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       if searchController.active && searchController.searchBar.text != ""{
       return filteredOpps.count
       }
        
        return opportunities.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: cellId)
        let opp: Opportunities
        if searchController.active && searchController.searchBar.text != "" {
            opp = filteredOpps[indexPath.row]
        } else {
       
         opp = opportunities[indexPath.row]
        }
        cell.textLabel?.text = opp.name
        cell.detailTextLabel?.text = opp.job
        
        return cell
    }
    func filterContentForSearchText(searchText: String){
        
        filteredOpps = opportunities.filter{ opp in
            return opp.name!.lowercaseString.containsString(searchText.lowercaseString)
        }
        tableView.reloadData()
    }
    

}

extension Opps: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
