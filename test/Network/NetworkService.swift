//
//  NetworkService.swift
//  test
//
//  Created by Кунгурцев Эдуард Сергеевич on 27.10.2022.
//
import Foundation

class NetworkService: INetwork {
	
	func request(url: String, completion: @escaping (Result<Avito, Error>) -> Void) {
		guard let url = URL(string: url) else { return }
		URLSession.shared.dataTask(with: url) { data, responce, error in
			DispatchQueue.main.async {
				if let error = error {
					completion(.failure(error))
					print(error)
					return
				}
			}
			
			guard let data = data else { return }
			
			do {
				let parsedData = try JSONDecoder().decode(Avito.self, from: data)
				completion(.success(parsedData))
			} catch let jsonError{
				print("Failure", jsonError)
				completion(.failure(jsonError))
			}
		}.resume()
	}
	
}
