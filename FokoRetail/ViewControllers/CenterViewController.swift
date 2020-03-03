//
//  CenterViewController.swift
//  FokoRetail
//
//  Created by Rakesh Tripathi on 2020-02-27.
//  Copyright © 2020 Rakesh Tripathi. All rights reserved.
//

import UIKit

protocol CenterViewControllerDelegate {
    func toggleDrawerMenu()
}

class CenterViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pickerViewForSorting: UIPickerView!
    @IBOutlet weak var appInfoLabel: UILabel!
    @IBOutlet weak var centerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var delegate: CenterViewControllerDelegate?
    var teamRosterInfo: TeamRoster?
    var rosterDetails: [Roster]?
    var listOfTeams: Teams?
    var playerIdKey = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        pickerViewForSorting.delegate = self
        pickerViewForSorting.dataSource = self
        searchBar.delegate = self
        hideRelatedViews()
        self.getTeamsOperation()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func showRelatedViews()
    {
        tableView.isHidden = false
        searchBar.isHidden = false
        pickerViewForSorting.isHidden = false
        appInfoLabel.isHidden = true
    }
    
    func hideRelatedViews()
    {
        tableView.isHidden = true
        searchBar.isHidden = true
        pickerViewForSorting.isHidden = true
    }
    
    
    func showLoader(view: UIView) -> UIActivityIndicatorView {
        
        //Customize as per your need
        let spinner = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 80, height:80))
        spinner.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        spinner.color = UIColor.black
        spinner.layer.cornerRadius = 8.0
        spinner.clipsToBounds = true
        spinner.hidesWhenStopped = true
        spinner.style = UIActivityIndicatorView.Style.medium;
        spinner.center = view.center
        view.addSubview(spinner)
        spinner.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        return spinner
    }
    
    
    func getTeamsOperation() {
        let spinner = showLoader(view: self.view)
        let getTeamsOperation = GetTeamsOperation { [weak self] (allTeamsList, error) in
            guard let allTeams = allTeamsList else { return }
            DispatchQueue.main.async {
                if error == nil {
                    self?.listOfTeams = allTeams
                    spinner.dismissLoader()
                }
            }
        }
        self.enqueueNetworkOperation(operation: getTeamsOperation)
    }
    
    
    func getTeamDetailsOperation(){
        let spinner = showLoader(view: self.view)
        centerView.isUserInteractionEnabled = false
        showRelatedViews()
        DispatchQueue.main.async {
            
            let getTeamDetailsOperation = GetTeamDetailsOperation { [weak self] (teamRoster, error) in
                
                guard let teamRoster = teamRoster else {return}
                DispatchQueue.main.async {
                    if error != nil {
                    }
                    else
                    {
                        self?.teamRosterInfo = teamRoster
                        self?.rosterDetails = teamRoster.roster
                        spinner.dismissLoader()
                        self?.tableView.reloadData()
                    }
                }
            }
            self.enqueueNetworkOperation(operation: getTeamDetailsOperation)
        }
    }
    
    func sortByPlayerName() {
        rosterDetails = (self.teamRosterInfo?.roster?.sorted { $0.person.fullName < $1.person.fullName })!
    }
    func sortByJerseyNumbers() {
        rosterDetails = self.teamRosterInfo?.roster?.sorted { (s1, s2) -> Bool in return s1.jerseyNumber.localizedStandardCompare(s2.jerseyNumber) == .orderedAscending }
    }

}


// MARK: Table View Data Source
extension CenterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rosterDetails?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerListCell", for: indexPath) as! PlayersDetailCell
        cell.playerNameLabel.text = rosterDetails?[indexPath.row].person.fullName
        cell.playerPositionLabel.text = (rosterDetails?[indexPath.row].position?.name).map { $0.rawValue }
        cell.playerJerseyLabel.text = "Jersey# " + (rosterDetails?[indexPath.row].jerseyNumber ?? "0")
        
        return cell
    }
    
}

// Mark: Table View Delegate

extension CenterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        playerIdKey = rosterDetails?[indexPath.row].person.id ?? 0
        TokenManager.playerId = playerIdKey
        self.performSegue(withIdentifier: "did_select_player", sender: nil)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
         view.endEditing(true)
    }
}

// MARK: Picker View Data Source

extension CenterViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 3
    }
}

// Mark: Table View Delegate
extension CenterViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch row {
        case 0:
            return "Sort By"
        case 1:
            return "Player Names"
        case 2:
            return "Jersey Numbers"
        default:
            break
        }
        return ""
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch row {
            
        case 0: rosterDetails = teamRosterInfo?.roster
            
        case 1: sortByPlayerName()
            
        case 2: sortByJerseyNumbers()
            
        default:
            break
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// Mark: Search Bar Delegate

extension CenterViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == ""
        {
            rosterDetails = teamRosterInfo?.roster
        }
        else{
            rosterDetails = teamRosterInfo?.roster?.filter { ($0.position?.name)!.rawValue.localizedCaseInsensitiveContains(searchText) }
        }
        self.tableView.reloadData()
        
    }
}

extension CenterViewController: DrawerMenuViewControllerDelegate {
    
    func getTeamsData() -> Teams? {
        return self.listOfTeams
    }
    
    func didSelectMenuOption(_ index: Int) {
        delegate?.toggleDrawerMenu()
        getTeamDetailsOperation()
    }
}

extension UIActivityIndicatorView {
    func dismissLoader() {
        self.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
    }
}

