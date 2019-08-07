//
//  main.swift
//  structs-vs-classes
//
//  Created by ArronStudio on 2019-08-06.
//  Copyright © 2019 AaronStudio. All rights reserved.
//

import Foundation

var hero = Superhero(name: "Iron Man", universe: "marvel")
var anotherHero = hero
anotherHero.name = "The Hulk"

// another class feature is it's not true immutable, struct can't do this
let hero3 = Superhero(name: "Iron Man", universe: "marvel")
hero3.name = "new"
print(hero3.name)

print(hero.name)
print(anotherHero.name)

var hero2 = SuperheroStuct(name: "A", universe: "m")
var anotherHero2 = hero2

anotherHero2.name = "The Hulk"

print(hero2.name)
print(anotherHero2.name)
