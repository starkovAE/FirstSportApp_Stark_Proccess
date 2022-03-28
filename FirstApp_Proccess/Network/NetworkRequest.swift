//
//  NetworkRequest.swift
//  FirstApp_Proccess
//
//  Created by Александр Старков on 14.02.2022.
//

import Foundation


class NetworkRequest {
    
    static let shared = NetworkRequest()
    private init() {}
    
    func requestData(completion: @escaping(Result<Data, Error>) -> Void){ //метод при помощи, которого будем делать запрос
        let key = "6305e9b6-e4e7-41bf-8cb3-52543888f709"
        let latidude = 58.02968
        let longitude = 56.26679

        
        let urlString = "https://api.weather.yandex.ru/v2/forecast?lat=\(latidude)&lon=\(longitude)"
        guard let url = URL(string: urlString) else { return } //получаем url
        var request = URLRequest(url: url, timeoutInterval: Double.infinity)
        request.addValue(key, forHTTPHeaderField: "X-Yandex-API-Key")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, responce, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                completion(.success(data))
//                print("КОПИРОВАТЬ ОТ СЮДА:                " +  String(data: data, encoding: .utf8)!)
        }
            
    }
   task.resume()
 }
}

// URLSession.shared.dataTask(with: url) { data, responce, error in
//            DispatchQueue.main.async { //все данные мы должны получать в асинхронном режиме
//                if let error = error { //елси ошибка не нил, значит она есть
//                    completion(.failure(error)) //у резалт есть два значения failure и success
//                    return
//                }
//                guard let data = data else { return } // если можем получить данные
//                completion(.success(data))//то будем ее передавать в success
////                print(String(data: data, encoding: .utf8))
//            }
//
//        }
