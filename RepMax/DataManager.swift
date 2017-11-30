//
//  RepManager.swift
//  OneRep
//
//  Created by Ricardo Nazario on 11/28/17.
//  Copyright © 2017 Ricardo Nazario. All rights reserved.
//

import Foundation

let dataManager = DataManager.sharedInstance

typealias ParseCompletionHandler = (_ exercises: [Exercise]?, _ error: Error?) -> Void

protocol ListDelegate {
    // For updating table view in inital view controller
    func setExercises(exercises: [Exercise])
}

protocol ChartDelegate {
    // For setting chart data points
    func setDataPoints(dataPoints: [[Int]])
}

class DataManager {
    
    static let sharedInstance = DataManager()
    
    let parseQueue = DispatchQueue(label: "parseQueue")
    
    var listDelegate: ListDelegate? {
        didSet {
            parseQueue.async {
                self.parseWorkoutData { (exercises, error) in
                    if let fetchedExercises = exercises {
                        self.exercises = fetchedExercises
                    }
                }
            }
        }
    }
    
    var chartDelegate: ChartDelegate?

    var exercises: [Exercise]? {
        didSet {
            print("Exercises did set")
            listDelegate?.setExercises(exercises: exercises!)
        }
    }
    
    private func parseWorkoutData(with block: ParseCompletionHandler) {
        if let path = Bundle.main.path(forResource: "workoutData", ofType: "txt") {
            do {
                let data = try String(contentsOfFile: path, encoding: .utf8)
                let workoutStrings = data.components(separatedBy: .newlines).reversed() as [String]
                
                var workouts: [Session] = []
                var tempExerciseArray: [Exercise] = []
                
                for workout in workoutStrings {
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "MM/dd/yy"
                    let workoutData = workout.components(separatedBy: ",")
                    
                    //  'if let' avoids erroneous strings
                    if let newDate: Date = dateFormatter.date(from: workoutData[0]) {
                        
                        let newWorkout = Session(date: newDate, exerciseName: workoutData[1], sets: Int(workoutData[2])!, reps: Int(workoutData[3])!, weight: Int(workoutData[4])!)
                        
                        if let index = workouts.index(of: newWorkout) {
                            if newWorkout.oneRepMax > workouts[index].oneRepMax {
                                workouts[index] = newWorkout
                            }
                        } else {
                            workouts.append(newWorkout)
                        }
                        
                        // Check if exercises array contains exercise.
                        if let index = tempExerciseArray.index(where: {$0.name == newWorkout.exerciseName}) {

                            // If true, get exercise and add session, set new one rep max.
                            tempExerciseArray[index].addNewSession(session: newWorkout)
                        } else {

                            // If false, init new exercise, with first workout, and set one rep max
                            let newExercise = Exercise(name: newWorkout.exerciseName,
                                                       firstWorkout: newWorkout)

                            // Add to exercises array
                            tempExerciseArray.append(newExercise)
                        }
                    }
                }
                exercises = tempExerciseArray
                print(workouts.count)
            } catch {
                block(nil, error)
            }
        }
        block(exercises, nil)
    }
    
    func calculateOneRepMax(weight: Int, repititions: Int) -> Int {
        let denominator = Float(37 - repititions)
        let right = Float(36 / denominator)
        let result = Float(weight) * right
        return Int(result)
    }
    
    func setChartDataPoints(for exercise: Exercise) {
        let xValues = exercise.sessions.map({
            Int($0.date.timeIntervalSince1970)
        })
        let yDataPoints = exercise.sessions.map({ (workout) -> Int in
            workout.oneRepMax
        })
        
        let xDataPoints = xValues.map({ $0 - xValues.first! })
        chartDelegate?.setDataPoints(dataPoints: [xDataPoints, yDataPoints])
    }
}
