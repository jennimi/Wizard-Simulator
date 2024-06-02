//
//  monster.swift
//  AFL2_0706012210016
//
//  Created by MacBook Pro on 26/05/24.
//

import Foundation

class Monster {
  var name: String
  var health: Int
  var defeated: Bool
  var currHealth: Int
  var physicalDefense: Int
  var magicalDefense: Int
  var attack: Int
  var attribute: String
  var level: Int

  init(name: String, level: Int) {
    self.level = Int.random(in: 1...(level))

    // According to level
    self.health = 50 + ((Int.random(in: 1...self.level)) * (5*self.level))
    self.currHealth = self.health
    
    self.name = name
    self.defeated = false
    self.physicalDefense = 0
    self.magicalDefense = 0
    self.attack = 0
    self.attribute = ""
  }

  func show() {
    print("😈 Name: \(name)")
    print("😈 Health: \(health)/\(currHealth)")
  }

  func physicalAttacked(amount: Int) {
    let chanceToDodge = Int.random(in: 1...11)
    if chanceToDodge == 1 {
        print("\(name) dodged your attack!")
    } else {
      var finalAmount = amount - physicalDefense
      if finalAmount < 0 {
        finalAmount = 0
      }
      print("\(name) weakened! \(finalAmount) damage dealt to \(name)!")
      health -= finalAmount
    }
  }

  func magicalAttacked(amount: Int) {
    let chanceToDodge = Int.random(in: 1...11)
    if chanceToDodge == 1 {
        print("\(name) dodged your attack!")
    } else {
      var finalAmount = amount - magicalDefense
      if finalAmount < 0 {
        finalAmount = 0
      }
      print("\(name) weakened! \(finalAmount) damage dealt to \(name)!")
      health -= finalAmount
    }
  }

  func checkDead()->Bool {
    if health <= 0 {
      defeated = true
      return true
    } else {
      return false
    }
  }

  func turnAttack(blocked: Bool)->Int {
    let chanceBoosted = Int.random(in: 1...21)
    if chanceBoosted == 1 {
      if blocked {
        print("\(name) boosted their attack! Damage is Doubled! But you used Shield to Block! \(name) has dealt 0 damage to you!")
        return 0
      } else {
        print("\(name) boosted their attack! Damage is Doubled! \(name) has dealt \(attack*2) damage to you!")
        return attack*2
      }
    } else {
      if blocked {
        print("You used Shield to Block! \(name) has dealt 0 damage to you!")
        return 0
      } else {
        print("\(name) has dealt \(attack) damage to you!")
        return attack
      }
    }
  }

  func checkVitalsAndStats() {
    print("🧌 \(attribute)")
    print("😈 Name: \(name)")
    print("😈 Health: \(health)/\(currHealth) \n")
    print("🛡️ Physical Defense: \(physicalDefense)")
    print("🛡️ Magical Defense: \(magicalDefense)")
    print("🗡️ Attack: \(attack)\n")
  }

}
