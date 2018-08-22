//
//  Event.swift
//  NYU Fitness Challenge
//
//  Created by William  Uchegbu on 6/21/18.
//  Copyright © 2018 William Uchegbu. All rights reserved.
//

import Foundation
import UIKit

extension Collection
{
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Iterator.Element?
    {
        return indices.contains(index) ? self[index] : nil
    }
}

extension Set
{
    public mutating func insertOrReplace(_ element: Element)
    {
        if self.contains(element)
        {
            self.remove(element)
            self.insert(element)
        }
        else
        {
            self.insert(element)
        }
    }
}

extension Collection
{
    var isNotEmpty: Bool { return !self.isEmpty }
}

class Event {
    var name: String = ""
    var icon: UIImage?
    var muscleGroups: [String] = []
    var instructions: String = ""
    
    init() {
    }
    
    init(eventName: String){
        switch eventName {
        case "burpees":
            self.name = "Burpees"
            self.muscleGroups = ["Shoulders", "Hamstrings, Quadriceps, & Hip Flexors", "Abdominals", "Glutes", "Erector Spinae"]
            self.instructions = "burpees"
            self.icon = #imageLiteral(resourceName: "burpee")
        case "bike":
            self.name = "Bike"
            self.muscleGroups = ["Glutes", "Calves", "Quadriceps", "Hip Flexors", "Hamstrings", "Abs"]
            self.instructions = "bike"
            self.icon = #imageLiteral(resourceName: "bike")
        case "fitness test":
            self.name = "Fitness Test"
            self.instructions = "challengeVideo"
            self.icon = #imageLiteral(resourceName: "test")
        case "freethrow":
            self.name = "Freethrow"
            self.muscleGroups = ["Shoulders", "Forearms", "Biceps", "Triceps"]
            self.instructions = "freethrow"
            self.icon = #imageLiteral(resourceName: "free throw")
        case "plank":
            self.name = "Plank"
            self.muscleGroups = ["Rectus abdominus", "Transverse abdominus", "Obliques", "Glutes"]
            self.instructions = "plank"
            self.icon = #imageLiteral(resourceName: "plank")
        case "pushups":
            self.name = "Push Ups"
            self.muscleGroups = [" Pectoral muscles", "Anterior Deltoid", "Biceps", "Triceps", "Rhomboids", "Lats"]
            self.instructions = "pushups"
            self.icon = #imageLiteral(resourceName: "pushup")
        case "rope pull":
            self.name = "Rope Pull"
            self.muscleGroups = ["Biceps", "Shoulders", "Forearms", "Abdominals", "Back"]
            self.instructions = "rope machine"
            self.icon = #imageLiteral(resourceName: "rope")
        case "rowing":
            self.name = "Rowing"
            self.muscleGroups = ["Erector Spinae", "Biceps", "Abs", "Triceps", "Rhomboids"]
            self.instructions = "row machine"
            self.icon = #imageLiteral(resourceName: "row")
        case "shuttle run":
            self.name = "Shuttle Run"
            self.muscleGroups = ["Rectus Femoris", "Calves", "Leg/Hamstrings", "Hip Flexors"]
            self.instructions = "shuttle run"
            self.icon =  #imageLiteral(resourceName: "shuttle")
        case "squats":
            self.name = "Squats"
            self.muscleGroups = ["Quadriceps", "Calves", "Hamstrings"]
            self.instructions = "squats"
            self.icon = #imageLiteral(resourceName: "squat")
        case "freethrows":
            self.name = "Freethrow"
            self.muscleGroups = ["Shoulders", "Forearms", "Biceps", "Triceps"]
            self.instructions = "freethrow"
            self.icon = #imageLiteral(resourceName: "free throw")
        default:
            print ("Error: Improper parameters when initializing event")
            return
        }
    }
}

extension Event: DictionaryRep
{
    
}

extension Event: Hashable, Equatable
{
    public static func ==(lhs: Event, rhs: Event) -> Bool
    {
        return lhs.name == rhs.name
    }
    
    public var hashValue: Int
    {
        return self.name.hashValue
    }
}
