//
//  ScaleSelectionViewController.swift
//  CardMatch
//
//  Created by Matthew Patterson on 10/1/19.
//  Copyright © 2019 Matthew Patterson. All rights reserved.
//

import UIKit
import Foundation

protocol ScaleSelectionDelegate {
    func passScale(selection: Int)
}

class ScaleSelectionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var delegate: ScaleSelectionDelegate?
    var passedScale: Int = 0
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var model: CardModel!
    private var data: [String] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        //add options to menu array
        data.append("6 X 6 Game")
        data.append("4 X 4 Game")
        data.append("2 X 2 Game")
        
        
        

    }
    



func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data.count   //return number of cells in option tableview
}

    
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell")
    
        let text = data[indexPath.row]
        cell?.textLabel?.text = text    //set text for option menu cells

        return cell!    //return the cell for tableview
    
    }
    
func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        if (indexPath.row == 0) {
           
            delegate?.passScale(selection: 6)   //if you pick option 1 set scale to 6
            
            navigationController?.popViewController(animated: true)
            
        }
        if (indexPath.row == 1) {
            print("check")
            
            delegate?.passScale(selection: 4)   //if you pick option 2 set scale to 4
            
            navigationController?.popViewController(animated: true)
            
        }
    
        if (indexPath.row == 2) {
            print("check")
            
            delegate?.passScale(selection: 2)   //if you pick option 3 set scale to 2
            
            navigationController?.popViewController(animated: true)
            
        }
    }
    

        
        
    
}
