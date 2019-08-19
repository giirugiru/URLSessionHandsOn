//
//  ViewController.swift
//  URLSessionHandsOn
//
//  Created by Gilang Sinawang on 19/08/19.
//  Copyright © 2019 Gilang Sinawang. All rights reserved.
//

import UIKit

struct Country: Decodable{
    let name: String
    let capital: String
    let region: String
}

class ViewController: UIViewController, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = countryTableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = countries![indexPath.row].name
        return cell!
    }
    
    
    var countries: [Country]?

    @IBOutlet weak var countryTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let url = "https://restcountries.eu/rest/v2/all"
        let urlObject = URL(string: url)
        
        URLSession.shared.dataTask(with: urlObject!) {(data, resoponse, error) in
            
            do{
                self.countries = try JSONDecoder().decode([Country].self, from: data!)
                
                for country in self.countries! {
                    print(country.name)
                    print("capital:", country.capital)
                    print("region:", country.region)
                    print("")
                }
                
                DispatchQueue.main.async {
                    print(self.countries?.count)
                    self.countryTableView.dataSource = self
                }
            }catch{
                print("Error!")
            }
        }.resume()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

