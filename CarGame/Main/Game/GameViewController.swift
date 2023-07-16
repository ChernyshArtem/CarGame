//
//  GameViewController.swift
//  CarGame
//
//  Created by Артём Черныш on 15.07.23.
//

import UIKit
import SnapKit
import AVFoundation

class GameViewController: UIViewController {
    
    //MARK: UI-elements
    enum Position {
        case left
        case center
        case right
    }
    
    var score = 0
    var timer = Timer()
    let randomInt = Int(arc4random_uniform(UInt32(1 - 0 + 1)))
    
    private var carImage: UIImageView = {
        let car = UIImageView()
        car.image = UIImage(named: "car")
        car.layer.shadowColor = UIColor.black.cgColor
        car.layer.shadowOpacity = 1
        car.layer.shadowOffset = .zero
        car.layer.shadowRadius = 10
        return car
    }()
    
    private var rockImage: UIImageView = {
        let rock = UIImageView()
        rock.image = UIImage(named: "rock")
        return rock
    }()
    
    private var treeImage: UIImageView = {
        let tree = UIImageView()
        tree.image = UIImage(named: "tree")
        return tree
    }()
    
    private var personImage: UIImageView = {
        let person = UIImageView()
        person.image = UIImage(named: "person")
        return person
    }()
    
    private var selectedUserPostion: Position = .center
    
