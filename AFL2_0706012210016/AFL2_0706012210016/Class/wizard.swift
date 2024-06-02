//
//  wizard.swift
//  AFL2_0706012210016
//
//  Created by MacBook Pro on 26/05/24.
//

import Foundation

struct Wizard {
  var name: String
  var hp = 100
  var totalhp = 100
  var mp = 50
  var totalmp = 50
  var potion_amount = 10
  var elixir_amount = 5
  var physical_attack = 5
  var magical_attack = 50
  var dead = false
  var monstersDefeated = 0
  var level = 1

  func playerStats() {
    print("======= Wizard Stats =======")
    print("Player name: \(name) \t Level \(level)\n")
    print("HP: \(hp)/\(totalhp)")
    print("MP: \(mp)/\(totalmp) \n")
    print("Magic:")
    print("- Physical Attack. No mana required. Deal \(physical_attack)pt of damage.")
    print("- Meteor. Use \(magical_attack)pt of MP. Deal 50pt of damage.")
    print("- Shield. Use 10pt of MP. Block enemy's attack in 1 turn. \n")
    print("Items:")
    print("- Potion x\(potion_amount). Heal 20pt of your HP.")
    print("- Elixir x\(elixir_amount). Add 10pt of your MP. \n")
    print("============================")
  }

  func recap() {
    print("======= Wizard Recap =======")
    print("\(name), you have reached Level \(level)\n")
    print("With a total of \(monstersDefeated) Monsters Defeated.")
    print("============================")
  }

  func show() {
    print("HP: \(hp)/\(totalhp)")
    print("MP: \(mp)/\(totalmp)")
  }

  func hasPotions()-> Bool {
    return potion_amount > 0
  }

  func healWoundStats() {
    print("Your HP is \(hp).")
    print("You have \(potion_amount) Potions. \n")
  }

  mutating func healWound() {
    hp += 20
    if (hp > 100) {
      hp = 100
    }
    potion_amount -= 1

    print("Your HP is now: \(hp)")
    print("You have \(potion_amount) Potion left.")
  }

  mutating func attacked(amount: Int) {
    hp -= amount
    if (hp <= 0) {
      dead = true
    }
  }

  mutating func useMana(amount: Int)-> Bool {
    if (mp < amount) {
      return false
    } else {
      mp -= amount
      return true
    }
  }

  mutating func defeatedMonster() {
    monstersDefeated += 1
    let standard = power(base: 2, exponent: level)
    if standard == monstersDefeated {
      level += 1
      levelUp()
    }
  }

  mutating func getRewards(potion: Int, elixir: Int) {
    potion_amount += potion
    elixir_amount += elixir
  }

  // the pow() don't work for some reason so i made a function
  func power(base: Int, exponent: Int) ->Int {
      var result: Int = 1
      for _ in 1...exponent {
          result *= base
      }
      return result
  }

  mutating func levelUp() {
    print("🆙🆙 You have leveled up! You are now level \(level)!")
    print("You received : ")
    let potion = 2*level
    let elixir = 3*level
    let addhealth = 20*level
    let addmana = 10*level
    let addPhyiscal = 5*level
    let addMagical = 10*level

    potion_amount += potion
    elixir_amount += elixir
    hp += addhealth; totalhp += addhealth
    mp += addmana; totalmp += addmana
    physical_attack += addPhyiscal
    magical_attack += addMagical
    
    print("\t🎁 \(potion) Potions")
    print("\t🎁 \(elixir) Elixirs")
    print("\t🔼 \(addhealth) HP, total of \(hp)/\(totalhp)")
    print("\t🔼 \(addmana) MP, total of \(mp),\(totalmp)")
    print("\t🔼 \(addPhyiscal) Physical Attack, total of \(physical_attack)")
    print("\t🔼 \(addMagical) Magical Attack, total of \(magical_attack)")
  }
}
