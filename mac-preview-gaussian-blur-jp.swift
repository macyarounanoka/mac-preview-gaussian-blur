let ぼかし具合 = 10.0 ; // デフォルト 10.0 数値が大きいほどぼかし効果が高くなります。
let pbCopy = true

import Cocoa
import CoreImage
let pb = NSPasteboard.general();
let readData = pb.data(forType: NSPasteboardTypeTIFF)
if( readData == nil ){
    print("クリップボードへ写真・画像をコピーしてください。")
    exit(1)
}
var ciクリップボードイメージ = CIImage(data: readData!)
let nsimage = NSImage(data: readData!)

let filter = CIFilter(name:"CIGaussianBlur")
filter?.setDefaults()
filter?.setValue(ciクリップボードイメージ, forKey:"inputImage")
filter?.setValue(ぼかし具合, forKey:"inputRadius")

let outputImage = filter?.outputImage
let cropRect = CGRect(origin: CGPoint(x:0,y:0), size: ciクリップボードイメージ!.extent.size)
let bmImg = NSBitmapImageRep(ciImage: outputImage!.cropping(to: cropRect))

if( pbCopy ){
    pb.clearContents();
    pb.setData(bmImg.tiffRepresentation!, forType: NSPasteboardTypeTIFF)
}

