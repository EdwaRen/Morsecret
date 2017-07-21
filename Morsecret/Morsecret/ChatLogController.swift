//
//  MorseTranslate.swift
//  Morsecret
//
//  Created by Edward Ren on 2017/07/18.
//  Copyright © 2017 Secretapp. All rights reserved.
//

import UIKit
import Firebase
import MobileCoreServices
import AVFoundation
import MediaPlayer


class ChatLogController: UICollectionViewController, UITextFieldDelegate, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var attemptedVideo : Bool? = false {
        
        didSet {
            let myTimer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(ChatLogController.showVideoMessageError), userInfo: nil, repeats: false)

        }
        willSet {
            print("Detected change in attemptedVideo willset ")
        }
    }
    var user: User? {
        didSet {
            navigationItem.title = user?.name
            
            observeMessages()
        }
    }
    
    var messages = [Message]()
    var inputMode = 1;
    
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
//        let alertController = UIAlertController(title: "Video Transfer Not Supported", message:
//            "Try limiting communication to text or images", preferredStyle: UIAlertControllerStyle.alert)
//        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
//        
//        self.present(alertController, animated: true, completion: nil)
        collectionView?.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        //        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        collectionView?.alwaysBounceVertical = true
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(ChatMessageCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView?.keyboardDismissMode = .interactive
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem:  UIBarButtonSystemItem.organize , target: self, action: #selector(showOptions))

        let myTim = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(ChatLogController.setupKeyboardObservers), userInfo: nil, repeats: false)
        
        if (volume == 1) {
            volume = 0.9;
        }else if (volume == 0) {
            volume = 0.1;
        }
    
        listenVolumeButton()
        
