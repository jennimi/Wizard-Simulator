//
//  game.swift
//  AFL2_0706012210016
//
//  Created by MacBook Pro on 26/05/24.
//

import Foundation

struct Game {

  mutating func startGame() {
    print("Welcome to the world of magic! 🧙🏻‍♀️\n")
    print("You have been chosen to embark on an epic journey as a young wizard on the path to becoming a master of the arcane arts. Your adventure will take you through forests, mountains, and dungeons, where you will face challenges, make allies, and fight enemies.")
    print("")
    checkReturn()

    var nameloop: Bool = false
    var name: String = ""
    while !nameloop {
      print("May I know your name, a young wizard? ", terminator: "")
      name = readLine() ?? "x"

      nameloop = checkString(string: name)
    }

    var wizard = Wizard(name: name)
    print("")
    journeyScreen(wizard: &wizard)
  }

  mutating func journeyScreen(wizard: inout Wizard) {
    var choice: String

    repeat {
      print("=================================")
      print("From here, you can... \n")
      print("[C]heck your health and stats")
      print("[H]eal your wounds with potion \n")
      print("...or choose where you want to go \n")
      print("[F]orest of Troll")
      print("[M]ountain of Golem")
      print("[Q]uit game \n")
      print("Your choice ? ", terminator: "")
      choice = readLine() ?? ""
      print("")
      switch choice.lowercased() {
        case "c":
          wizard.playerStats()
          checkReturn()
        break

        case "h":
          choiceHealWounds(wizard: &wizard)
        break

        case "f":
          forestOfTroll(wizard: &wizard)
        break

        case "m":
          mountainOfGolem(wizard: &wizard)
        break

        case "q":
          wizard.recap()
          print("Journey completed. See you around wizard.")
        break

        default:
        print("Invalid choice. Please try again.\n")
      }

      if (wizard.dead) {
        print("Sadly, this is the end of your journey. Here's the recap of your adventure..")
        wizard.recap()
        print("")
        break
      }

    } while !(choice == "q")

  }

  mutating func choiceHealWounds(wizard: inout Wizard) {
    if (wizard.hasPotions()) {
      wizard.healWoundStats()
      print("Are you sure you want to use 1 potion to heal wounds? [Y/N] ", terminator: "")
      let choice = (readLine() ?? "").lowercased()
      if choice == "y" {
        wizard.healWound()

        var healAgain: Bool = true
        while (healAgain) {
          print("\nStill want to use 1 potion to heal wound again? [Y/N] ", terminator: "")
          let choiceagain = (readLine() ?? "").lowercased()
          if choiceagain == "y" {
            wizard.healWound()
          } else if choiceagain == "n" {
            healAgain = false
            print("Okay, let's go back to the journey.\n")
          } else {
            print("Invalid choice. Please try again.\n")
          }
        }
      } else {
        print("Okay, let's go back to the journey.\n")
      }
    }
  }

  mutating func showStatRounds(wizard: Wizard, monster: Monster, round: Int) {
    print("")
    print("== Enemy ! ========")
    monster.show()
    print("===================")
    print("== You ! ==========")
    wizard.show()
    print("===================")
    print("Round : \(round) \n")
  }

  mutating func physicalAttack(monster: Monster, wizard: inout Wizard, blocking: inout Bool) {
    monster.physicalAttacked(amount: wizard.physical_attack)
    if !monster.checkDead() {
      let damage = monster.turnAttack(blocked: blocking)
      if damage == 0 {
        blocking = false
      } else {
        wizard.attacked(amount: damage)
      }
    }
  }

  mutating func meteor(monster: Monster, wizard: inout Wizard, blocking: inout Bool) {
    if wizard.useMana(amount: 15) {
        monster.magicalAttacked(amount: wizard.magical_attack)
      } else {
        print("❌ You tried to cast Meteor. But due to your lack of mana, only a small gush of wind burst out.")
      }
    if !monster.checkDead() {
      let damage = monster.turnAttack(blocked: blocking)
      if damage == 0 {
       blocking = false
      }
      wizard.attacked(amount: damage)
    }
  }

  mutating func shield(monster: Monster, wizard: inout Wizard, blocking: inout Bool) {
    if wizard.useMana(amount: 10) {
      blocking = true
    } else {
      print("❌ You tried to cast Shield. But due to your lack of mana, shield disappeared.")
    }

    let damage = monster.turnAttack(blocked: blocking)
    if damage == 0 {
      blocking = false
    }
    wizard.attacked(amount: damage)
  }

