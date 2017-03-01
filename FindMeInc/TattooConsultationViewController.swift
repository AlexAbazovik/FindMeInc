//
//  TattooConsultationViewController.swift
//  FindMeInc
//
//  Created by Alex Vecher on 28.02.17.
//  Copyright © 2017 Александр. All rights reserved.
//

import UIKit

class TattooConsultationViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet var moneyLabels: [UILabel]!
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    
    @IBOutlet weak var budgetSlider: RangeSlider!
    
    var imagesArray = [UIImage]()
    
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
    
    @IBAction func actionFindMeInc(_ sender: UIButton) {
        
    }
    
    @IBAction func actionDeletePhotoButon(_ sender: UIButton) {
        imagesArray.remove(at: sender.tag)
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
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imagesArray.append(chosenImage)
        imagesCollectionView.reloadData()
        //imagesCollectionView.insertItems(at: [IndexPath.init(row: imagesArray.count - 1, section: 0)])
        print(imagesArray.count)
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
