//
//  ViewController.swift
//  Exercise v3
//
//  Created by Deepson Khadka on 1/28/20.
//

import UIKit



class ViewController: UITableViewController{
    
    @IBOutlet var myTableView: UITableView!
    var companyArray = [String]()
    var compositeRatingsArray = [String]()
    var ratingsCountArray = [String]()
    
    
    
    //https://learnappmaking.com/table-view-controller-uitableviewcontroller-how-to/
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return companyArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "companyListingsCell", for: indexPath) as! ControlsTableViewCell
        cell.listingLabel.text = companyArray[indexPath.row]
        cell.ratingsLabel.text="Rating: "+compositeRatingsArray[indexPath.row]+" | "+ratingsCountArray[indexPath.row]+" rating(s)"
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nestedJsonParser(pathLocation: "pro_data")
    }
    
    func nestedJsonParser(pathLocation: String){
        guard let path = Bundle.main.path(forResource: pathLocation, ofType: "json") else{
            print("File not found")
            return
        }
        
        let url = URL(fileURLWithPath: path)
        do{
            let data = try Data(contentsOf: url)
            let lists = try JSONDecoder().decode([List].self, from: data)
            
            for information in lists{
                if information.companyName == nil {
                    companyArray.append("UnListed")
                    compositeRatingsArray.append("NA")
                    ratingsCountArray.append("NA")
                }else{
                    companyArray.append(information.companyName!)
                    compositeRatingsArray.append(information.compositeRating!)
                    ratingsCountArray.append(information.ratingCount!)
                }
            }
            DispatchQueue.main.async {
                self.myTableView.reloadData()
            }
        }catch{
            print("Got an error")
        }
    }
    
}