  mutating func forestOfTroll(wizard: inout Wizard) {
    let troll = Troll(name: "Troll", level: wizard.level)
    print("As you enter the forest, you feel a sense of unease wash over you.")
    print("🧌 Suddenly, you hear the sound of twigs snapping behind you. You quickly spin around, and find a Troll emerging from the shadows.\n")

    var round: Int = 0

    var flee: Bool = false
    while(!troll.defeated && !wizard.dead && !flee) {
      var blocking: Bool = false

      showStatRounds(wizard: wizard, monster: troll, round: round)
      fightAction()
      print("Your choice? ", terminator: "")
      let choice = readLine() ?? ""
      print("")
      switch choice.lowercased() {
        case "1":
          physicalAttack(monster: troll, wizard: &wizard, blocking: &blocking)
          round += 1
        break

        case "2":
          meteor(monster: troll, wizard: &wizard, blocking: &blocking)
          round += 1

        break

        case "3":
          shield(monster: troll, wizard: &wizard, blocking: &blocking)
          round += 1

        break

        case "4":
          choiceHealWounds(wizard: &wizard)
        break

        case "5":
          print("Scanning vitals and stats of \(troll.name) ...")
          troll.checkVitalsAndStats()
        break

        case "6":
          print("Are you sure you want to flee the battle? (Y/N)", terminator: "")
          let choice = (readLine() ?? "").lowercased()
          if choice == "n" {
            print("You decided to stay and fight.\n")
          } else {
            print("Fleeing the battle, you turned and ran away as fast as you can. \(troll.name) chased you, panicking you. ")
            troll.trollFlee(wizard: &wizard)
            flee = true
          }

        break

        default:
          print("Invalid choice. Please try again.\n")
        break
      }
    }
    print("")
    
    if (troll.defeated) {
      defeatMonster(monster: troll, wizard: &wizard)
    } else if (wizard.dead) {
      print("Your body falls to the ground, as the last drop of blood drips from your chest. You have died.")
    }
  }

  mutating func defeatMonster(monster: Monster, wizard: inout Wizard) {
    let level = monster.level
    let potion = 1*level
    let elixir = 2*level
    print("🎉🎉 You have defeated a Level \(level) \(monster.name)!")
    print("You received : ")
    print("\t🎁 \(potion) Potions")
    print("\t🎁 \(elixir) Elixirs\n")
    wizard.getRewards(potion: potion, elixir: elixir)
    wizard.defeatedMonster()
  }

  mutating func mountainOfGolem(wizard: inout Wizard) {
    let golem = Golem(name: "Golem", level: wizard.level)
    print("As you make your way through the rugged mountain terrain, you can feel the chill of the wind biting at your skin.\nSuddenly, you hear a sound that makes you freeze in your tracks. \n🗿 That's when you see it - a massive, snarling Golem emerging from the shadows.\n")

    var round: Int = 0

    var flee: Bool = false
    while(!golem.defeated && !wizard.dead && !flee) {
      var blocking: Bool = false

      showStatRounds(wizard: wizard, monster: golem, round: round)
      fightAction()
      print("Your choice? ", terminator: "")
      let choice = readLine() ?? ""
      switch choice.lowercased() {
        case "1":
          physicalAttack(monster: golem, wizard: &wizard, blocking: &blocking)
          round += 1
        break

        case "2":
          meteor(monster: golem, wizard: &wizard, blocking: &blocking)
          round += 1

        break

        case "3":
          shield(monster: golem, wizard: &wizard, blocking: &blocking)
          round += 1

        break

        case "4":
          choiceHealWounds(wizard: &wizard)
        break

        case "5":
          print("Scanning vitals and stats of \(golem.name) ...")
          golem.checkVitalsAndStats()
        break

        case "6":
          print("Are you sure you want to flee the battle? (Y/N) ", terminator: "")
          let choice = (readLine() ?? "").lowercased()
          if choice == "n" {
            print("You decided to stay and fight.\n")
          } else if choice == "y" {
            print("Fleeing the battle, you turned and ran away as fast as you can. \(golem.name) chased you, panicking you. ")
            flee = golem.golemFlee(wizard: &wizard)
          } else {
            print("Invalid Option. Going Back to Menu...")
          }

        break

        default:
          print("Invalid choice. Please try again.\n")
        break
      }
    }

    if (golem.defeated) {
      defeatMonster(monster: golem, wizard: &wizard)
    } else if (wizard.dead) {
      print("Your body falls to the ground, as the last drop of blood drips from your chest. You have died.")
    }
    print("\n==============================\n")
  }

  func fightAction() {
    print("Choose your action:")
    print("[1] Physical Attack. No mana required. Deal 5pt of damage.")
    print("[2] Meteor. Use 15pt of MP. Deal 50pt of damage.")
    print("[3] Shield. Use 10pt of MP. Block enemy's attack in 1 turn.\n")
    print("[4] Use Potion to heal wound.")
    print("[5] Scan enemy's vital.")
    print("[6] Flee from battle.\n")
  }

  func checkString(string: String)-> Bool {
    if string == "" {
      return false
    }
    for character in string {
      if !("a"..."z" ~= character || "A"..."Z" ~= character) {
        if character != " " {
          return false
        }
      }
    }
    return true
  }

  func checkReturn() {
    var startloop: Bool = false
    while !startloop {
      print("Press [return] to continue : ", terminator: "")
      let input = readLine() ?? "x"
      if input == "" {
        startloop = true
      }
    }
    print("")
  }
}
