//
//  ViewController.swift
//  GoSellAppClip
//
//  Created by Osama Rabie on 11/20/20.
//  Copyright © 2020 Tap Payments. All rights reserved.
//

import UIKit
import goSellSDK

class ViewController: UIViewController {

    var transactionAmount:Double = 100
    var session:Session = .init()
    @IBOutlet weak var amoountTextField: UITextField!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        GoSellSDK.secretKey = SecretKey(sandbox:    "sk_test_1eI2Mltgf4hwSY5zN86sHGnK",
                                        production:    "sk_live_jhVg4ceUqDoBrLNwzu71I5ti")
        GoSellSDK.mode = .sandbox
        GoSellSDK.language = "en"
        session.delegate = self
        session.dataSource = self
        
    }

    @IBAction func payInMainApp(_ sender: Any) {
    }
    @IBAction func payInAppClip(_ sender: Any) {
        session.start()
    }
    
    
    private func startLoader() {
        loader.isHidden = false
    }
    
    private func stopLoader() {
        loader.isHidden = true
    }
}


extension ViewController:SessionDataSource {
    var customer: Customer? {
        return try! .init(emailAddress: nil, phoneNumber: .init(isdNumber: "965", phoneNumber: "90064542") , firstName: "Tap", middleName: "Payments", lastName: "Clips")
    }
    
    
    internal var applePayMerchantID: String
    {
        return "merchant.tap.gosell"
    }
    
    internal var merchantID: String?
    {
        return "1124340"
    }
    
    internal var mode: TransactionMode {
        
        return .purchase
    }
    
    var currency: Currency? {
        return try! .init(isoCode: "KWD")
    }
    
    var amount: Decimal{
        return .init(Double(amoountTextField.text ?? "100") ?? transactionAmount)
    }
}




extension ViewController: SessionDelegate {
    
    internal func paymentSucceed(_ charge: Charge, on session: SessionProtocol) {
        
        // payment succeed, saving the customer for reuse.
        
        if let customerID = charge.customer.identifier {
            
            self.saveCustomer(customerID)
            
        }
    }
    
    
    internal func applePaymentTokenizationFailed(_ error: String, on session: SessionProtocol) {
        
    }
    internal func applePaymentTokenizationSucceeded(_ token: Token, on session: SessionProtocol) {
        
    }
    
    internal func applePaymentSucceed(_ charge: String, on session: SessionProtocol) {
        //print(charge)
        let alert = UIAlertController(title: "Message from SDK delegate", message: charge, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default,handler: { action in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.session.stop {
            self.present(alert, animated: true)
        }
    }
    
    internal func applePaymentCanceled(on session: SessionProtocol)
    {
        let alert = UIAlertController(title: "Message from SDK delegate", message: "User Canceled", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default,handler: { action in
            alert.dismiss(animated: true, completion: nil)
        }))
        //self.session.stop {
        //  self.present(alert, animated: true)
        //}
    }
    
    
    internal func applePaymen(_ charge: String, on session: SessionProtocol) {
        //print(charge)
        let alert = UIAlertController(title: "Message from SDK delegate", message: charge, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default,handler: { action in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.session.stop {
            self.present(alert, animated: true)
        }
    }
    
    internal func authorizationSucceed(_ authorize: Authorize, on session: SessionProtocol) {
        
        // authorization succeed, saving the customer for reuse.
        
        if let customerID = authorize.customer.identifier {
            
            self.saveCustomer(customerID)
            
        }
    }
    
    // payment failed, payment screen closed.
    func paymentFailed(with charge: Charge?, error: TapSDKError?, on session: SessionProtocol) {
        if let error = error {
            let errorMessage:String = "\(error) \n \(error.description)"
            let alert:UIAlertController  = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
            let copyAction:UIAlertAction = UIAlertAction(title: "Copy", style: .destructive) { (_) in
                UIPasteboard.general.string = errorMessage
            }
            alert.addAction(copyAction)
            present(alert, animated: true, completion: nil)
        }
    }
    
    internal func authorizationFailed(with authorize: Authorize?, error: TapSDKError?, on session: SessionProtocol) {
        
        // authorization failed, payment screen closed.
    }
    
    internal func sessionCancelled(_ session: SessionProtocol) {
        
        // payment cancelled (user manually closed the payment screen).
    }
    
    internal func cardSaved(_ cardVerification: CardVerification, on session: SessionProtocol) {
        
        // card successfully saved.
        
        if let customerID = cardVerification.customer.identifier {
            
            self.saveCustomer(customerID)
            
        }
    }
    
    internal func cardSavingFailed(with cardVerification: CardVerification?, error: TapSDKError?, on session: SessionProtocol) {
        
        // card failed to save.
    }
    
    internal func cardTokenized(_ token: Token, on session: SessionProtocol, customerRequestedToSaveTheCard saveCard: Bool) {
        
        // card has successfully tokenized.
    }
    
    internal func cardTokenizationFailed(with error: TapSDKError, on session: SessionProtocol) {
        
        // card failed to tokenize
    }
    
    internal func sessionIsStarting(_ session: SessionProtocol) {
        
        // session is about to start, but UI is not yet shown.
        
        self.startLoader()
    }
    
    internal func sessionHasStarted(_ session: SessionProtocol) {
        
        // session has started, UI is shown (or showing)
        
        self.stopLoader()
    }
    
    internal func sessionHasFailedToStart(_ session: SessionProtocol) {
        
        // session has failed to start.
        
        self.stopLoader()
    }
    
    // MARK: - Private -
    // MARK: Methods
    
    private func saveCustomer(_ customerID: String) {
    }
}
