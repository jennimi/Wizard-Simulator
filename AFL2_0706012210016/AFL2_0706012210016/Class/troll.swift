//
//  troll.swift
//  AFL2_0706012210016
//
//  Created by MacBook Pro on 26/05/24.
//

import Foundation

class Troll: Monster {

  override init(name: String, level: Int) {
    super.init(name: name, level: level)

    self.physicalDefense = -10 + (2*self.level)
    self.magicalDefense = 10 + (2*self.level)
    self.attack = 10 + (4*self.level)
    self.attribute = "Trolls are known for their magical powers, and greed for money and items. They are also known for their treacherous nature, and their ability to inflict devastating wounds on their enemies."
  }

  override func magicalAttacked(amount: Int) {
    let chanceToDodge = Int.random(in: 1...11)
    if chanceToDodge <= 4 {
      print("\(name) deflected your magic!")
      return
    }

    var finalAmount = amount - magicalDefense
    if finalAmount < 0 {
      finalAmount = 0
    }
    print("\(name) is Strong against magic, \(finalAmount) damage dealt to \(name).")
    health -= finalAmount
  }

  func trollFlee(wizard: inout Wizard) {
    let potion = wizard.potion_amount
    let elixir = wizard.elixir_amount
    let chancetoSteal = Int.random(in: 1...11)
    if (potion > 0 && elixir > 0) {
      if chancetoSteal <= 4 {
        print("🐔 You fled the battle, but in the attempt to flee the battle, \(name) has stolen 1 potion and 1 elixir.")
        wizard.potion_amount -= 1
        wizard.elixir_amount -= 1
      } else {
        if (wizard.mp > 0 && chancetoSteal <= 3) {
          print("🐔 You successfully fled the battle. In the attempt to flee the battle, you wasted 50% of your MP.")
          wizard.mp -= Int(Double(wizard.mp) * 0.5)
        } else {
          print("🐔 You fled the battle.")
        }
      }
    } else {
      if (wizard.mp > 0 && chancetoSteal <= 7) {
        print("🐔 You successfully fled the battle. In the attempt to flee the battle, you wasted 50% of your MP.")
        wizard.mp -= Int(Double(wizard.mp) * 0.5)
      } else {
        print("🐔 You fled the battle.")
      }
    }
  }
}
