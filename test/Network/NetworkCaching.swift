//
//  NetworkCaching.swift
//  test
//
//  Created by Кунгурцев Эдуард Сергеевич on 27.10.2022.
//

import Foundation

class NetworkCaching: NetworkService {
	
	
	
	override func request(url: String, completion: @escaping (Result<Avito, Error>) -> Void) {
		if let data = UserDefaults.standard.data(forKey: "save") {
			if let cacheInfo = try? JSONDecoder().decode(CachingInfo.self, from: data){
				if cacheInfo.isValid {
					completion(.success(cacheInfo.avito))
					return
				}
			}
		}
		super.request(url: url) { result in
			switch result {
				case .success(let parsedData):
					let cachingInfo = CachingInfo.init(date: Date(), avito: parsedData)
					if let cachingData = try? JSONEncoder().encode(cachingInfo) {
						UserDefaults.standard.set(cachingData, forKey: "save")
						UserDefaults.standard.synchronize()
					}
				case .failure(_):
					break
			}
			completion(result)

		}
	}
	

	
}
