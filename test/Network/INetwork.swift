//
//  INetwork.swift
//  test
//
//  Created by Кунгурцев Эдуард Сергеевич on 28.10.2022.
//

import Foundation

protocol INetwork {
	func request(url: String, completion: @escaping (Result<Avito, Error>) -> Void)
}
