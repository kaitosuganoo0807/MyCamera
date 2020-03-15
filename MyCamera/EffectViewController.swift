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
    
    @IBAction func effectButtonAction(_ sender: Any) {
        // エフェクト前画像をアンラップしてエフェクト用画像として取り出す
        if let image = originalImage {
            
            // フィルター名を設定
            let filterName = "CIPhotoEffectMono"
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
            
        }
        
    }
    
    @IBAction func shareButtonAction(_ sender: Any) {
    }
    
    @IBAction func closeButtonAction(_ sender: Any) {
        // 画面を閉じて前の画面に戻る
        dismiss(animated: true, completion: nil)
    }
}
