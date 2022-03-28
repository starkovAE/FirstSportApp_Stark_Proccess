//
//  Int + Extentions.swift
//  FirstApp_Proccess
//
//  Created by Александр Старков on 04.02.2022.
//

import Foundation

extension Int {
    func convertSecond() -> (Int, Int) {
        let min = self / 60
        let sec = self % 60
        return (min, sec)
    }
    func setZeroForSeconds() -> String { //наше значение, которое у нас есть  в инте
        return (Double(self) / 10.0 < 1 ? "0\(self)" : "\(self)") //если число допустип 5 делится на 10 и оно больше одного (5/10 = 0.5 < 1, значит выполняется  "0\(self)" , если было бы больше тогда: "\(self)"
    }
}
