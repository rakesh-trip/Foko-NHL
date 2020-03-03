//
//  DrawerMenuViewController.swift
//  FokoRetail
//
//  Created by Rakesh Tripathi on 2020-02-27.
//  Copyright © 2020 Rakesh Tripathi. All rights reserved.
//

import UIKit

class DrawerMenuViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var delegate: DrawerMenuViewControllerDelegate?
    var listOfTeams: [Team]?
    var teamIDKey = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        listOfTeams = delegate?.getTeamsData()?.teams
        tableView.clipsToBounds = true
        tableView.bounces = false
        tableView.layer.borderColor = UIColor.gray.cgColor
        tableView.layer.borderWidth = 1.0
        tableView.backgroundColor = UIColor.blue
        //shadow view also need cornerRadius
        tableView.layer.cornerRadius = 10
        tableView.layer.shadowColor = UIColor.lightGray.cgColor
        tableView.layer.shadowOffset = CGSize(width: -10, height: 10) //Left-Bottom shadow
        //containerView.layer.shadowOffset = CGSizeMake(10, 10); //Right-Bottom shadow
        tableView.layer.shadowOpacity = 1.0
        tableView.layer.shadowRadius = 2

        //for rounded corners
//        tableView.layer.cornerRadius = 10
//        tableView.layer.masksToBounds = true
    }
}

// MARK: Table View Data Source
extension DrawerMenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfTeams?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeamListCell", for: indexPath)
        if let name = listOfTeams?[indexPath.row].name {
            cell.textLabel?.text = name
        }
        
        if let abv = listOfTeams?[indexPath.row].abbreviation {
            cell.imageView?.image = UIImage.init(named: "\(abv)")
        }
        
        
        
        
        
//        var imageDict:[String:String] = ["New York Islanders":"NJD", "New Jersey Devils":"NJD", "New York Islanders":"NYI","New York Rangers":"EDM","Philadelphia Flyers":"PHI","Pittsburgh Penguins":"PIT","Boston Bruins":"BOS","Buffalo Sabres":"BUF","Montréal Canadiens":"MTL","Ottawa Senators":"OTT", ]
        return cell
        
    }
}

// Mark: Table View Delegate

extension DrawerMenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        teamIDKey = (listOfTeams?[indexPath.row].id ?? 0)
        TokenManager.teamId = teamIDKey
        delegate?.didSelectMenuOption(indexPath.row)
    }
}


protocol DrawerMenuViewControllerDelegate {
    func didSelectMenuOption(_ index: Int)
    func getTeamsData() -> Teams?
}
