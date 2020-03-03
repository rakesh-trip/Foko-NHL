//
//  ViewController.swift
//  FokoRetail
//
//  Created by Rakesh Tripathi on 2020-02-27.
//  Copyright © 2020 Rakesh Tripathi. All rights reserved.
//

import UIKit

class PlayerDetailsViewController: UIViewController {
    
    var playerInfo: Player?
    
    @IBOutlet weak var playerNationalityLabel: UILabel!
    @IBOutlet weak var flagImageView: UIImageView!
    var playerNationality = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getPlayers()
    }
    
    func showLoader(view: UIView) -> UIActivityIndicatorView {
        
        //Customize as per your need
        let spinner = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 120 , height:120))
        spinner.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        spinner.layer.cornerRadius = 8.0
        spinner.clipsToBounds = true
        spinner.hidesWhenStopped = true
        spinner.color = UIColor.black
        spinner.style = UIActivityIndicatorView.Style.medium;
        spinner.center = view.center
        view.addSubview(spinner)
        spinner.startAnimating()
        view.isUserInteractionEnabled = false
//        UIApplication.shared.beginIgnoringInteractionEvents()
        
        return spinner
    }
    
    func getPlayers(){
        let spinner = showLoader(view: self.view)
        
        let getPlayerOperation = GetPlayerOperation { [weak self] (player, error) in
            
            DispatchQueue.main.async {
                if error != nil || player == nil {
                    
                }
                else
                {
                    spinner.dismissLoader()
                    self?.playerInfo = player
                    let playerNationality = self?.playerInfo?.people.last?.nationality
                    let countryFlag: String = "https://www.countryflags.io/"
                    let imgURL : String = countryFlag + (playerNationality?.dropLast() ?? "") + "/shiny/64.png"
                    let url = URL(string: imgURL)
                    
                    let task = URLSession.shared.dataTask(with: url!) { data, response, error in
                        guard let data = data, error == nil else { return }
                        DispatchQueue.main.async {
                            self?.playerNationalityLabel.text = playerNationality
                            
                            self?.flagImageView.image = UIImage(data: data)
                        }
                    }
                    task.resume()
                }
                
            }
        }
        self.enqueueNetworkOperation(operation: getPlayerOperation)
    }
    
    
    func setImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }
        
        // just not to cause a deadlock in UI!
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.flagImageView.image = image
            }
        }
    }
}
