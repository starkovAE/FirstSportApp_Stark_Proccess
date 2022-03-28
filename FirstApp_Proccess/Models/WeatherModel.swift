//
//  WeatherModel.swift
//  FirstApp_Proccess
//
//  Created by Александр Старков on 14.02.2022.
//

import Foundation

struct WeatherModel: Decodable { //данные мы будем декодировать (расшифровывать), для правильного декодирования json
    let fact: Fact
    let info: Info
}
struct Info: Decodable {
    let url: String
}

struct Fact: Decodable {
    let temp: Int
    let icon: String
    let condition: String
    let windSpeed: Double
    let pressureMm: Int
    enum CodingKeys: String, CodingKey {
        case temp
        case icon
        case condition
        case windSpeed = "wind_speed"
        case pressureMm = "pressure_mm"
    }


}
//clear — ясно.
//partly-cloudy — малооблачно.
//cloudy — облачно с прояснениями.
//overcast — пасмурно.
//drizzle — морось.
//light-rain — небольшой дождь.
//rain — дождь.
//moderate-rain — умеренно сильный дождь.
//heavy-rain — сильный дождь.
//continuous-heavy-rain — длительный сильный дождь.
//showers — ливень.
//wet-snow — дождь со снегом.
//light-snow — небольшой снег.
//snow — снег.
//snow-showers — снегопад.
//hail — град.
//thunderstorm — гроза.
//thunderstorm-with-rain — дождь с грозой.
//thunderstorm-with-hail — гроза с градом.

//    var iconLocal: String {
//        switch icon {
//        case "clear": return "ясно"
//        case "partly-cloudy": return "малооблачно"
//        case "cloudy": return "облачно с прояснениями"
//        case "overcast": return "пасмурно"
//        case "drizzle": return "морось"
//        case "light-rain": return "небольшой дождь"
//        case "rain": return "дождь"
//        case "moderate-rain": return "умеренно сильный дождь"
//        case "heavy-rain": return "сильный дождь"
//        case "continuous-heavy-rain": return "длительно сильный дождь"
//        case "showers": return "ливент"
//        case "wet-snow": return "дождь со снегом"
//        case "light-snow": return "небольшой снег"
//        case "snow": return "снег"
//        case "snow-showers": return "снегопад"
//        case "hail": return "град"
//        case "thunderstorm": return "гроза"
//        case "thunderstorm-with-rain": return "дождь с грозой"
//        case "thunderstorm-with-hail": return "гроза с градом"
//        default: return "No data"
//        }
//    }
//    var conditionLocal: String {
//        switch icon {
//        case "clear": return "ясно"
//        case "partly-cloudy": return "малооблачно"
//        case "cloudy": return "облачно с прояснениями"
//        case "overcast": return "пасмурно"
//        case "drizzle": return "морось"
//        case "light-rain": return "небольшой дождь"
//        case "rain": return "дождь"
//        case "moderate-rain": return "умеренно сильный дождь"
//        case "heavy-rain": return "сильный дождь"
//        case "continuous-heavy-rain": return "длительно сильный дождь"
//        case "showers": return "ливент"
//        case "wet-snow": return "дождь со снегом"
//        case "light-snow": return "небольшой снег"
//        case "snow": return "снег"
//        case "snow-showers": return "снегопад"
//        case "hail": return "град"
//        case "thunderstorm": return "гроза"
//        case "thunderstorm-with-rain": return "дождь с грозой"
//        case "thunderstorm-with-hail": return "гроза с градом"
//        default: return "No data"
//        }
//    }
//enum Condition: String, Decodable {
//    case clear = "ясно"
//    case partlyCloudy = "малооблачно"
//    case cloudy = "облачно с прояснениями"
//    case overcast = "пасмурно"
//    case drizzle = "морось"
//    case lightRain = "небольшой дождь"
//    case rain =  "дождь"
//    case moderateRain = "умеренно сильный дождь"
//    case heavyRain = "сильный дождь"
//    case continuousHeavyRain = "длительно сильный дождь"
//    case showers = "ливент"
//    case wetSnow = "дождь со снегом"
//    case lightSnow = "небольшой снег"
//    case snow = "снег"
//    case snowShowers = "снегопад"
//    case hail =  "град"
//    case thunderstorm = "гроза"
//    case thunderstormWithRain = "дождь с грозой"
//    case thunderstormWithHail = "гроза с градом"
//
//}
//enum FactIcon: String, Decodable {
//    case bknSnD = "bkn_-sn_d"
//        case ovc = "ovc"
//        case ovcSn = "ovc_-sn"
//}
