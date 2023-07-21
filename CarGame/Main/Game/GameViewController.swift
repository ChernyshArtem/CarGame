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
    
    private let centerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        return view
    }()
    
    private let rightView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        return view
    }()
    
    private let startTextLabel: UILabel = {
        let label = UILabel()
        label.text = "3"
        label.font = UIFont.systemFont(ofSize: 200, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var leftSwipe: UISwipeGestureRecognizer = {
        let gesture = UISwipeGestureRecognizer()
        gesture.direction = .left
        gesture.addTarget(self, action: #selector(selectCarPosition))
        return gesture
    }()
    
    private lazy var rightSwipe: UISwipeGestureRecognizer = {
        let gesture = UISwipeGestureRecognizer()
        gesture.direction = .right
        gesture.addTarget(self, action: #selector(selectCarPosition))
        return gesture
    }()
    
    //MARK: Parent-controller
    
    public var mainController: MainViewController?
    
    //MARK: VARIABLES
    private let baseCarMovement: Double = 0.25
    private let baseWidthHeight: Double = 100
    private let personWidth: Double = 50
    private let baseMargin: Double = 16
    private var rockSpeed: Double = {
        var rock = Double()
        if SettingsManager.management.difficultyChecked?[0] == true {
            rock = 6
        } else if SettingsManager.management.difficultyChecked?[2] == true {
            rock = 2
        } else {
            rock = 4
        }
        return rock
    }()
    
    private var treeSpeed: Double = {
        var tree = Double()
        if SettingsManager.management.difficultyChecked?[0] == true {
            tree = 7.5
        } else if SettingsManager.management.difficultyChecked?[2] == true {
            tree = 2.5
        } else {
            tree = 5
        }
        return tree
    }()
    
    private var personSpeed: Double = {
        var person = Double()
        if SettingsManager.management.difficultyChecked?[0] == true {
            person = 9
        } else if SettingsManager.management.difficultyChecked?[2] == true {
            person = 5
        } else {
            person = 7
        }
        return person
    }()
    
    private var score = 0
    private var timer = Timer()
    private let randomInt = Int(arc4random_uniform(UInt32(1 - 0 + 1)))
    private var startTextLabelTimer: Timer? = Timer()
    
    //MARK: LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { _ in
            self.timerCheck()
        })
        startTextLabelTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            self.startTextAction()
        })
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        playMusic()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        fallElement(element: rockImage, position: centerView, speed: rockSpeed, width: baseWidthHeight)
        if randomInt == 0 {
            fallElement(element: treeImage, position: leftView, speed: treeSpeed, width: baseWidthHeight)
            fallElement(element: personImage, position: rightView, speed: personSpeed, width: personWidth)
        } else {
            fallElement(element: treeImage, position: rightView, speed: treeSpeed, width: baseWidthHeight)
            fallElement(element: personImage, position: leftView, speed: personSpeed, width: personWidth )
        }
    }
    
    //MARK: UI-ELEMENTS SETUP
    private func setupUI() {
        setupSubviews()
        setupLeftView()
        setupCenterView()
        setupRightView()
        setupImages()
       
        startTextLabel.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
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
        view.addSubview(startTextLabel)
        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
    }
    
    private func setupLeftView() {
        leftView.snp.makeConstraints { make in
            make.width.equalTo(view.safeAreaLayoutGuide).dividedBy(3)
            make.height.equalTo(view)
            make.top.left.equalTo(view)
        }
    }
    
    private func setupCenterView() {
        centerView.snp.makeConstraints { make in
            make.width.equalTo(view.safeAreaLayoutGuide).dividedBy(3)
            make.height.equalTo(view)
            make.centerX.centerY.equalTo(view)
        }
        
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
    }
    
    private func setupImages() {
        carImage.snp.makeConstraints { make in
            make.centerX.bottom.equalTo(centerView).inset(baseMargin)
            make.height.width.equalTo(baseWidthHeight)
        }
        
        rockImage.snp.makeConstraints { make in
            make.top.equalTo(centerView).offset(-120)
            make.centerX.equalTo(centerView)
            make.height.width.equalTo(baseWidthHeight)
        }
        
        if randomInt == 0 {
            treeImage.snp.makeConstraints { make in
                make.top.equalTo(leftView)
                make.centerX.equalTo(leftView)
                make.height.width.equalTo(baseWidthHeight)
            }
            personImage.snp.makeConstraints { make in
                make.top.equalTo(rightView)
                make.centerX.equalTo(rightView)
                make.height.equalTo(baseWidthHeight)
                make.width.equalTo(personWidth)
            }
        } else {
            treeImage.snp.makeConstraints { make in
                make.top.equalTo(rightView)
                make.centerX.equalTo(rightView)
                make.height.width.equalTo(baseWidthHeight)
            }
            personImage.snp.makeConstraints { make in
                make.top.equalTo(leftView)
                make.centerX.equalTo(leftView)
                make.height.equalTo(baseWidthHeight)
                make.width.equalTo(personWidth)
            }
        }
    }
    
    //MARK: FUNCTIONALITY
    @objc private func selectCarPosition(sender: UISwipeGestureRecognizer) {
        switch sender.direction {
        case .left:
            if selectedUserPostion == .right {
                selectedUserPostion = .center
            } else {
                selectedUserPostion = .left
            }
        case .right:
            if selectedUserPostion == .center {
                selectedUserPostion = .right
            } else {
                selectedUserPostion = .center
            }

        default:
            break
        }
        changeCarPosition()
    }
    
    private func changeCarPosition() {
        timerCheck()
        switch selectedUserPostion {
        case .left:
            UIView.animate(withDuration: baseCarMovement, delay: 0, options: [.curveEaseInOut]) {
                self.carImage.snp.remakeConstraints { make in
                    make.centerX.bottom.equalTo(self.leftView).inset(self.baseMargin)
                    make.height.width.equalTo(self.baseWidthHeight)
                }
                self.view.layoutIfNeeded()
            }
        case .center:
            UIView.animate(withDuration: baseCarMovement, delay: 0, options: [.curveEaseInOut]) {
                self.carImage.snp.remakeConstraints { make in
                    make.centerX.bottom.equalTo(self.centerView).inset(self.baseMargin)
                    make.height.width.equalTo(self.baseWidthHeight)
                }
                self.view.layoutIfNeeded()
            }
        case .right:
            UIView.animate(withDuration: baseCarMovement, delay: 0, options: [.curveEaseInOut]) {
                self.carImage.snp.remakeConstraints { make in
                    make.centerX.bottom.equalTo(self.rightView).inset(self.baseMargin)
                    make.height.width.equalTo(self.baseWidthHeight)
                }
                self.view.layoutIfNeeded()
            }
        }
    }
    
    private func fallElement(element: UIImageView, position: UIView, speed: Double, width: Double) {
        UIView.animate(withDuration: speed, delay: 3, options:[.repeat, .curveLinear]) {
            element.snp.remakeConstraints { make in
                make.centerX.equalTo(position)
                make.bottom.equalTo(position).offset(100)
                make.height.equalTo(self.baseWidthHeight)
                make.width.equalTo(width)
            }
            self.view.layoutIfNeeded()
        }
    }
    
    private func timerCheck() {
        if checkCrashOfCar(element: rockImage) == false {
            timer.invalidate()
            mainController?.messageToUser =  StatisticsManager.management.addWinnerToList(score: score)
            self.navigationController?.popViewController(animated: true)
        } else if checkCrashOfCar(element: treeImage) == false {
            timer.invalidate()
            mainController?.messageToUser =  StatisticsManager.management.addWinnerToList(score: score)
            self.navigationController?.popViewController(animated: true)
        } else if checkCrashOfCar(element: personImage) == false {
            timer.invalidate()
            mainController?.messageToUser =  StatisticsManager.management.addWinnerToList(score: score)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    private func checkCrashOfCar(element: UIImageView) -> Bool {
        if element.layer.presentation()!.frame.maxY >= carImage.layer.presentation()!.frame.minY-25 && Int(element.layer.presentation()!.frame.midX) == Int(carImage.layer.presentation()!.frame.midX)  {
            if carImage.layer.presentation()!.frame.maxY < element.layer.presentation()!.frame.minY {
                score+=1
                return true
            } else {
                return false
            }
        } else {
            score+=1
            return true
        }
    }
    
    private func playMusic() {
        var music: String = "audi"
        
        if SettingsManager.management.musicChecked?[1] == true {
            music = "NFS"
        } else if SettingsManager.management.musicChecked?[2] == true {
            music = "Jmurki"
        } else if SettingsManager.management.musicChecked?[3] == true {
            music = "Hotline"
        } else if SettingsManager.management.musicChecked?[4] == true {
            music = "FINAL"
        } else {
            music = "audi"
        }
        guard let path = Bundle.main.path(forResource: music, ofType: "mp3") else {
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
    
    private func startTextAction() {
        switch startTextLabel.text {
        case "3":
            startTextLabel.text = "2"
            break
        case "2":
            startTextLabel.text = "1"
            break
        case "1":
            startTextLabel.text = "0"
            break
        default:
            startTextLabelTimer?.invalidate()
            startTextLabelTimer = nil
            startTextLabel.isHidden = true
        }
    }
}
