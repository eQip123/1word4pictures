import UIKit

class SecondPage: UIViewController {
    
        private lazy var textLabel: UILabel = {
            let label = UILabel()
            label.text = ""
            label.textAlignment = .left
            label.font = .systemFont(ofSize: 30)
            label.textColor = .black
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        private lazy var switchTop: UISwitch = {
            let switchView = UISwitch()
            switchView.translatesAutoresizingMaskIntoConstraints = false
            switchView.addTarget(self, action: #selector(switchChange), for: .valueChanged)
            return switchView
        }()
    private lazy var saveBackgroundButton: UIButton = {
            let button = UIButton()
            button.setTitle("Settings", for: .normal)
        button.backgroundColor = .blue
            button.addTarget(self, action: #selector(saveBackground), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
    let userDefaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(textLabel)
        view.addSubview(switchTop)
        view.addSubview(saveBackgroundButton)

        autolayout()
        if userDefaults.bool(forKey: "onOff") {
            switchTop.setOn(true, animated: false)
            textLabel.text = "Dark theme"
        } else {
            switchTop.setOn(false, animated: false)
            textLabel.text = "Red Theme"
        }
        if userDefaults.bool(forKey: "darkBackground") {
            switchTop.setOn(true, animated: false)
            view.backgroundColor = .darkGray
        } else {
            switchTop.setOn(false, animated: false)
            view.backgroundColor = .red
        }
    }
    @objc func saveBackground () {
        if switchTop.isOn {
            userDefaults.set(true, forKey: "onOff")
        } else {
            userDefaults.set(false, forKey: "onOff")
            
        }
    }
    @objc func switchChange() {
        if switchTop.isOn {
            userDefaults.set(true, forKey: "darkBackground")
            textLabel.text = "Dark theme"
            view.backgroundColor = .darkGray
        } else {
            userDefaults.set(false, forKey: "darkBackground")
            textLabel.text = "Red theme"
            view.backgroundColor = .red
        }
    }
    func autolayout() {
        
        textLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        textLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        textLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        textLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        switchTop.topAnchor.constraint(equalTo: view.topAnchor, constant: 110).isActive = true
        switchTop.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100).isActive = true
        switchTop.heightAnchor.constraint(equalToConstant: 60).isActive = true
        switchTop.widthAnchor.constraint(equalToConstant: 120).isActive = true
        
        saveBackgroundButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        saveBackgroundButton.leadingAnchor.constraint(equalTo: switchTop.leadingAnchor, constant: 100).isActive = true
        saveBackgroundButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        saveBackgroundButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
    }
}
