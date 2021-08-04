

//  Created by Mihir Solanki on 29/07/21.


import Foundation
struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temprature: Double
    
    var CityName: String{
        return "\(cityName)"
    }
    
    var tempratureString:String{
        return String(format:" %.1f", temprature)
    }
   // computing property
    var conditionName:String{
        switch conditionId {
        case 200...232:
            return "cloud.boult"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "cloud.max"
        case 801...804:
            return "cloud.boult"
        default:
            return "cloud"
        }
    }
    
    
}
