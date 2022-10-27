//
//  СachingInfo.swift
//  test
//
//  Created by Кунгурцев Эдуард Сергеевич on 26.10.2022.
//

import Foundation

struct CachingInfo: Codable {
	let date: Date
	
	let company: Company
	var isValid: Bool {
		abs(date.timeIntervalSinceNow) < 3600
		
	}
}
