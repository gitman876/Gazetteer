//
//  MapContainerViewModel.swift
//  Gazetteer
//
//  Created by Seymour Rodrigues on 02/05/2023.
//

import MapKit

final class MapContainerViewModel: NSObject {
    
    private var locationManager: CLLocationManager?
    
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.331516, longitude: -121.891054), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    @Published var countries = [Country]()
    
}

// MARK: -
// MARK: Core Methods

extension MapContainerViewModel: ObservableObject {
    
    func fetchCountryNames() {
        guard let url = URL(string: "https://restcountries.com/v3.1/all") else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                return
            }
            
            do {
                let countryData = try JSONDecoder().decode([Country].self, from: data)
                DispatchQueue.main.async {
                    self.countries = countryData.sorted(by: { $0.name.common < $1.name.common })
                }
                
            } catch let error {
                print(error)
            }
        }.resume()
    }
    
    func checkIfLocationServicesIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager!.delegate = self
        } else {
            print("Show alert to user to turn on location services")
        }
    }
    
    func pickerSelectionDidChange(with country: Country) {
        guard let latlng = country.latlng else { return }
        self.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latlng[0], longitude: latlng[1]), span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
    }
    
}

// MARK: -
// MARK: Private Methods

extension MapContainerViewModel {
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus {
            
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .restricted:
                print("Your location is restricted due to parental controls")
            case .denied:
                print("Go to settings to enable your location")
            case .authorizedAlways, . authorizedWhenInUse:
                region = MKCoordinateRegion(center: locationManager.location!.coordinate, span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
            @unknown default:
                break
        }
    }
    
}

// MARK: -
// MARK: CLLocationManagerDelegate

extension MapContainerViewModel: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}
