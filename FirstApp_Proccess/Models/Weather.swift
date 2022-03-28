//
//  Weather.swift
//  FirstApp_Proccess
//
//  Created by Александр Старков on 17.02.2022.
//

import Foundation

struct Weather {
    var temperture: Int
    var iconCode: String
    var url: String
    var condition: String
    var pressureMm: Int
    var windSpeed: Double
    
    var conditionString: String {
        switch condition {
                    case "clear":             return "Ясно"
                    case "partly-cloudy":      return "Малооблачно"
                    case "cloudy":              return "Облачно с прояснениями"
                    case "overcast":             return "Пасмурно"
                    case "drizzle":                return "Морось"
                    case "light-rain":               return "Небольшой дождь"
                    case "rain":                      return "Дождь"
                    case "moderate-rain":                return "Умеренно сильный дождь"
                    case "heavy-rain":                    return "Сильный дождь"
                    case "continuous-heavy-rain":           return "Длительно сильный дождь"
                    case "showers":                            return "Ливень"
                    case "wet-snow":                           return "Дождь со снегом"
                    case "light-snow":                          return "Небольшой снег"
                    case "snow":                                  return "Снег"
                    case "snow-showers":                            return "Снегопад"
                    case "hail":                                      return "Град"
                    case "thunderstorm":                                return "Гроза"
                    case "thunderstorm-with-rain":                        return "Дождь с грозой"
                    case "thunderstorm-with-hail":                          return "Гроза с градом"
        default:
            return "Загрузка"
        }
    }
    var conditionStringTraning: String {
        switch condition {
                    case "clear":             return "Прекрасная погода, чтобы сделать тренировку"
                    case "partly-cloudy":      return "Пора провести тренировку на улице!"
                    case "cloudy":              return "Улица ждет тебя, успевай скорей"
                    case "overcast":             return "Спасибо, что не дождь! Можно успеть выполнить тренировку на улице"
                    case "drizzle":                return "В дождивике норм, можно и потренить"
                    case "light-rain":               return "Танки грязи не боятся"
                    case "rain":                      return "Выполни тренировку дома!"
                    case "moderate-rain":                return "Выполни тренировку домаь"
                    case "heavy-rain":                    return "Выполни тренировку дома"
                    case "continuous-heavy-rain":           return "Выполни тренировку дома"
                    case "showers":                            return "Возможно затопление, тренируйся дома"
                    case "wet-snow":                           return "Будь осторожен, тренеруйся лучше дома"
                    case "light-snow":                          return "Прекранасная погода, чтобы позаниматься на улице"
                    case "snow":                                  return "Прекранасная погода, чтобы позаниматься на улице"
                    case "snow-showers":                            return "Прекранасная погода, чтобы позаниматься на улице"
                    case "hail":                                      return "Выполни тренировку дома"
                    case "thunderstorm":                                return "Выполни тренировку дома"
                    case "thunderstorm-with-rain":                        return "Выполни тренировку дома"
                    case "thunderstorm-with-hail":                          return "Выполни тренировку дома"
        default:
            return "Загрузка"
        }
    }
    
    init?(weatherModel: WeatherModel) { //опциональный так как данных может не быть
        temperture = weatherModel.fact.temp
        iconCode = weatherModel.fact.icon
        url = weatherModel.info.url
        condition = weatherModel.fact.condition
        pressureMm = weatherModel.fact.pressureMm
        windSpeed = weatherModel.fact.windSpeed
    }
}
