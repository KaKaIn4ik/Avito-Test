//
//  Data.swift
//  test
//
//  Created by Кунгурцев Эдуард Сергеевич on 26.10.2022.
//

import Foundation

// MARK: - Avito
struct Avito: Codable {
	let company: Company
}

// MARK: - Company
struct Company: Codable {
	let name: String
	let employees: [Employee]
}

// MARK: - Employee
struct Employee: Codable {
	let name, phoneNumber: String
	let skills: [String]
	
	enum CodingKeys: String, CodingKey {
		case name
		case phoneNumber = "phone_number"
		case skills
	}
}
