//
//  MapContainerViewModel.swift
//  Gazetteer
//
//  Created by Seymour Rodrigues on 02/05/2023.
//

import MapKit

final class MapContainerViewModel: NSObject {
    
    enum MapContainerViewState {
        case loading
        case loaded
        case error
    }
    
    private var locationManager: CLLocationManager?
    
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.331516, longitude: -121.891054), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    @Published private(set) var countries = [Country]()
    @Published var selectedCountry = Country(name: Name(common: "", nativeName: nil), cca2: "", currencies: ["GBP" : Currency(name: "", symbol: "£")], capital: [], region: "", languages: [:], latlng: nil, area: 100, population: 10, timezones: [], flags: Flags(png: "", svg: "", alt: ""))
    @Published private(set) var state: MapContainerViewState = .loading
}

// MARK: -
// MARK: Core Methods

extension MapContainerViewModel: ObservableObject {
    
    func fetchCountryNames() {
        guard let url = URL(string: "https://restcountries.com/v3.1/all") else {
            self.state = .error
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                self.state = .error
                return
            }
            
            do {
                let countryData = try JSONDecoder().decode([Country].self, from: data)
                DispatchQueue.main.async {
                    self.countries = countryData.sorted(by: { $0.name.common < $1.name.common })
                    self.state = .loaded
                }
                
            } catch {
                self.state = .error
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
            guard let locationManager = self.locationManager else { return }
        
        switch locationManager.authorizationStatus {
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .restricted:
                print("Your location is restricted due to parental controls")
            case .denied:
                print("Go to settings to enable your location")
            case .authorizedAlways, . authorizedWhenInUse:
                self.region = MKCoordinateRegion(center: locationManager.location!.coordinate, span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
                self.fetchCountryFromLatLon(lat: "\(locationManager.location!.coordinate.latitude)", lng: "\(locationManager.location!.coordinate.longitude)")
            @unknown default:
                break
        }
    }
    
    private func fetchCountryFromLatLon(lat: String, lng: String) {
        self.state = .loading
        guard let url = URL(string: "https://api.opencagedata.com/geocode/v1/json?q=\(lat),\(lng)&key=cd66fd16180a4c18a4f05bd6f2da39ac") else {
            self.state = .error
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    self.state = .error
                }
                return
            }
            do {
                let latLonResponse = try JSONDecoder().decode(LatLonResponse.self, from: data)
                DispatchQueue.main.async {
                    self.selectedCountry = self.countries.filter { country in
                        country.cca2 == latLonResponse.results[0].components.isoA2
                    }.first!
                    self.state = .loaded
                }
            } catch {
                DispatchQueue.main.async {
                    self.state = .error
                }
            }
        }.resume()
        
    }
    
}

// MARK: -
// MARK: CLLocationManagerDelegate

extension MapContainerViewModel: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}
