//
//  EffectViewController.swift
//  MyCamera
//
//  Created by 菅野魁斗 on 2020/03/15.
//  Copyright © 2020 kaito.sugano. All rights reserved.
//

import UIKit

class EffectViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // 画面遷移時に元の画像を表示
        effectImage.image = originalImage
    }
    

    // エフェクト前画像
    // 前の画面より画像を設定
    var originalImage : UIImage?
    
    @IBOutlet weak var effectImage: UIImageView!
    
    // フィルタ名を列挙した配列(Array)
    
    // 0.モノクロ
    // 1.Chrome
    // 2.Fade
    // 3.Instant
    // 4.Noir
    // 5.Process
    // 6.Tonal
    // 7.Transfer
    // 8.Sepia Tone
    let filterArray = ["CIPhotoEffectMono",
                        "CIPhotoEffectChrome",
                        "CIPhotoEffectFade",
                        "CIPhotoEffectInstant",
                        "CIPhotoEffectNoir",
                        "CIPhotoEffectProcess",
                        "CIPhotoEffectTonal",
                        "CIPhotoEffectTransfer",
                        "CISepiaTone"
    ]
    
    // 選択中のエフェクト添字
    var filterSelectNumber = 0
    
    @IBAction func effectButtonAction(_ sender: Any) {
        // エフェクト前画像をアンラップしてエフェクト用画像として取り出す
        if let image = originalImage {
            
            // フィルター名を設定
            let filterName = filterArray[filterSelectNumber]
            
            // 次の選択するエフェクト添字に変更
            filterSelectNumber += 1
            
            // 添字が配列の数と同じか？チェック
            if filterSelectNumber == filterArray.count {
                
                // 同じ場合は最後まで選択されたので先順に戻す
                filterSelectNumber = 0
            }
            // 元々の画像の回転角度を取得
            let rotate = image.imageOrientation
            // UIImage形式の画像をCIImage形式に変換
            let inputImage = CIImage(image: image)
            // フィルターの種別を引数で指定された種類を指定してCIFilterのインスタンスを取得
            guard let effectFilter = CIFilter(name: filterName) else {
                return
            }
            // エフェクトのパラメータを初期化
            effectFilter.setDefaults()
            
            // インスタンスにエフェクトする元画像を設定
            effectFilter.setValue(inputImage, forKey: kCIInputImageKey)
            
            // エフェクト後のCIImage形式の画像を取り出す
            guard let outputImage = effectFilter.outputImage else {
                return
            }
            // CIContextのインスタンスを取得
            let ciContext = CIContext(options: nil)
            
            // エフェクト後の画像をCIContext上に描画し、結果をcgImage形式の画像を取得
            guard let cgImage = ciContext.createCGImage(outputImage, from: outputImage.extent) else {
                return
            }
            // エフェクト後の画像をCGImage形式からUIImage形式に変換。その際に回転角度を指定。そしてImageViewに表示
            effectImage.image = UIImage(cgImage: cgImage, scale: 1.0, orientation: rotate)
        }
        
    }
    
    @IBAction func shareButtonAction(_ sender: Any) {
        
        if let shareImage = effectImage.image {
            
            let shareItems = [shareImage]
            
            let controller = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
            
            // シェアボタンの情報を取得
            let button = sender as! UIButton
            
            controller.popoverPresentationController?.sourceView = button
            
            present(controller, animated: true, completion: nil)
        }
    }
    
    @IBAction func closeButtonAction(_ sender: Any) {
        // 画面を閉じて前の画面に戻る
        dismiss(animated: true, completion: nil)
    }
}
