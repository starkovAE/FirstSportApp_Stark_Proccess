//
//  WorkoutModel.swift
//  FirstApp_Proccess
//
//  Created by Александр Старков on 22.01.2022.
//

import Foundation
import RealmSwift


class WorkoutModel: Object {
@Persisted var workoutDate: Date
@Persisted var workoutNumberOfDay: Int = 0
@Persisted var workoutName: String = "Unknow"
@Persisted var workoutRepeat: Bool = true // изначально свитч стоит в тру
@Persisted var workoutSets: Int = 0
@Persisted var workoutReps: Int = 0
@Persisted var workoutTimer: Int = 0
@Persisted var workoutImage: Data?
@Persisted var status: Bool = false //когда мы будем нажимать финиш, нам нужно понять нужно менять кнопку старт на комплит
}
