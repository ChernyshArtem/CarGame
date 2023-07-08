//
//  SwitchCell.swift
//  CarGame
//
//  Created by Артём Черныш on 8.07.23.
//

import UIKit

class SwitchCell: UITableViewCell {
    
    public static let identifier: String = "SwitchCell"
    
    private let name: UILabel = {
        let label = UILabel()
        label.text = "Error"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(name)
        name.snp.makeConstraints { make in
            make.top.left.bottom.equalTo(contentView).inset(16)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configurate(name: String) {
        self.name.text = name
    }
}
