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
    
    var addedIngredients: [String] = []
    var captureSession: AVCaptureSession!
    
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var feedbackLabel: UILabel!
    
    
    override func viewWillAppear(_ animated: Bool) {

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
                self.addedIngredients.append(firstObservation.identifier)
                //https://stackoverflow.com/questions/46218270/swift-4-must-be-used-from-main-thread-only-warning
                DispatchQueue.main.async {
                    self.feedbackLabel.text = "Found: \(firstObservation.identifier)"
                }
            }
        }
        try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
    }
    
    func isInList(identifiedIngredient: String) -> Bool {
        for ingredient in addedIngredients {
            if identifiedIngredient == ingredient {
                return true
            }
        }
        return false
    }
    
    @IBAction func cancelBtn(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let ingredientsViewController = segue.destination as! IngredientsViewController
        
        ingredientsViewController.addedIngredients = addedIngredients
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.captureSession.stopRunning()
    }
}



