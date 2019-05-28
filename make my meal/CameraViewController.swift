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
    
    override func viewWillAppear(_ animated: Bool) {
       
        identifiedIngredients = []
        // Startup of the camera:
        let captureSession = AVCaptureSession()
        captureSession.sessionPreset = .photo
        
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
        
        guard let input = try? AVCaptureDeviceInput(device: captureDevice) else { return }
        
        captureSession.addInput(input)
        
        captureSession.startRunning()
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        view.layer.addSublayer(previewLayer)
        previewLayer.frame = view.frame
        
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
            
            //print(firstObservation.identifier, firstObservation.confidence)
            
            if (!firstObservation.confidence.isLessThanOrEqualTo(0.80)) && !self.isInList(identifiedIngredient: firstObservation.identifier) {
                print(firstObservation.identifier)
                
                self.identifiedIngredients.append(firstObservation.identifier)
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
        
        print(identifiedIngredients)
        
        performSegue(withIdentifier: "toRecipes", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "toRecipes") {
            
            let list = segue.destination as! ViewController
            
            list.searchedItems = self.identifiedIngredients
        }
    }
}



