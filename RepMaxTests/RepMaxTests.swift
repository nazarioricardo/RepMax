//
//  RepMaxTests.swift
//  RepMaxTests
//
//  Created by Ricardo Nazario on 11/29/17.
//  Copyright © 2017 Ricardo Nazario. All rights reserved.
//

import XCTest
@testable import RepMax

class RepMaxTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testAddNewSession() {
        
        let firstSession = Session(date: Date(), exerciseName: "Bench Press", sets: 1, reps: 4, weight: 225)
        var exercise = Exercise(name: "Bench Press",
                                firstWorkout: firstSession)
        let secondSession = Session(date: Date(),
                                    exerciseName: "Bench Press",
                                    sets: 1,
                                    reps: 1,
                                    weight: 100)
        
        exercise.addNewSession(session: secondSession)
        
        XCTAssertEqual(exercise.sessions.count, 2)
        XCTAssertEqual(exercise.highestOneRepMax, firstSession.oneRepMax)
    }
    
    func testBrzycki() {
        let reps = 4
        let weight = 225
        let oneRepMax = dataManager.calculateOneRepMax(weight: weight, repititions: reps)
        
        // 245 obtained from doing the calculation manually. (Not best testing practice but I knew something was off.
        XCTAssertEqual(oneRepMax, 245)
    }
        
}
