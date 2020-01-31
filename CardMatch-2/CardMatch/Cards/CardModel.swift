//
//  CardModel.swift
//  CardMatch
//
//  Created by Matthew Patterson on 9/28/19.
//  Copyright © 2019 Matthew Patterson. All rights reserved.
//

import Foundation


class CardModel {
    
    let defaults = UserDefaults.standard
    
    var scale = 6
    
    func getCards(scale: Int) -> [Card] {   //gets cards for collection
        
        var cardsArray = [Card]()
        var usedCardsArray = [Int]()
        var cardPairCount: Int
        
        switch scale {  //set number of card pairs based on your scale
        case 6:
            cardPairCount = 18
        case 4:
            cardPairCount = 8
        case 2:
            cardPairCount = 2
        default:
            cardPairCount = 18
        }
        
        //usedCardArray stores the cards used, keeps looping until you reach the pair count
        while usedCardsArray.count < cardPairCount {
            
            //generate a random image for a pair
            let number = Int.random(in: 0 ..< 19) + 1

            if usedCardsArray.contains(number) == false {
               
                //adds card to usedCardArray
                usedCardsArray.append(number)
                var firstCard = Card()
                      
                firstCard.imageFile = "card\(number)"
                      
                cardsArray.append(firstCard)
                      
                //add second card from set to array
                var secondCard = Card()
                secondCard.imageFile = "card\(number)"
                      
                cardsArray.append(secondCard)
            }
            
            
        }
            return cardsArray
        }
    }

