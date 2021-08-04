//
//  weatherManager.swift
//  Clima
//
//  Created by Mihir Solanki on 23/07/21.
//

import Foundation
import CoreLocation
protocol WeatherManagerDelegate {
    func didUpdateMethod(weather:WeatherModel)
}
struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=285f94a1646689a72e633035c54646ed&units=metric"
    var delegate:WeatherManagerDelegate?
    
    func fetchWeather(cityName:String){
        let urlstring = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlstring)
    }
    func fetchWeather(latitude: CLLocationDegrees , longitude: CLLocationDegrees){
        let urlstring = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(urlString: urlstring)
    }
    
    func performRequest(urlString:String){
        
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil{
                    print(error!)
                    return
                }
                if let safeData = data{
                    if let weather = self.parseJson(weatherData: safeData){
                        self.delegate?.didUpdateMethod(weather: weather)
                    }

                }
            }
            
            task.resume()
        }
    }
    
    func parseJson(weatherData:Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do{
            let  decodedData = try decoder.decode(weatherdata.self, from: weatherData)
            let id =  decodedData.weather[0].id
            let name = decodedData.name
            let temp = decodedData.main.temp
            let weather = WeatherModel(conditionId: id, cityName: name, temprature: temp)
            return weather
            
            //print(weather.conditionName)
           // print(weather.tempratureString)
            //print(weather.CityName)
        }
        catch{
            print(error)
            return nil
        }
        
    }
    
    
}
