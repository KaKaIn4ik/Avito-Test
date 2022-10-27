//
//  ViewController.swift
//  test
//
//  Created by Кунгурцев Эдуард Сергеевич on 26.10.2022.
//

import UIKit

class ViewController: UIViewController {
	
	@IBOutlet weak var tableView: UITableView!
	private var avitoList: [Employee] = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableView.delegate = self
		tableView.dataSource = self
		
		processData()
		
	}
	
	
}

extension ViewController {
	
	private func processData() {
		
		if let data = UserDefaults.standard.data(forKey: "save") {
			if let cacheInfo = try? JSONDecoder().decode(CachingInfo.self, from: data){
				if cacheInfo.isValid {
					self.avitoList = cacheInfo.company.employees.sorted(by: { $0.name < $1.name})
					self.tableView.reloadData()
					return
				}
			}
		}
		
		
		guard let url = URL(string: API.getEmployeesList) else { return }
		
		URLSession.shared.dataTask(with: url) { data, _ , error in
			guard let data = data else { return }
			
			DispatchQueue.global(qos: DispatchQoS.QoSClass.utility).async {
				do {
					let jsonData = try JSONDecoder().decode(Avito.self, from: data)
					self.avitoList = jsonData.company.employees.sorted(by: {$0.name < $1.name})
					let cachingInfo = CachingInfo.init(date: Date(), company: jsonData.company)
					if let cachingData = try? JSONEncoder().encode(cachingInfo) {
						UserDefaults.standard.set(cachingData, forKey: "save")
						UserDefaults.standard.synchronize()
					}
					
				} catch let error {
					print(String(describing: error))
				}
				DispatchQueue.main.async {
					self.tableView.reloadData()
				}
			}
		}.resume()
		
	}
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		avitoList.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PersonInfo
		
		let avito = avitoList[indexPath.row]
		cell.configure(with: avito)
		
		return cell
	}
	
	
}


