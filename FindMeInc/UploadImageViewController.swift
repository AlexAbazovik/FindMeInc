import UIKit

class UploadImageViewController: UIViewController {

    @IBOutlet weak var waterMark: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    @IBAction func radioButtonTap (_ sender: CustomRadioButton){
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func addWatermarkSwitchOff (_ sender: UISwitch){
        if !sender.isOn{
            waterMark.isHidden = true
        }else{
            waterMark.isHidden = false
        }
    }
}
