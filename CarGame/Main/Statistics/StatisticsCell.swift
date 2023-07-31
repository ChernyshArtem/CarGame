//
//  StatisticsCell.swift
//  CarGame
//
//  Created by Артём Черныш on 8.07.23.
//

import UIKit

class StatisticsCell: UITableViewCell {
    
    static public let identifier = "StatisticsCell"
    
    private let position: UILabel = {
        let label = UILabel()
        label.text = "0"
        return label
    }()
    
    private let name: UILabel = {
        let label = UILabel()
        label.text = "Error"
        return label
    }()
    
    private let score: UILabel = {
        let label = UILabel()
        label.text = "Error"
        return label
    }()
    
    private let image: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "other")
        return img
    }()
    
    private let baseWidth: Double = 16
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        contentView.addSubview(position)
        contentView.addSubview(name)
        contentView.addSubview(score)
        contentView.addSubview(image)
        position.translatesAutoresizingMaskIntoConstraints = false
        name.translatesAutoresizingMaskIntoConstraints = false
        score.translatesAutoresizingMaskIntoConstraints = false
        image.translatesAutoresizingMaskIntoConstraints = false
        
        position.snp.makeConstraints { make in
            make.top.bottom.equalTo(contentView).inset(baseWidth)
            make.left.equalTo(contentView).offset(baseWidth)
        }
        
        name.snp.makeConstraints { make in
            make.top.bottom.equalTo(contentView).inset(baseWidth)
            make.left.equalTo(position.snp.right).offset(baseWidth)
        }
        
        score.snp.makeConstraints { make in
            make.top.bottom.equalTo(contentView).inset(baseWidth)
            make.left.equalTo(name.snp.right).offset(baseWidth)
        }
        
        image.snp.makeConstraints { make in
            make.top.bottom.right.equalTo(contentView).inset(baseWidth/2)
            make.height.width.equalTo(150)
        }
    }
    
    //MARK: FUNC
    
    public func configure(position: String, name: String, score: Int) {
        self.position.font = UIFont.systemFont(ofSize: 40, weight: .medium)
        switch position {
        case "🥇":
            image.image = UIImage(named: "first")
        case "🥈":
            image.image = UIImage(named: "second")
        case "🥉":
            image.image = UIImage(named: "third")
        default:
            image.image = UIImage(named: "other")
            self.position.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        }
        self.position.text = position
        self.name.text = name
        self.score.text = String(score)
    }
}
