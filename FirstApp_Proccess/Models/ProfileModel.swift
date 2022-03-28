//
//  ProfileModel.swift
//  FirstApp_Proccess
//
//  Created by Александр Старков on 02.02.2022.
//

import Foundation
import RealmSwift

class ProfileModel: Object {
    @Persisted var userFirstName: String = "Unknow"
    @Persisted var userSecondName: String = "Unknow"
    @Persisted var userHeight: Int = 0
    @Persisted var userWeight: Int = 0
    @Persisted var userTarget: Int = 0
    @Persisted var userImage: Data?
}

