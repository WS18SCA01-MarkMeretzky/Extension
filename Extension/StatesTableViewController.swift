//
//  StatesTableViewController.swift
//  Extension
//
//  Created by Instructor on 2/27/19.
//  Copyright © 2019 Instructor. All rights reserved.
//

import UIKit;
import SafariServices;

class StatesTableViewController: UITableViewController {
    
    var states: [String] = [   //The model is an array of 50 Strings.
        "Alabama",
        "Alaska",
        "Arizona",
        "Arkansas",
        "California",
        "Colorado",
        "Connecticut",
        "Delaware",
        "Florida",
        "Georgia",
        "Hawaii",
        "Idaho",
        "Illinois",
        "Indiana",
        "Iowa",
        "Kansas",
        "Kentucky",
        "Louisiana",
        "Maine",
        "Maryland",
        "Massachusetts",
        "Michigan",
        "Minnesota",
        "Mississippi",
        "Missouri",
        "Montana",
        "Nebraska",
        "Nevada",
        "New Hampshire",
        "New Jersey",
        "New Mexico",
        "New York",
        "North Carolina",
        "North Dakota",
        "Ohio",
        "Oklahoma",
        "Oregon",
        "Pennsylvania",
        "Rhode Island",
        "South Carolina",
        "South Dakota",
        "Tennessee",
        "Texas",
        "Utah",
        "Vermont",
        "Virginia",
        "Washington",
        "West Virginia",
        "Wisconsin",
        "Wyoming"
    ];
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        // Uncomment the following line to preserve selection between presentations
        // clearsSelectionOnViewWillAppear = false;
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        navigationItem.rightBarButtonItem = editButtonItem;
    }
}

// MARK: - UITableViewDataSource: 3 important methods

extension StatesTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return states.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "StatesCell", for: indexPath)
        
        // Configure the cell ...
        let state: String = states[indexPath.row];
        cell.textLabel?.text = state;
        cell.detailTextLabel?.text = "\(state) is state number \(indexPath.row + 1) out of \(states.count).";
        cell.imageView?.image = UIImage(named: state);
        return cell;
    }
}

// MARK: - UITableViewDataSource: insert and delete cells

extension StatesTableViewController {
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true;   //Return true if you want the specified cell to be editable.
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete;
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            states.remove(at: indexPath.row);                   //Delete the String from the model.
            tableView.deleteRows(at: [indexPath], with: .fade); //Delete the cell from the table view.
        }
    }
}

// MARK: - UITableViewDataSource: move a cell

extension StatesTableViewController {
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true;   //Return true if you want the cell to be re-orderable.
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let state: String = states.remove(at: fromIndexPath.row);
        states.insert(state, at: to.row);
        tableView.reloadData();
    }
}

// MARK: - UITableViewDataSource: section headers & footers

extension StatesTableViewController {
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "States";
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "";
    }
}

// MARK: - UITableViewDelegate

extension StatesTableViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let state: String = states[indexPath.row];
        //print("selected cell \(indexPath)");
        var urlComponents: URLComponents = URLComponents();
        
        urlComponents.scheme = "https";
        urlComponents.host = "en.wikipedia.org"; //English
        urlComponents.path = "/wiki/\(state)";   //change " " to "%20"
        
        guard let url: URL = urlComponents.url else {
            fatalError("could not create url for state \(state)");
        }
        
        let safariViewController: SFSafariViewController = SFSafariViewController(url: url);
        present(safariViewController, animated: true);
    }
}

// MARK: - Navigation between view controllers

extension StatesTableViewController {
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation.
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender);
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        print("preparing for segue to \(type(of: segue.destination))");
    }
    
    @IBAction func unwindToStatesTableViewController(unwindSegue: UIStoryboardSegue) {
        print("unwound back home from \(type(of: unwindSegue.source))");
    }
}