    private let leftView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        return view
    }()
    
    private let leftButton = UIButton(type: .system)
    
    private let centerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        return view
    }()
    
    private let centerButton = UIButton(type: .system)
    
    private let rightView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        return view
    }()
    
    private let rightButton = UIButton(type: .system)
    
    //MARK: LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true, block: { _ in
            self.timerCheck()
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let path = Bundle.main.path(forResource: "audi", ofType: "mp3") else {
            return
        }
        let url = URL(fileURLWithPath: path)
        do {
            SettingsManager.management.player = try AVAudioPlayer(contentsOf: url)
        }
        catch {
            
        }
        SettingsManager.management.player?.play()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        fallElement(element: rockImage, position: centerView, speed: 5, width: 100)
        if randomInt == 0 {
            fallElement(element: treeImage, position: leftView, speed: 4, width: 100)
            fallElement(element: personImage, position: rightView, speed: 7, width: 50)
        } else {
            fallElement(element: treeImage, position: rightView, speed: 4, width: 100)
            fallElement(element: personImage, position: leftView, speed: 7, width: 50)
        }
    }
    
    //MARK: UI-ELEMENTS SETUP
    private func setupUI() {
        setupSubviews()
        setupLeftView()
        setupCenterView()
        setupRightView()
        
        carImage.snp.makeConstraints { make in
            make.centerX.bottom.equalTo(centerView).inset(16)
            make.height.width.equalTo(100)
        }
        
        rockImage.snp.makeConstraints { make in
            make.top.equalTo(centerView).offset(-120)
            make.centerX.equalTo(centerView)
            make.height.width.equalTo(100)
        }
        
        if randomInt == 0 {
            treeImage.snp.makeConstraints { make in
                make.top.equalTo(leftView)
                make.centerX.equalTo(leftView)
                make.height.width.equalTo(100)
            }
            personImage.snp.makeConstraints { make in
                make.top.equalTo(rightView)
                make.centerX.equalTo(rightView)
                make.height.equalTo(100)
                make.width.equalTo(50)
            }
        } else {
            treeImage.snp.makeConstraints { make in
                make.top.equalTo(rightView)
                make.centerX.equalTo(rightView)
                make.height.width.equalTo(100)
            }
            personImage.snp.makeConstraints { make in
                make.top.equalTo(leftView)
                make.centerX.equalTo(leftView)
                make.height.equalTo(100)
                make.width.equalTo(50)
            }
        }
    }
    
    private func setupSubviews() {
        navigationItem.hidesBackButton = true
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(leftView)
        view.addSubview(centerView)
        view.addSubview(rightView)
        view.addSubview(carImage)
        view.addSubview(rockImage)
        view.addSubview(treeImage)
        view.addSubview(personImage)
        
        leftView.addSubview(leftButton)
        leftButton.tag = 0
        centerView.addSubview(centerButton)
        centerButton.tag = 1
        rightView.addSubview(rightButton)
        rightButton.tag = 2
    }
    
    private func setupLeftView() {
        leftView.snp.makeConstraints { make in
            make.width.equalTo(view.safeAreaLayoutGuide).dividedBy(3)
            make.height.equalTo(view)
            make.top.left.equalTo(view)
        }
        leftButton.snp.makeConstraints { make in
            make.edges.equalTo(leftView)
        }
        leftButton.addTarget(self, action: #selector(selectCarPosition), for: .touchUpInside)
    }
    
    private func setupCenterView() {
        centerView.snp.makeConstraints { make in
            make.width.equalTo(view.safeAreaLayoutGuide).dividedBy(3)
            make.height.equalTo(view)
            make.centerX.centerY.equalTo(view)
        }
        centerButton.snp.makeConstraints { make in
            make.left.right.equalTo(centerView)
            make.top.equalTo(centerView.snp.top).multipliedBy(2)
            make.bottom.equalTo(centerView.snp.bottom).multipliedBy(2)
        }
        centerButton.addTarget(self, action: #selector(selectCarPosition), for: .touchUpInside)
        
        let leftLine = UIView()
        let rightLine = UIView()
        
        centerView.addSubview(leftLine)
        centerView.addSubview(rightLine)
        
        leftLine.snp.makeConstraints { make in
            make.left.equalTo(centerView.snp.left)
            make.top.equalTo(centerView.snp.top)
            make.height.equalTo(centerView)
            make.width.equalTo(2)
        }
        leftLine.backgroundColor = .systemYellow
        
        rightLine.snp.makeConstraints { make in
            make.right.equalTo(centerView.snp.right)
            make.top.equalTo(centerView.snp.top)
            make.height.equalTo(centerView)
            make.width.equalTo(2)
        }
        rightLine.backgroundColor = .systemYellow
    }
    
    private func setupRightView() {
        rightView.snp.makeConstraints { make in
            make.width.equalTo(view.safeAreaLayoutGuide).dividedBy(3)
            make.height.equalTo(view)
            make.top.right.equalTo(view)
        }
        rightButton.snp.makeConstraints { make in
            make.edges.equalTo(rightView)
        }
        rightButton.addTarget(self, action: #selector(selectCarPosition), for: .touchUpInside)
    }
    
    //MARK: FUNCTIONALITY
    @objc private func selectCarPosition(sender: UIButton) {
        switch sender.tag {
        case 0:
            selectedUserPostion = .left
        case 1:
            selectedUserPostion = .center
        default:
            selectedUserPostion = .right
        }
        changeCarPosition()
    }
    
    private func changeCarPosition() {
        timerCheck()
        switch selectedUserPostion {
        case .left:
            UIView.animate(withDuration: 0.75) {
                self.carImage.snp.remakeConstraints { make in
                    make.centerX.bottom.equalTo(self.leftView).inset(16)
                    make.height.width.equalTo(100)
                }
                self.view.layoutIfNeeded()
            }
        case .center:
            UIView.animate(withDuration: 0.75) {
                self.carImage.snp.remakeConstraints { make in
                    make.centerX.bottom.equalTo(self.centerView).inset(16)
                    make.height.width.equalTo(100)
                }
                self.view.layoutIfNeeded()
            }
        case .right:
            UIView.animate(withDuration: 0.75) {
                self.carImage.snp.remakeConstraints { make in
                    make.centerX.bottom.equalTo(self.rightView).inset(16)
                    make.height.width.equalTo(100)
                }
                self.view.layoutIfNeeded()
            }
        }
    }
    
    private func fallElement(element: UIImageView, position: UIView, speed: Double, width: Double) {
        UIView.animate(withDuration: speed, delay: 0, options:[.repeat]) {
            element.snp.remakeConstraints { make in
                make.centerX.equalTo(position)
                make.bottom.equalTo(position).offset(56)
                make.height.equalTo(100)
                make.width.equalTo(width)
            }
            self.view.layoutIfNeeded()
        }
    }
    
    private func timerCheck() {
        if checkCrashOfCar(element: rockImage) == false {
            self.navigationController?.popViewController(animated: true)
            SettingsManager.management.score = score
        } else if checkCrashOfCar(element: treeImage) == false {
            self.navigationController?.popViewController(animated: true)
            SettingsManager.management.score = score
        } else if checkCrashOfCar(element: personImage) == false {
            self.navigationController?.popViewController(animated: true)
            SettingsManager.management.score = score
        }
    }
    
    private func checkCrashOfCar(element: UIImageView) -> Bool {
        if element.layer.presentation()!.frame.maxY >= carImage.layer.presentation()!.frame.minY-25 && Int(element.layer.presentation()!.frame.midX) == Int(carImage.layer.presentation()!.frame.midX)  {
            timer = Timer()
            return false
        } else {
            score+=1
            return true
        }
    }
    
    
}
