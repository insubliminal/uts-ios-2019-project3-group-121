//
//  CameraViewController.swift
//  make my meal
//
//  Created by Insub Lim on 28/5/19.
//  Copyright © 2019 Insub Lim. All rights reserved.
//

import UIKit
import AVKit
import Vision

class CameraViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    var identifiedIngredients: [String] = []
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var feedbackLabel: UILabel!
    var captureSession: AVCaptureSession!
    
    override func viewWillAppear(_ animated: Bool) {
        
        identifiedIngredients = []
        // Startup of the camera:
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .photo
        
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
        
        guard let input = try? AVCaptureDeviceInput(device: captureDevice) else { return }
        
        captureSession.addInput(input)
        
        captureSession.startRunning()
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        view.layer.addSublayer(previewLayer)
        //Make the Camera fit to our storyboard view dimensions.
        previewLayer.frame = cameraView.frame
        
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        captureSession.addOutput(dataOutput)
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
        guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        
        guard let model = try? VNCoreMLModel(for: Resnet50().model) else { return }
        let request = VNCoreMLRequest(model: model) { (finishedReq, err) in
            
            guard let results = finishedReq.results as? [VNClassificationObservation] else { return }
            guard let firstObservation = results.first else { return }
            
            //If the Camera is 80% or more certain that it has detected an object and it isn't in the list to of ingredient, add it to the ingredients list
            if (!firstObservation.confidence.isLessThanOrEqualTo(0.80)) && !self.isInList(identifiedIngredient: firstObservation.identifier) {
                
                print(firstObservation.identifier)
                
                self.identifiedIngredients.append(firstObservation.identifier)
                
                self.feedbackLabel.text = "Found: \(firstObservation.identifier)"
            }
            
        }
        try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
    }
    
    func isInList(identifiedIngredient: String) -> Bool {
        
        for ingredient in identifiedIngredients {
            if identifiedIngredient == ingredient {
                return true
            }
        }
        return false
    }
    
    @IBAction func getList(_ sender: Any) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toAddedIngredientsList" else {return}
        
        let ingredientsTableViewController = segue.destination as! IngredientsTableViewController
        ingredientsTableViewController.addedIngredients = identifiedIngredients
        
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.captureSession.stopRunning()
    }
}



