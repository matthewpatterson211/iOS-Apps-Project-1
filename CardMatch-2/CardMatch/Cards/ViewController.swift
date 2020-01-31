//
//  ViewController.swift
//  CardMatch
//
//  Created by Matthew Patterson on 9/17/19.
//  Copyright © 2019 Matthew Patterson. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
   
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var model = CardModel()
    var cardArray = [Card]()
    
    
    var scale: Int = 6
    
    var flippedCard:IndexPath? //stores the first flipped card
    var width: CGFloat = 0.0
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // use UserDefaults stores the scale value
        scale = UserDefaults.standard.integer(forKey: "scale")

        
        collectionView.delegate = self
        collectionView.dataSource = self
        cardArray = model.getCards(scale: scale) //grabs a fresh set of cards
        cardArray.shuffle() //shuffles card array
       
        scaler(scale: scale)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
        
        //saves the scale value when the view returns from option menu
        UserDefaults.standard.set(scale, forKey: "scale")
        
        scaler(scale: scale)    //call scaler function
        

    }

    
    func scaler (scale: Int){
        
        //scaler function chooses a different width based on the grid pattern chosen
        switch scale {
        case 6:
            width = (view.frame.size.width - (50)) / 6
        case  4:
            width = (view.frame.size.width - (30)) / 4
        case 2:
            width = (view.frame.size.width - (10)) / 2
        default:
            width = (view.frame.size.width - (50)) / 6
        }
        
        //uses width to set the cell sizes
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
        
    }
    
    @IBAction func refreshButtonTapped(_ sender: Any) {
        refreshCollection()
    }
    
    private func refreshCollection() {
        
        //resets the cards for a fresh game
        flippedCard = nil   //resets the first picked card, so you dont match with the new game
        cardArray = model.getCards(scale: scale)
        cardArray.shuffle()
        collectionView.reloadData()
        
    }
    

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //default function to find number of collectionview cells
        return cardArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //cell graber function
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        
        let card = cardArray[indexPath.row] //holds index of selected cell
        
        cell.setCard(card)
        
        cell.resetCell()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        
        print(indexPath.row)
        
        let card = cardArray[indexPath.row]
        
        if card.isFlipped == false {
            cell.flip()
            cardArray[indexPath.row].isFlipped = true
            
            if flippedCard == nil {
                flippedCard = indexPath
            }
            else {
                didTheyMatch(indexPath)
            }
            
        }
        
        print(card)
        print(cardArray)

        
    }
    
    
    
    func didTheyMatch (_ flippedCardTwo: IndexPath) {
        
        let cellOne = collectionView.cellForItem(at: flippedCard!) as! CollectionViewCell
        
        let cellTwo = collectionView.cellForItem(at: flippedCardTwo) as! CollectionViewCell
        
        let firstCard = cardArray[flippedCard!.row]
        let secondCard = cardArray[flippedCardTwo.row]
        
        if firstCard.imageFile == secondCard.imageFile {
            cardArray[flippedCard!.row].isMatched = true
            cardArray[flippedCardTwo.row].isMatched = true
            
            cellOne.removeCard()
            cellTwo.removeCard()
            
            didYouWin()
        }
        else {
            cardArray[flippedCard!.row].isFlipped = false
            cardArray[flippedCardTwo.row].isFlipped = false
            
            cellOne.flipBack()
            cellTwo.flipBack()
            
            
        }
        flippedCard = nil
    }

    
    func didYouWin() {
        var theGameIsWon = true
        print("win check")
        
        for card in cardArray {
            
            if card.isMatched == false {
                theGameIsWon = false
                break
            }
        }
        if theGameIsWon == true {
            let alert = UIAlertController(title: "You Win!", message: "Would you like to play again?", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                self.refreshCollection()
            }))
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))

            self.present(alert, animated: true)
            
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ScaleSelectionViewController {
            
            vc.model = model
            vc.delegate = self
        }
    }
    
}

extension ViewController: ScaleSelectionDelegate {
    
    
    
     func passScale(selection: Int) {
        print(selection)
        scale = selection
        refreshCollection()
        presentedViewController?.dismiss(animated: true, completion: nil)
        }
}
