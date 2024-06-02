//
//  golem.swift
//  AFL2_0706012210016
//
//  Created by MacBook Pro on 26/05/24.
//

import Foundation

class Golem: Monster {
  
  override init(name: String, level: Int) {
    super.init(name: name, level: level)

    self.health = 70 + ((Int.random(in: 1...self.level)) * (5*self.level))
    self.currHealth = self.health

    self.physicalDefense = 20 + (2*self.level)
    self.magicalDefense = -15 + (2*self.level)
    self.attack = 15 + (4*self.level)
    self.attribute = "Golems are known for their strength and durability. They are also known for their ability to withstand heavy physical blows, but weak against magical attacks."
  }

  override func physicalAttacked(amount: Int) {
    let chanceToDodge = Int.random(in: 1...11)
    if chanceToDodge <= 6 {
      print("\(name)'s tough exterior deflected your attack!")
      return
    }
    
    var finalAmount = amount - physicalDefense
    if finalAmount < 0 {
      finalAmount = 0
    }
    print("\(name) is Strong against physical attack, \(finalAmount) damage dealt to \(name).")
    health -= finalAmount
  }

  func golemFlee(wizard: inout Wizard)->Bool {
    let chanceToFlee = Int.random(in: 1...11)
    if chanceToFlee <= 6 {
      print("🐔 You fled the battle.")
      return true
    } else {
      print("😈 Golem leaped forward and stopped you in your tracks! You failed to flee the battle.")
      return false
    }
  }
}
