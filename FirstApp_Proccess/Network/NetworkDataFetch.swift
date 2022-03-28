//
//  NetworkDataFetch.swift
//  FirstApp_Proccess
//
//  Created by Александр Старков on 14.02.2022.
//

import Foundation

class NetworkDataFetch {
    static let shared = NetworkDataFetch()
    private init() {}
    
    func fetchWeather(responce: @escaping(Weather?, Error?) -> Void) {
        NetworkRequest.shared.requestData { result  in
            switch result {
            case .success(let data): //если дата есть передаем ее в success
                do {
                    let weatherModel = try JSONDecoder().decode(WeatherModel.self, from: data) // и из success пробуем декодировать в WeatherModel
                    guard let weather = Weather(weatherModel: weatherModel) else { return }
                    print(weather)
                    responce(weather, nil) //есть данные, ошибка нил (возвращаем погоду)
                } catch {
                    print("Failed to decode JSON") //Если не удалось возвратить)
                }
            case .failure(let error): //если ошибка
                print("Error \(error.localizedDescription)")
                responce(nil, error) //данных нил, ошибка ошибка
            }
        }
    }
}
