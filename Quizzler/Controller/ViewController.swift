

import UIKit

class ViewController: UIViewController {
    
    var quizModel = Quiz()
    
    lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Background-Bubbles")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var scoreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 0
        label.text = "Question Text"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var firstButtom: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("True", for: .normal)
        button.setBackgroundImage(UIImage(named: "Rectangle"), for: .normal)
        button.addTarget(self, action: #selector(answerButtonPressed), for: .touchUpInside)
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .systemFont(ofSize: 25)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var secondButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "Rectangle"), for: .normal)
        button.addTarget(self, action: #selector(answerButtonPressed), for: .touchUpInside)
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .systemFont(ofSize: 25)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var thirdButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "Rectangle"), for: .normal)
        button.addTarget(self, action: #selector(answerButtonPressed), for: .touchUpInside)
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .systemFont(ofSize: 25)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var progressView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var progressBar: UIProgressView = {
        let progress = UIProgressView()
        progress.progressTintColor = .systemPink
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
    }
    
    @objc func answerButtonPressed(_ sender: UIButton) {
        let userAnswer = sender.currentTitle!
        let userGotItRight = quizModel.checkAnswer(userAnswer)
        
        if userGotItRight {
            sender.backgroundColor = .green
            print("Right!")
        } else {
            sender.backgroundColor = .red
            print("Wrong!")
        }
        
        quizModel.nextQuestion()
        Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
    }
    
    @objc func updateUI() {
        questionLabel.text = quizModel.getQuestionText()
        firstButtom.setTitle(quizModel.getNameAnswer(number: 0), for: .normal)
        secondButton.setTitle(quizModel.getNameAnswer(number: 1), for: .normal)
        thirdButton.setTitle(quizModel.getNameAnswer(number: 2), for: .normal)
        
        firstButtom.backgroundColor = .clear
        secondButton.backgroundColor = .clear
        thirdButton.backgroundColor = .clear
        let percentageProgress = quizModel.getProgress()
        scoreLabel.text = "Score: \(quizModel.getScore())"
        progressBar.progress = percentageProgress
    }
}

extension ViewController {
    
    func setupViews() {
        updateUI()
        view.backgroundColor = .blue
        view.addSubview(backgroundImageView)
        view.addSubview(stackView)
        
        
        stackView.addArrangedSubview(scoreLabel)
        stackView.addArrangedSubview(questionLabel)
        stackView.addArrangedSubview(buttonStackView)
        stackView.addArrangedSubview(progressView)
        
        buttonStackView.addArrangedSubview(firstButtom)
        buttonStackView.addArrangedSubview(secondButton)
        buttonStackView.addArrangedSubview(thirdButton)
        
        progressView.addSubview(progressBar)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.heightAnchor.constraint(equalToConstant: 102),
            
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            buttonStackView.heightAnchor.constraint(equalToConstant: 250),
            
            progressView.heightAnchor.constraint(equalToConstant: 100),

            progressBar.centerYAnchor.constraint(equalTo: progressView.centerYAnchor),
            progressBar.heightAnchor.constraint(equalToConstant: 5),
            progressBar.leadingAnchor.constraint(equalTo: progressView.leadingAnchor, constant: 5),
            progressBar.trailingAnchor.constraint(equalTo: progressView.trailingAnchor, constant: -5),
            
            
        ])
    }
}
