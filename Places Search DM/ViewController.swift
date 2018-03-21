//
//  ViewController.swift
//  Places Search DM
//
//  Created by Appinventiv on 21/03/18.
//  Copyright © 2018 Appinventiv. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var objectOfDataModel = [DataModel]()
    var oldSearch = ""
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource=self
        tableView.delegate = self
        searchBar.delegate = self
    }
}

extension ViewController: UISearchBarDelegate, UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func showALert(message:String){
        let alert = UIAlertController(title: "Invalid Search", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("Fetching the data")
            if searchBar.text!.isEmpty{
                self.showALert(message: "Search field can't be empty !!")
            }
            else if oldSearch == searchBar.text!
            {
                self.showALert(message: "Already searched !!")
                return
            }
            else{
                objectOfDataModel.removeAll()
                APIController().requestData(parameters: searchBar.text!) { (arrayOfDataFetched) in
                self.objectOfDataModel = arrayOfDataFetched
                    if objectOfDataModel.count == 0{
                        self.showALert(message: "No record found..!!")
                    }
                }
            }
        oldSearch = searchBar.text!
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.objectOfDataModel.count)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCellID") as! TableViewCell
        let currentResult = self.objectOfDataModel[indexPath.row]
        var typeOfPlace = ""
        for type in currentResult.type{
            if typeOfPlace != ""{
                typeOfPlace = typeOfPlace + ", " + type
            }
            else{
                typeOfPlace = type
            }
        }
        cell.textView.text = "Name: \(currentResult.place_name)\nAddress: \(currentResult.place_address)\n Type: \(typeOfPlace)"
        //print(currentResult.type)
        return cell
    }
}

