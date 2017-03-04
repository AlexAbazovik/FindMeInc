//
//  TattooConsultationViewController.swift
//  FindMeInc
//
//  Created by Alex Vecher on 28.02.17.
//  Copyright © 2017 Александр. All rights reserved.
//
//____________________________________________________
//TO DO: Combine imagesArray and loadedImages
//____________________________________________________

import UIKit
import MBProgressHUD

class TattooConsultationViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var findMeInkButton: UIButton!
    @IBOutlet weak var uploadImageButton: UIButton!
    
    @IBOutlet var moneyLabels: [UILabel]!
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    
    @IBOutlet weak var budgetSlider: RangeSlider!
    
    //MARK: Outlets to send
    @IBOutlet weak var tattooDescription: UITextView!
    @IBOutlet weak var minBudget: UILabel!
    @IBOutlet weak var maxBudget: UILabel!
    
    
    var imagesArray = [UIImage]()
    var loadedImages = [Int]()
    
    //MARK: - UIViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setRangeSliderParams()
        
        imagesCollectionView.dataSource = self
        imagesCollectionView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - UIAlertViewController
    func showAlert() -> Void {
        let alert = UIAlertController.init(title: "Alert", message: "You can upload up to 5 images.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Actions
    @IBAction func actionUploadImage(_ sender: UIButton) {
        if (imagesArray.count < 5) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = .photoLibrary
            
            self.present(imagePickerController, animated: true, completion: nil)
        } else {
            showAlert()
        }
    }
    
    //MARK: Save consultation
    @IBAction func actionFindMeInc(_ sender: UIButton) {
        let parameters = [
            "description" : tattooDescription.text,
            "min_budget" : minBudget.text!,
            "max_budget" : maxBudget.text!,
            "photos" : loadedImages
        ] as [String : Any]
        
        UploadSession.sharedInfo.saveConsultation(parameters: parameters, onSuccess: { (response) in
            if response != false {
                let alert = UIAlertController(title: "Great", message: "Your Tattoo Idea Has Been Posted. Artist Will be In Touch!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Back to profile", style: .default, handler: { (action) in
                    self.navigationController?.popViewController(animated: true)
                    self.tabBarController?.selectedViewController = self.tabBarController?.viewControllers?[4]
                }))
                alert.addAction(UIAlertAction(title: "Back", style: .default, handler: { (action) in
                    self.navigationController?.popViewController(animated: true)
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }) { (error) in
            print(error)
        }
    }
    
    @IBAction func actionDeletePhotoButon(_ sender: UIButton) {
        imagesArray.remove(at: sender.tag)
        loadedImages.remove(at: sender.tag)
        //imagesCollectionView.deleteItems(at: [IndexPath.init(row: sender.tag, section: 0)])
        imagesCollectionView.reloadData()
    }
    
    @IBAction func actionHideKeyboardByTap(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    //MARK: - RangeSlider
    func setRangeSliderParams() -> Void {
        budgetSlider.maximumValue = 1250.0
        budgetSlider.minimumValue = 75.0
        budgetSlider.upperValue = 1000.0
        budgetSlider.lowerValue = 250.0
        
        moneyLabels[0].text = "250$"
        moneyLabels[1].text = "1000$"
    }
    
    @IBAction func actionChangeTattooPrice(_ sender: RangeSlider) {
        moneyLabels[0].text = "\(Int(sender.lowerValue))$"
        moneyLabels[1].text = "\(Int(sender.upperValue))$"
    }
    
    //MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        findMeInkButton.isEnabled = false
        uploadImageButton.isEnabled = false
        
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imagesArray.append(chosenImage)
        
       /* let blackView = UIView.init(frame: imagesCollectionView.bounds)
        print(imagesCollectionView.bounds)
        blackView.backgroundColor = UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.3)
        //imagesCollectionView.addSubview(blackView)
        
        let progressView = MBProgressHUD.showAdded(to: self.view, animated: true)
        progressView.mode = MBProgressHUDMode.indeterminate
        progressView.label.text = "Loading"
        progressView.center = imagesCollectionView.center
        blackView.addSubview(progressView)
        imagesCollectionView.addSubview(blackView) */
        
        
        //var progressView = MBProgressHUD()
        var cell = AddConsultationCollectionViewCell()
        DispatchQueue.main.async {
            print(self.imagesCollectionView.visibleCells.count)
            cell = (self.imagesCollectionView.cellForItem(at: IndexPath.init(row: self.imagesArray.count - 1, section: 0)) as! AddConsultationCollectionViewCell)
            
            cell.progressView = MBProgressHUD.showAdded(to: cell.imageView, animated: true)
            cell.progressView.mode = MBProgressHUDMode.determinate
            //progressView.label.text = "Loading"
            
            cell.progressView.bounds = CGRect(x: 0.0, y: 0.0, width: cell.progressView.bounds.width, height: cell.progressView.bounds.width)
        }
        
        //MARK: Send image to the server
        UploadSession.sharedInfo.uploadPhoto(image: chosenImage, uploadProgress: { (uploadProgress) in
            print("double = \(uploadProgress)")
            cell.progressView.progress = Float(uploadProgress)
        }, onSuccess: { (response) in
            self.loadedImages.append(response)
            
            self.findMeInkButton.isEnabled = true
            self.uploadImageButton.isEnabled = true
            
            cell.progressView.hide(animated: true)
        }) { (error) in
            print(error.localizedDescription)
            
            self.findMeInkButton.isEnabled = true
            self.uploadImageButton.isEnabled = true
            
            cell.progressView.hide(animated: true)
        }
        imagesCollectionView.reloadData()

        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: collectionView.bounds.width * 0.312, height: collectionView.bounds.height)
    }
    
    //MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! AddConsultationCollectionViewCell
        cell.imageView.image = imagesArray[indexPath.row]
        cell.deleteImageButton.tag = indexPath.row
        
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
