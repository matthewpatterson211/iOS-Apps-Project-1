//
//  CollectionViewCell.swift
//  CardMatch
//
//  Created by Matthew Patterson on 9/17/19.
//  Copyright © 2019 Matthew Patterson. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cardFront: UIImageView!
    
    @IBOutlet weak var cardBack: UIImageView!
    
    var card:Card?
    
    func setCard(_ card:Card) {
        
        self.card = card
        
        //sets card images based on the number sent from the array
        cardFront.image = UIImage(named: card.imageFile)

        
    }
    
    func flip() {
        
        //flip transitions from the front image to the back image
        UIView.transition(from: cardBack, to: cardFront, duration: 0.5, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)

    }
    
    func flipBack() {
        
        //flips cards back after a nonmatch
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            UIView.transition(from: self.cardFront, to: self.cardBack, duration: 0.5, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
            
        }
    }
    func removeCard() {
        
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
            //makes cells invisible after match
            self.cardFront.alpha = 0
            self.cardBack.alpha = 0
        }
    }
    
    func resetCell() {
        
        //this function makes the cells visible again when you start a new game
        self.cardFront.alpha = 1
        self.cardBack.alpha = 1
        UIView.transition(from: self.cardFront, to: self.cardBack, duration: 0, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
        
    }
    

}

