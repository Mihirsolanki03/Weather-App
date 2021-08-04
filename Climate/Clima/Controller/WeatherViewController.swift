



import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var searchTextField: UITextField!
    let locationManager = CLLocationManager()
    var weatherManager = WeatherManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        searchTextField.delegate = self
        weatherManager.delegate = self
    }
    
}
// MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate{
    
    @IBAction func searchButton(_ sender: UIButton) {
        searchTextField.endEditing(true) // off the keyboard
        print(searchTextField.text!)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text{
            weatherManager.fetchWeather(cityName: city)
        }
        searchTextField.text = "" //
    }
}
// MARK:- WeatherManagerDelegate
extension WeatherViewController: WeatherManagerDelegate{
    
    func didUpdateMethod(weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.tempratureString
            self.cityLabel.text = weather.CityName
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
        }
    }
}
// MARK:- CLLocationManagerDelegate
extension WeatherViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
        
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}


