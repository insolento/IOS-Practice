import UIKit

struct Planet: Decodable {
    let name: String
    let rotationPeriod: String
    let orbitalPeriod: String
    let diameter: String
    let climate: String
    let gravity: String
    let terrain: String
    let surfaceWater: String
    let population: String
    let residents: [String]
    let films: [String]
    let created: String
    let edited: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case rotationPeriod = "rotation_period"
        case orbitalPeriod = "orbital_period"
        case diameter
        case climate
        case gravity
        case terrain
        case surfaceWater = "surface_water"
        case population
        case residents
        case films
        case created
        case edited
        case url
    }
}

class InfoViewController: UIViewController {
    
    let alertButton: UIButton = {
        let alertButton = UIButton(type: .system)
        alertButton.translatesAutoresizingMaskIntoConstraints = false
        alertButton.frame.size.height = 75
        alertButton.frame.size.width = 250
        alertButton.setTitle("Open alert", for: .normal)
        alertButton.addTarget(InfoViewController.self, action:#selector(openAlert), for: .touchUpInside)
        return alertButton
    }()
    
    let networkTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.frame.size.height = 75
        label.frame.size.width = 250
        label.text = "EMPTY INFO"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    let networkPlanetTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.frame.size.height = 75
        label.frame.size.width = 250
        label.text = "EMPTY INFO"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        view.addSubview(alertButton)
        view.addSubview(networkTitle)
        view.addSubview(networkPlanetTitle)
        layout()
        networkOperations()
    }
    
    func layout() {
        NSLayoutConstraint.activate([
            alertButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            alertButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            networkTitle.topAnchor.constraint(equalTo: alertButton.bottomAnchor, constant: 16),
            networkTitle.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            networkPlanetTitle.topAnchor.constraint(equalTo: networkTitle.bottomAnchor, constant: 16),
            networkPlanetTitle.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
        ])
    }
    
    func networkOperations() {
        print("=======================================")
        print("Network DZ 2_1 : ")
        if let url = URL(string: "https://jsonplaceholder.typicode.com/todos/17") {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let unwrappedData = data {
                    do {
                        let serialezedDictionary = try JSONSerialization.jsonObject(with: unwrappedData, options: [])
                        if let dict = serialezedDictionary as? [String: Any] {
                            if let title = dict["title"] as? String {
                                DispatchQueue.main.async {
                                    self.networkTitle.text = title
                                }
                            }
                        }
                    } catch let error {
                        print(error)
                    }
                }
            }
            task.resume()
        } else {
            print("Couldn't find URL!")
        }
        print("=======================================")
        print("Network DZ 2_2 : ")
        if let url = URL(string: "https://swapi.dev/api/planets/1") {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let unwrappedData = data {
                    do {
                        let planet = try JSONDecoder().decode(Planet.self, from: unwrappedData)
                        DispatchQueue.main.async {
                            self.networkPlanetTitle.text = planet.orbitalPeriod
                        }
                        print("Planet info:")
                        print(planet.climate)
                        print(planet.rotationPeriod)
                        print(planet.diameter)
                        print(planet.name)
                        print(planet.residents[1])
                    } catch let error {
                        print(error)
                    }
                }
            }
            task.resume()
        } else {
            print("Couldn't find URL!")
        }
    }
    
    @objc func openAlert() {
        let alertWindow = UIAlertController(title: "Name of alert", message: "Message of Alert", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {(alert: UIAlertAction!) in self.pressedCancel()})
        let moreInfAction = UIAlertAction(title: "More Information!", style: .default, handler: {(alert: UIAlertAction!) in self.pressedMI()})
        alertWindow.addAction(cancelAction)
        alertWindow.addAction(moreInfAction)
        present(alertWindow, animated: true, completion: nil)
        print("Было открыто UIAlertController")
    }
    
    func pressedMI() {
        print("More Information UIAlert")
    }
    
    func pressedCancel() {
        print("Cancel UIAlert")
    }
}
