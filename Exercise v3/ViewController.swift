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
    var phoneNumberArray = [String]()
    var emailAddressArray = [String]()
    
    
    var indexPath = ""
    
 //https://learnappmaking.com/table-view-controller-uitableviewcontroller-how-to/
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return companyArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "companyListingsCell", for: indexPath) as! ControlsTableViewCell
        cell.listingLabel.text = companyArray[indexPath.row]
        cell.ratingsLabel.text="Rating: "+compositeRatingsArray[indexPath.row]+" | "+ratingsCountArray[indexPath.row]+" rating(s)"
        cell.btnCell.tag=indexPath.item
        cell.btnCell.addTarget(self, action: #selector(clicked), for: .touchUpInside)
        return cell
    }
    
    @objc func clicked(sender:UIButton){
        indexPath=String(sender.tag)
        performSegue(withIdentifier: "detailsViewController", sender: nil)
        print(sender.tag)
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
                    emailAddressArray.append(information.email!)
                    phoneNumberArray.append(information.phoneNumber!)
                }
            }
            DispatchQueue.main.async {
                self.myTableView.reloadData()
            }
        }catch{
            print("Got an error")
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        if(segue.identifier=="detailsViewController"){
        let communicationViewController = segue.destination as! CommunicationVIewControllerViewController
            communicationViewController.emailAddress=emailAddressArray[Int(indexPath)!]
            communicationViewController.phoneNumber=phoneNumberArray[Int(indexPath)!]
        }
        // Pass the selected object to the new view controller.
    }
    
}
