//
//  Events.swift
//  NYU Fitness Challenge
//
//  Created by William  Uchegbu on 6/21/18.
//  Copyright © 2018 William Uchegbu. All rights reserved.
//

import Foundation

protocol  EnumCollection: Hashable {}
extension EnumCollection
{
    static func cases() -> AnySequence<Self>
    {
        typealias S = Self
        return AnySequence
            { () -> AnyIterator<S> in
                var raw = 0
                return AnyIterator
                    {
                        let current : Self = withUnsafePointer(to: &raw) { $0.withMemoryRebound(to: S.self, capacity: 1) { $0.pointee } }
                        guard current.hashValue == raw else { return nil }
                        raw += 1
                        return current
                }
        }
    }
}

enum Events: String, EnumCollection
{
    //typealias RawValue = String
    
    case Burpees = "Burpees"
    case Bike = "Bike"
    case FitnessTest = "Fitness Test"
    case Freethrow = "Freethrows"
    case Plank = "Plank"
    case PushUps = "Pushups"
    case RopePull = "Rope Pull"
    case Rowing = "Rowing"
    case ShuttleRun = "Shuttle Run"
    case Squats = "Squats"
    
}
