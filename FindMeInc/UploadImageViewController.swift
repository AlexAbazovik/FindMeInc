import UIKit

class UploadImageViewController: UIViewController {

    @IBOutlet weak var viewToDrag: UIView!
    @IBOutlet weak var waterMark: UILabel!
    @IBOutlet var panGestureRecognizerForDragWaterMark: UIPanGestureRecognizer!

    var lastLocation: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lastLocation = waterMark.center

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
    @IBAction func waterMarkDragged(_ sender: UIPanGestureRecognizer) {
        
        //To do: add validation to the bounds of the view
        
        waterMark.center = CGPoint(x:(lastLocation.x + sender.translation(in: viewToDrag).x), y:(lastLocation.y + sender.translation(in:viewToDrag).y))
        if sender.state == .ended{
            lastLocation = waterMark.center
        }
    }
}
