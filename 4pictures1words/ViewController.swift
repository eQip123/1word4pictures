
import UIKit
class ViewController: UIViewController {

    @IBOutlet weak var firstImage: UIImageView!
    
    @IBOutlet weak var secondImage: UIImageView!
    
    @IBOutlet weak var thirdImage: UIImageView!
    
    @IBOutlet weak var fourthImage: UIImageView!
    
    @IBOutlet weak var wordCollectionView: UICollectionView!
    
    @IBOutlet weak var letterCollectionView: UICollectionView!
    
private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Settings", for: .normal)
    button.setImage(UIImage(systemName: "gear"), for: .normal)
    button.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    var levels: [ModelLevel] = [ModelLevel(firstImageM: UIImage(named: "water1"), secondImageM: UIImage(named: "water2"), thirdImageM: UIImage(named: "water3"), fourthImageM: UIImage(named: "water4"), correctAnswer: ["W", "A", "T", "E", "R"] , lettersM: ["W" , "N" , "Y" , "A" , "I" , "Q" , "R" , "E" , "L" , "T", "W" , "N" ,]),
        ModelLevel(firstImageM: UIImage(named: "job1"), secondImageM: UIImage(named: "job2"), thirdImageM: UIImage(named: "job3")!, fourthImageM: UIImage(named: "job4"), correctAnswer: ["J", "O", "B"] , lettersM: ["S", "A", "O", "J", "C", "B", "E", "P"]),
        ModelLevel(firstImageM: UIImage(named: "fruit1"), secondImageM: UIImage(named: "fruit2"), thirdImageM: UIImage(named: "fruit3"), fourthImageM: UIImage(named: "fruit4"), correctAnswer: ["F", "R", "U", "I", "T"] , lettersM: ["I", "K", "R", "Y", "U", "B", "D", "T", "F", "Q", "L"])]
    
    var index = 0
    var word: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(saveButton)
        setupAutoLayout()
        firstImage.image = levels[0].firstImageM
        secondImage.image = levels[0].secondImageM
        thirdImage.image = levels[0].thirdImageM
        fourthImage.image = levels[0].fourthImageM
        
        wordCollectionView.delegate = self
        wordCollectionView.dataSource = self
        letterCollectionView.delegate = self
        letterCollectionView.dataSource = self
    }
    func setupAutoLayout () {
        saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        saveButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        saveButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        
        


    }



    @IBAction func nextLevel(_ sender: UIButton) {
        if word == levels[index].correctAnswer {
        index += 1
        firstImage.image = levels[index].firstImageM
        secondImage.image = levels[index].secondImageM
        thirdImage.image = levels[index].thirdImageM
        fourthImage.image = levels[index].fourthImageM
        letterCollectionView.reloadData()
        }
        word.removeAll()
        wordCollectionView.reloadData()
    }
    @objc func nextPage() {
        print("click")
        let secondVc = SecondPage()
        navigationController?.pushViewController(secondVc, animated: true)
    }
}
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == letterCollectionView {
            return levels[index].lettersM.count
        } else {
            return word.count
        }
    }
    // ???????????????? ???? ?????????????????? ?????????? CollectionView
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == letterCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "letter", for: indexPath) as! LetterCell
            cell.letterLabel.text = levels[index].lettersM[indexPath.row]
            cell.backgroundColor = .cyan
            return cell
        } else {
            let cell = wordCollectionView.dequeueReusableCell(withReuseIdentifier: "word", for: indexPath) as! WordLetter
            cell.wordLabel.text = word[indexPath.row]
            cell.backgroundColor = .magenta
            return cell
        }
    }
}
// ???????????? ??????????
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 70, height: 70)
    }
    // ???????????????? ???? ???????? CollectionView
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == letterCollectionView {
            let letter = levels[index].lettersM[indexPath.row]
            word.append(letter)
            wordCollectionView.reloadData()
            letterCollectionView.reloadData()
        }
            if word == levels[index].correctAnswer {
                print("Guessed!")
            } else {
                print("guessed wrong!")
            }
        }

    }

