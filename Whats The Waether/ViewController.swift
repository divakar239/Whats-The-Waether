//
//  ViewController.swift
//  Whats The Waether
//
//  Created by Divakar Kapil on 2016-05-19.
//  Copyright © 2016 Divakar Kapil. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cityTextField: UITextField!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBAction func findWeather(sender: AnyObject) {
        
        var wasSuccesful = false
        
        let attemptedUrl = NSURL(string: "http://www.weather-forecast.com/locations/" + cityTextField.text!.stringByReplacingOccurrencesOfString(" ", withString: "-") + "/forecasts/latest")
        
        if let url = attemptedUrl {
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            
            if let urlContent = data{
                
                let webContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding)
                
                let webArray = webContent!.componentsSeparatedByString("3 Day Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">")
                
                // To check if the array has elements of type NSString before we proceed
                
                if webArray.count > 1{
                    
                    let weatherArray = webArray[1].componentsSeparatedByString("</span>")
                    
                    if weatherArray.count > 1{
                        
                        wasSuccesful = true
                        
                        let weatherSummary = weatherArray[0].stringByReplacingOccurrencesOfString("&deg;", withString: "º")
                        
                        dispatch_async(dispatch_get_main_queue(), {()-> Void in
                            
                            self.resultLabel.text = weatherSummary
                        })
                        
                    }
                    
                }
                
                if wasSuccesful == false{
                    
                    self.resultLabel.text = " Couldn't find the weather for this city..."
                }
                
            }
            
            
        }
        
        task.resume()
        
        
    }
        else{
         
            self.resultLabel.text = " Couldn't find the weather for this city..."

        }
    
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