//        setupKeyboardObservers()
    }
    
    lazy var inputContainerView: ChatInputContainerView = {
        let chatInputContainerView = ChatInputContainerView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
        chatInputContainerView.chatLogController = self
        return chatInputContainerView
    }()
    
    func showOptions() {
        print("Options button clicked")
        inputContainerView.inputTextField.resignFirstResponder()
        
        if (inputMode == 0) {
            inputContainerView.inputTextField.isEnabled = true

        } else if (inputMode == 1) {
            inputContainerView.inputTextField.isEnabled = false
        }
        
    }
       
    func showVideoMessageError() {
        print("SHowing alert controller")
//        
//        let myAlert = AlertHelper()
//        myAlert.showAlert(fromController: self)
        
        let alertController = UIAlertController(title: "Video Transfer Not Supported", message:
            "Try limiting communication to text or images", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    fileprivate func handleVideoSelectedForUrl(_ url: URL) {
    }
    
    fileprivate func thumbnailImageForFileUrl(_ fileUrl: URL) -> UIImage? {
        let asset = AVAsset(url: fileUrl)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        
        do {
            
            let thumbnailCGImage = try imageGenerator.copyCGImage(at: CMTimeMake(1, 60), actualTime: nil)
            return UIImage(cgImage: thumbnailCGImage)
            
        } catch let err {
            print(err)
        }
        
        return nil
    }
    

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    override var inputAccessoryView: UIView? {
        get {
            return inputContainerView
        }
    }
    
    override var canBecomeFirstResponder : Bool {
        return true
    }
    
    func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardDidShow), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        
    }
    
    func handleKeyboardDidShow() {
        if messages.count > 1 {
            let indexPath = IndexPath(item: messages.count - 1, section: 0)
            //Occasionally crashes on the line below
            collectionView?.scrollToItem(at: indexPath, at: .top, animated: true)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    func handleKeyboardWillShow(_ notification: Notification) {
        let keyboardFrame = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
        let keyboardDuration = (notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue
        
        containerViewBottomAnchor?.constant = -keyboardFrame!.height
        UIView.animate(withDuration: keyboardDuration!, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    func handleKeyboardWillHide(_ notification: Notification) {
        let keyboardDuration = (notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue
        
        containerViewBottomAnchor?.constant = 0
        UIView.animate(withDuration: keyboardDuration!, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ChatMessageCell
        
        cell.chatLogController = self
        
        let message = messages[indexPath.item]
        
        cell.message = message
        
        cell.textView.text = message.text
        print(message.text)
        if (message.text == nil) {
            cell.morseImageView.isHidden = true
        } else {
            cell.morseImageView.isHidden = false
        }
        
        setupCell(cell, message: message)
        
        if let text = message.text {
            //a text message
            cell.bubbleWidthAnchor?.constant = estimateFrameForText(text).width + 32
            cell.textView.isHidden = false
        } else if message.imageUrl != nil {
            //fall in here if its an image message
            cell.bubbleWidthAnchor?.constant = 200
            cell.textView.isHidden = true
        }
        
        cell.playButton.isHidden = message.videoUrl == nil
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ChatMessageCell

        if(messages[indexPath.item].fromId != FIRAuth.auth()?.currentUser?.uid  ) {
            print("Cell tap detected", messages[indexPath.item].text)
            
            if (messages[indexPath.item].text != nil) {
            
                let a = MorseTranslate()
            
                let morseText: String = a.stringIntoMorseDotsDashes(text: messages[indexPath.item].text!)
                a.timerMorseToVibrations(text: morseText)
            }
            
        }
//        let url = thumbnailFileURLS[indexPath.item]
//        if UIApplication.sharedApplication().canOpenURL(url) {
//            UIApplication.sharedApplication().openURL(url)
//        }
    }
    
    fileprivate func setupCell(_ cell: ChatMessageCell, message: Message) {
        if let profileImageUrl = self.user?.profileImageUrl {
            cell.profileImageView.loadImageUsingCacheWithUrlString(profileImageUrl)
        }
        
        if message.fromId == FIRAuth.auth()?.currentUser?.uid {
            //outgoing blue
            cell.bubbleView.backgroundColor = ChatMessageCell.blueColor
            cell.textView.textColor = UIColor.white
            cell.profileImageView.isHidden = true
            
            cell.bubbleViewRightAnchor?.isActive = true
            cell.bubbleViewLeftAnchor?.isActive = false
            
        } else {
            //incoming text, still grey

            cell.bubbleView.backgroundColor = UIColor(r: 240, g: 240, b: 240)
            cell.textView.textColor = UIColor.black
            cell.profileImageView.isHidden = false
            
            cell.bubbleViewRightAnchor?.isActive = false
            cell.bubbleViewLeftAnchor?.isActive = true
        }
        
        if let messageImageUrl = message.imageUrl {
            cell.messageImageView.loadImageUsingCacheWithUrlString(messageImageUrl)
            cell.messageImageView.isHidden = false
            cell.bubbleView.backgroundColor = UIColor.clear
        } else {
            cell.messageImageView.isHidden = true
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height: CGFloat = 80
        
        let message = messages[indexPath.item]
        if let text = message.text {
            height = estimateFrameForText(text).height + 20
        } else if let imageWidth = message.imageWidth?.floatValue, let imageHeight = message.imageHeight?.floatValue {
            
            // h1 / w1 = h2 / w2
            // solve for h1
            // h1 = h2 / w2 * w1
            
            height = CGFloat(imageHeight / imageWidth * 200)
            
        }
        
        let width = UIScreen.main.bounds.width
        return CGSize(width: width, height: height)
    }
    
    fileprivate func estimateFrameForText(_ text: String) -> CGRect {
        let size = CGSize(width: 200, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16)], context: nil)
    }
    
    var containerViewBottomAnchor: NSLayoutConstraint?
    
    func handleSend() {
        let properties = ["text": inputContainerView.inputTextField.text!]
        if (inputContainerView.inputTextField.text != "") {
            inputContainerView.inputTextField.text = ""
            sendMessageWithProperties(properties as [String : AnyObject])
        } else {
            print("User has attempted to send message of null")
        }
    }
    
   
    
    
    
    var startingFrame: CGRect?
    var blackBackgroundView: UIView?
    var startingImageView: UIImageView?
    
    //my custom zooming logic
    func performZoomInForStartingImageView(_ startingImageView: UIImageView) {
        
        self.startingImageView = startingImageView
        self.startingImageView?.isHidden = true
        
        startingFrame = startingImageView.superview?.convert(startingImageView.frame, to: nil)
        
        let zoomingImageView = UIImageView(frame: startingFrame!)
        zoomingImageView.backgroundColor = UIColor.red
        zoomingImageView.image = startingImageView.image
        zoomingImageView.isUserInteractionEnabled = true
        zoomingImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleZoomOut)))
        
        if let keyWindow = UIApplication.shared.keyWindow {
            blackBackgroundView = UIView(frame: keyWindow.frame)
            blackBackgroundView?.backgroundColor = UIColor.black
            blackBackgroundView?.alpha = 0
            keyWindow.addSubview(blackBackgroundView!)
            
            keyWindow.addSubview(zoomingImageView)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.blackBackgroundView?.alpha = 1
                self.inputContainerView.alpha = 0
                
                // math?
                // h2 / w1 = h1 / w1
                // h2 = h1 / w1 * w1
                let height = self.startingFrame!.height / self.startingFrame!.width * keyWindow.frame.width
                
                zoomingImageView.frame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height)
                
                zoomingImageView.center = keyWindow.center
                
            }, completion: { (completed) in
                //                    do nothing
            })
            
        }
    }
    
    func handleZoomOut(_ tapGesture: UITapGestureRecognizer) {
        if let zoomOutImageView = tapGesture.view {
            //need to animate back out to controller
            zoomOutImageView.layer.cornerRadius = 16
            zoomOutImageView.clipsToBounds = true
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                zoomOutImageView.frame = self.startingFrame!
                self.blackBackgroundView?.alpha = 0
                self.inputContainerView.alpha = 1
                
            }, completion: { (completed) in
                zoomOutImageView.removeFromSuperview()
                self.startingImageView?.isHidden = false
            })
        }
    }
    
    var hello: Bool = false;
    var volume:Float = AVAudioSession.sharedInstance().outputVolume;
    var detected: Bool = false;
    var needASpace: Bool = false; //inserts a space to distinguish words in morse code
    var counterVibrate:Float = 0;
    var inputMessage: String = "";
    
    
    var timeCounter = 0;
    var messageTime = Array(repeating: Array(repeating: -1, count: 2), count: 10000)
    
    var spaceTimer: Timer?
    




    
