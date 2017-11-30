//
//  WorkoutStruct.swift
//  OneRep
//
//  Created by Ricardo Nazario on 11/29/17.
//  Copyright © 2017 Ricardo Nazario. All rights reserved.
//

import Foundation

/*
 Workouts represent a session:
 Doing 3 sets of 15 reps of pushups on December 1st
 
 Exersises represent the overall category of 'pushups' or 'pullups' etc.
 */

struct Session {
    
    var date: Date!
    var exerciseName: String = ""
    var sets = 0
    var reps = 0
    var weight: Int = 0
    var oneRepMax: Int = 0
    
    init(date: Date, exerciseName: String, sets: Int, reps: Int, weight: Int) {
        self.date = date
        self.exerciseName = exerciseName
        self.sets = sets
        self.reps = reps
        self.weight = weight
        self.oneRepMax = dataManager.calculateOneRepMax(weight: weight, repititions: reps)
    }
    
}

extension Session: Equatable {
    static func ==(lhs: Session, rhs: Session) -> Bool {
        return lhs.date == rhs.date && lhs.exerciseName == rhs.exerciseName
    }
}
