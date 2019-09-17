import UIKit

class ComicViewController: UIViewController {
    
    @IBOutlet weak var comicImage: UIImageView!
    @IBOutlet weak var comicStepper: UIStepper!
    @IBOutlet weak var comicTextField: UITextField!
    
    var comic: Comic! {
        didSet {
            loadImage()
        }
    }
    
    var currentImage: UIImage? {
        didSet {
            comicImage.image = self.currentImage
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        comicTextField.delegate = self
    }
    
    @IBAction func stepperPressed(_ sender: UIStepper) {
        loadData(comicNum: Int(sender.value))
    }
    
    @IBAction func mostRecentPressed(_ sender: Any) {
        loadData(comicNum: nil)
    }
    
    @IBAction func randomComic(_ sender: Any) {
        let random = Int.random(in: 1...2199)
        comicStepper.value = Double( random)
        loadData(comicNum: random)
    }
    
    private func setUp(){
        let random = Int.random(in: 1...2199)
        comicStepper.value = Double(random)
        loadData(comicNum: random)
    }
    
    private func loadImage(){
        ImageHelper.shared.fetchImage(urlString: comic?.img ?? "") { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let image):
                    self.currentImage = image
                }
            }
        }
    }
    
    private func loadData(comicNum: Int? ) {
        Comic.getComic(comicNum: comicNum) { (result) in
            DispatchQueue.main.async {
                
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let comicInfo):
                    self.comic = comicInfo
                }
            }
        }
    }
    
}

extension ComicViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let userInput = Int((textField.text)!){
            loadData(comicNum: userInput)
            comicStepper.value = Double(userInput)
            return true
        }
        return false
    }
}
