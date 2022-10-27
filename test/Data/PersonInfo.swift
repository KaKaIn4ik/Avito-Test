//
//  PersonInfo.swift
//  test
//
//  Created by Кунгурцев Эдуард Сергеевич on 26.10.2022.
//


import UIKit

class PersonInfo: UITableViewCell {
	
	@IBOutlet weak var nameLabel: UILabel!
	
	@IBOutlet weak var phoneLabel: UILabel!
	
	@IBOutlet weak var skillsLabel: UILabel!
	
	func configure(with person: Employee) {
		nameLabel.text = person.name
		phoneLabel.text = "Phone: \(person.phoneNumber)"
		skillsLabel.text = "Skills: \(person.skills.joined(separator: ", "))"
		
	}
	
	
}
