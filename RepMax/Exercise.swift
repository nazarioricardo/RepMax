//
//  Exersise.swift
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

struct Exercise {
    
    var name = ""
    var sessions: [Session] = []
    var currentOneRepMax = 0

    init(name: String, firstWorkout: Session, oneRepMax: Int) {
        self.name = name
        self.sessions.append(firstWorkout)
        self.currentOneRepMax = oneRepMax
    }
    
    mutating func addNewSession(session: Session) {
        if !sessions.contains(session) {
            sessions.append(session)
            // print("Current session \(session.date)")
            currentOneRepMax = session.oneRepMax
        }
    }
}
