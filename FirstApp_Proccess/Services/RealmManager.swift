//
//  RealmManager.swift
//  FirstApp_Proccess
//
//  Created by Александр Старков on 22.01.2022.
//

import Foundation
import RealmSwift

class RealmManager {
    static let shared = RealmManager() //у экземпляров мы не сможем менять значения этого свойства
    private init() {}
    let localRealm  = try! Realm()
    func saveWorkoutModel(model: WorkoutModel) {//метод для для сохранения модели
        try! localRealm.write {
            localRealm.add(model)
        }
    }
    func updateStatusWorkoutModel(model: WorkoutModel, bool: Bool) {//метод для для обновления модели
        try! localRealm.write {
            model.status = bool
        }
   }
    func updateSetsRepsWorkoutModel(model: WorkoutModel, sets: Int, reps: Int) {//метод для для обновления модели
        try! localRealm.write {
            model.workoutSets = sets
            model.workoutReps = reps
        }
   }
    func updateSetsTaimerWorkoutModel(model: WorkoutModel, sets: Int, taimer: Int) {//метод для для обновления модели
        try! localRealm.write {
            model.workoutSets = sets
            model.workoutTimer = taimer
        }
   }
    func deleteWorkoutModel(model: WorkoutModel) {//метод для удаления модели
        try! localRealm.write {
            localRealm.delete(model)
        }
   }
   
    //ProfileModel
    
    func saveProfileModel(model: ProfileModel) {
        try! localRealm.write {
            localRealm.add(model)
        }
    }
    
    func updateProfileModel(model: ProfileModel) {
        let users = localRealm.objects(ProfileModel.self)

        try! localRealm.write {
            users[0].userFirstName = model.userFirstName
            users[0].userSecondName = model.userSecondName
            users[0].userHeight = model.userHeight
            users[0].userWeight = model.userWeight
            users[0].userTarget = model.userTarget
            users[0].userImage = model.userImage
        }
    }
}
