//
//  ViewController.swift
//  SampleWithoutBoard
//
//  Created by 蒲生廣人 on 2018/08/26.
//  Copyright © 2018年 蒲生廣人. All rights reserved.
//

import UIKit
import SnapKit

class Nav1ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let controller:FilterListViewController = FilterListViewController(titleName: "")
    var selectedIndex: Int!


    var myImageView: UIImageView!
    var myImage: UIImage = UIImage(named: "image2.jpg")!
    var tranditionFlag = true
    private lazy var container: UIView = {
        let container = UIView()
        container.backgroundColor = UIColor.brown
        
        let iWidth: CGFloat = 300
        let iHeight: CGFloat = 400
       
        let posX: CGFloat = (self.view.bounds.width - iWidth)/2
        let posY: CGFloat = (self.view.bounds.height - iHeight)/2
       
        myImageView = UIImageView(frame: CGRect(x: posX, y: posY, width: iWidth, height: iHeight))
        myImageView.image = myImage
        container.addSubview(myImageView)
       
        myImageView.snp.makeConstraints{make in
            make.center.equalTo(container)
        }

        let cameraButton = UIButton(type: .system)
        container.addSubview(cameraButton)
        cameraButton.setTitle("take a picture!", for: .normal)
        cameraButton.tintColor = UIColor.white
        cameraButton.backgroundColor = UIColor.blue
        cameraButton.layer.shadowColor = UIColor.black.cgColor
        cameraButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        cameraButton.addTarget(self, action: #selector(onTappedCameraButton(_:)), for: .touchUpInside)

        cameraButton.snp.makeConstraints{make in
            make.top.equalTo(myImageView.snp.bottom).offset(10)
            make.centerX.equalTo(container)
        }

        let pictureButton = UIButton(type: .system)
        container.addSubview(pictureButton)
        pictureButton.setTitle("pickup a picture!", for: .normal)
        pictureButton.tintColor = UIColor.white
        pictureButton.backgroundColor = UIColor.blue
        pictureButton.layer.shadowColor = UIColor.black.cgColor
        pictureButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        pictureButton.addTarget(self, action: #selector(onTappedPictureButton(_:)), for: .touchUpInside)

        pictureButton.snp.makeConstraints{make in
            make.top.equalTo(cameraButton.snp.bottom).offset(10)
            make.centerX.equalTo(container)
        }

        let editButton = UIButton(type: .system)
        container.addSubview(editButton)
        editButton.setTitle("edit a picture!", for: .normal)
        editButton.tintColor = UIColor.white
        editButton.backgroundColor = UIColor.blue
        editButton.layer.shadowColor = UIColor.black.cgColor
        editButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        editButton.addTarget(self, action: #selector(onTappedEditButton(_:)), for: .touchUpInside)

        editButton.snp.makeConstraints{make in
            make.top.equalTo(pictureButton.snp.bottom).offset(10)
            make.centerX.equalTo(container)
        }

        let tranditionButton = UIButton(type: .system)
        container.addSubview(tranditionButton)
        tranditionButton.setTitle("trandition!", for: .normal)
        tranditionButton.tintColor = UIColor.white
        tranditionButton.backgroundColor = UIColor.blue
        tranditionButton.layer.shadowColor = UIColor.black.cgColor
        tranditionButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        tranditionButton.addTarget(self, action: #selector(onTappedTranditionButton(_:)), for: .touchUpInside)

        tranditionButton.snp.makeConstraints{make in
            make.top.equalTo(editButton.snp.bottom).offset(10)
            make.centerX.equalTo(container)
        }
        return container
    }()

//trandition用view
    private lazy var trandition: UIView = {
        let trandition = UIView()
        trandition.backgroundColor = UIColor.orange
        trandition.isHidden = true
        trandition.layer.position = CGPoint(x:self.view.frame.width/2, y:self.view.frame.height/2)
        
        return trandition
    }()

    func setCellIndex(index: Int, filter: String){
        selectedIndex = index
        print(selectedIndex!)

        if filter.isEmpty {
            selectedIndex = 0
            myImageView.image = myImage
            return
        }

        let filter: CIFilter = CIFilter(name: filter)!
        let ciImage: CIImage = CIImage(image: myImage)!

        filter.setValue(ciImage, forKey: kCIInputImageKey)

        if let filteredImage: CIImage = filter.outputImage {
            let context = CIContext(options: nil)
            let cgiImage = context.createCGImage(filteredImage, from: filteredImage.extent)

            let image = UIImage(cgImage: cgiImage!, scale: UIScreen.main.scale, orientation: myImage.imageOrientation)
            myImageView.image = image
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Nav1"
        self.view.addSubview(container)
        self.view.addSubview(trandition)
        container.snp.makeConstraints{make in
            make.edges.equalToSuperview()
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func onTappedCameraButton(_ sender: UIButton){
        let controller: UIAlertController = UIAlertController(title: "", message: "カメラを使用しますか？", preferredStyle: UIAlertControllerStyle.actionSheet)
        controller.addAction(UIAlertAction(title: "写真を撮影する", style: UIAlertActionStyle.default, handler: {(action) in self.selectedCamera()}))
        controller.addAction(UIAlertAction(title: "キャンセル", style: UIAlertActionStyle.cancel, handler: nil))

        self.present(controller, animated: true, completion: nil)
    }
    
    @objc func onTappedPictureButton(_ sender: UIButton){
        let controller: UIAlertController = UIAlertController(title: "", message: "カメラロールを使用しますか？", preferredStyle: UIAlertControllerStyle.actionSheet)
        controller.addAction(UIAlertAction(title: "写真を選択する", style: UIAlertActionStyle.default, handler: {(action) in self.selectedLibrary()}))
        controller.addAction(UIAlertAction(title: "キャンセル", style: UIAlertActionStyle.cancel, handler: nil))
        
        self.present(controller, animated: true, completion: nil)
    }
    @objc func onTappedEditButton(_ sender: UIButton){
        let vc = FilterListViewController(titleName: "filter")
        if (selectedIndex != nil) {
            vc.selectedIndex = selectedIndex!
            print(selectedIndex!)
        }else{
            vc.selectedIndex = 0
        }
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc func onTappedTranditionButton(_ sender: UIButton){
        if tranditionFlag {
            UIView.transition(from: self.view,
                              to: trandition,
									duration: 1.0,
									options: UIViewAnimationOptions.transitionCurlUp,
                                    completion: { (Bool) -> Void in
                                    	print("self.view -> trandition")
                                    	self.trandition.isHidden = false
                                    })
            tranditionFlag = false
        }else {
            UIView.transition(from: trandition,
                              to: self.view,
                                      duration: 1.0,
                                      options: UIViewAnimationOptions.transitionFlipFromLeft,
                                      completion: { (Bool) -> Void in

                                        print("trandition -> self.view")
            })
            tranditionFlag = true
        }
    }

    func selectedCamera(){
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
            let picker: UIImagePickerController = UIImagePickerController()
            picker.sourceType = UIImagePickerControllerSourceType.camera

            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
        }
    }

    func selectedLibrary(){
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary){
            let picker: UIImagePickerController = UIImagePickerController()
            picker.sourceType = UIImagePickerControllerSourceType.photoLibrary

            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        if let editedImage: UIImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            myImageView.image = editedImage
            myImage = editedImage

            selectedIndex = 0
        }

        picker.dismiss(animated: true, completion: nil)
    }

}

