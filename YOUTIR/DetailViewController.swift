//
//  DetailViewController.swift
//  YOUTIR
//
//  Created by Tom Malary on 4/13/15.
//  Copyright (c) 2015 YOUTIR LLC. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, PFLogInViewControllerDelegate {
    
    @IBOutlet var carrierNameLabel: UILabel!
    @IBOutlet var transitRateLabel: UILabel!
    @IBOutlet var transitTimeLabel: UILabel!
    @IBOutlet var logoImage: PFImageView!
    @IBOutlet var carrierTelLabel: UILabel!
    @IBOutlet var carrierWebLabel: UILabel!
    @IBOutlet var requestSpecsLabel: UILabel!

    //test the pointer, should be deleted later
    @IBOutlet var testRequestPointer: UILabel!
    
    var quote: Quote!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        quote.fetchIfNeeded()
        self.carrierNameLabel.text = quote.carrier["name"] as! String
        self.transitRateLabel.text = String(quote.transitRate)
        self.transitTimeLabel.text = String(quote.transitTime)
        self.carrierTelLabel.text = quote.carrier["telephone"] as! String
        self.carrierWebLabel.text = quote.carrier["web"] as! String
        self.logoImage.image = UIImage(named: "placeholder")
        
        // The request specs data to fill out the label
        quote.request.fetchIfNeeded()
        var fromCity = quote.request.fromCity
        var toCity = quote.request.toCity
        var weight = quote.request.weight
        var length = quote.request.length
        var width = quote.request.width
        var height = quote.request.height
        var insurance = quote.request.insurance
        
        self.callForLogin()
        
        self.requestSpecsLabel.text = "From: \(fromCity), To: \(toCity), LxWxH: \(length)x\(width)x\(height), Insurance: \(insurance)"
        
        let logoImageFile = quote.carrier["logoImage"] as! PFFile
        logoImageFile.getDataInBackgroundWithBlock {
            (imageData: NSData?, error: NSError?) -> Void in
            if error == nil {
                if let imageData = imageData {
                    self.logoImage.image = UIImage(data: imageData)
                }
            }
        }
        
        
        // To check if PFUser != nil then show pay else show login using alpha method 0 or 1, or text and func of the same button + alpha for name of the user name and logout button alpha.

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func callForLogin() {
        var logInController = PFLogInViewController()
        logInController.delegate = self
        
        logInController.facebookPermissions = ["email", "public_profile"]
        
        logInController.fields = (PFLogInFields.UsernameAndPassword
            | PFLogInFields.LogInButton
            | PFLogInFields.SignUpButton
            | PFLogInFields.PasswordForgotten
            | PFLogInFields.DismissButton
            | PFLogInFields.Facebook
            | PFLogInFields.Twitter)
        
        self.presentViewController(logInController, animated:true, completion: nil)
    }

    //Функции вызываются после попытки логина с случае успеха и неудачи соотвественно
    
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func logInViewControllerDidCancelLogIn(controller: PFLogInViewController) -> Void {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
