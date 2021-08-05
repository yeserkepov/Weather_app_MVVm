//
//  ViewModel.swift
//  weather_app_MVVm
//
//  Created by Даурен on 30.07.2021.
//

import Foundation
import CoreLocation

class ViewModel: NSObject, CLLocationManagerDelegate {
    
    private let deviceLang = Locale.current.languageCode
    private let celsiusConst:Float = 273.15
    private let API_TOKEN = "c1802b88db702bb3f429ae83f65a0e94"
    private let API_URL = "https://api.openweathermap.org/data/2.5/"
    private var locationManager = CLLocationManager()
    private var coordinate: CLLocationCoordinate2D?
    private var data: Main?
    
    var cityLabel: Bindable<String> = Bindable("")
    var tempLabel: Bindable<String> = Bindable("")
    var descriptionLabel: Bindable<String> = Bindable("")
    var tempFeelsLabel: Bindable<String> = Bindable("")
    var tempMinLabel: Bindable<String> = Bindable("")
    var tempMaxLabel: Bindable<String> = Bindable("")
    var dateLabel: Bindable<String> = Bindable("")
    var iconsName: Bindable<String> = Bindable("")
    
    func configureLocationManager(){
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocationCoordinate2D = manager.location!.coordinate
        
        guard let url = URL(string: self.API_URL + "weather?lat=\(location.latitude)&lon=\(location.longitude)" + "&lang=\(deviceLang ?? "en")&appid=" + self.API_TOKEN ) else {return}
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error == nil, let data = data {
                do {
                    self.data = try JSONDecoder().decode(Main.self, from: data)
                    self.loadData()
                } catch {
                    print(error)
                }
            } else {
                print(error?.localizedDescription as Any)
            }
        }
        task.resume()
        locationManager.stopUpdatingLocation()
    }
    
    func setup(){
        configureLocationManager()
    }

    private func timeConverter(time: Int) -> String {
        let timeResult = time
        let date = Date(timeIntervalSince1970: TimeInterval(timeResult))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        dateFormatter.timeZone = .current
        let localDate = dateFormatter.string(from: date)
        return localDate
    }
    
    private func loadData() {
        guard let data = self.data else { return }
        DispatchQueue.main.async {
            self.cityLabel.value = data.name
            self.iconsName.value = data.weather.first?.main ?? "Clear"
            self.dateLabel.value = self.timeConverter(time: data.dt)
            self.tempLabel.value = String(Int(data.main.temp! - self.celsiusConst)) + "º"
            self.tempFeelsLabel.value = "Feels like " + String(Int(data.main.feels_like! - self.celsiusConst)) + "º"
            self.tempMinLabel.value = "Daily minimal " + String(Int(data.main.temp_min! - self.celsiusConst)) + "º"
            self.tempMaxLabel.value = "Daily maximal " + String(Int(data.main.temp_max! - self.celsiusConst)) + "º"
            self.descriptionLabel.value = data.weather.first?.description ?? "Clear"
        }
    }
}