//    @IBOutlet weak var inputLabel: UILabel!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func resetVolume() {
        let volumeView = MPVolumeView()
        if let view = volumeView.subviews.first as? UISlider{
            detected = true;
            view.value = volume //---0 t0 1.0---
            //            detected = false;
            detected = false
//            let myTimer = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(ChatLogController.resetBool), userInfo: nil, repeats: false);
            
        }
    }
    
    func resetBool() {
        detected = false;
    }
    
    func listenVolumeButton() {
        let audioSession = AVAudioSession()
        do {
            try audioSession.setActive(true)
        } catch {
            print("some error")
        }
        audioSession.addObserver(self, forKeyPath: "outputVolume", options: NSKeyValueObservingOptions.new, context: nil)
    }
    
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "outputVolume" {
            print("click detected");
            if (detected == false && inputMode == 1){
                
                if (AVAudioSession.sharedInstance().outputVolume > volume) {
                    counterVibrate += 1;
                    print(counterVibrate, "greater");
                    inputContainerView.inputTextField.text = inputContainerView.inputTextField.text! + "."
                    AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate));
                    spaceTimer?.invalidate()
                    spaceTimer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(ChatLogController.insertSpaceHere), userInfo: nil, repeats: false);
                    
//                    spaceTimer?.fire()

                    
                } else if (AVAudioSession.sharedInstance().outputVolume < volume) {
                    print(counterVibrate, "less");
                    counterVibrate += 1;
                    inputContainerView.inputTextField.text = inputContainerView.inputTextField.text! + "-"
                    AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate));
                    let mytimer = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(ChatLogController.playAlertAgain), userInfo: nil, repeats: false)
                    
                    
                    spaceTimer?.invalidate()

                    spaceTimer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(ChatLogController.insertSpaceHere), userInfo: nil, repeats: false);

//                    spaceTimer?.fire()

                } else {
                    print("volume still the same");
                    print("Detected", detected);
                }
                print(" ");
                
                _ = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(ChatLogController.resetVolume), userInfo: nil, repeats: false);
                

            }
        }
        
        
    }
    
    @objc func playAlertAgain() {
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate));
        
    }
    
    func insertSpaceHere() {
        print("Added a space ")
        inputContainerView.inputTextField.text = inputContainerView.inputTextField.text! + " "
        
    }
   

    
    
}













