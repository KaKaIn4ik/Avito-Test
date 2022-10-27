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
	private let networkService: INetwork = NetworkCaching()
	private var parsedData: Avito? = nil
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableView.delegate = self
		tableView.dataSource = self
		
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(true)
		getDataAndSetTitle()
	}
	
	
}

extension ViewController {
	
	
	private func getDataAndSetTitle() {
		networkService.request(url: API.getEmployeesList) { [weak self] (result) in
			switch result {
				case .success(let parsedData):
					self?.parsedData = parsedData
					self?.avitoList = parsedData.company.employees.sorted { $0.name < $1.name }
					DispatchQueue.main.async {
						self?.tableView.reloadData()
					}
				case .failure(let error):
					self?.alertNoInternet(error: error)
					print(error.localizedDescription)
			}
		}
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


