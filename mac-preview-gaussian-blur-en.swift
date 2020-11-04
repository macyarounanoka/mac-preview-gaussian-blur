import Cocoa

let radius = 10.0 ; // default 10.0
let pbCopy = true

import Cocoa
import CoreImage
let pb = NSPasteboard.general;
let readData = pb.data(forType: NSPasteboard.PasteboardType.tiff)
if( readData == nil ){
    print("Please copy photos and images to clipboard");
    exit(1)
}
var ciClipboard = CIImage(data: readData!)
let nsimage = NSImage(data: readData!)

let filter = CIFilter(name:"CIGaussianBlur")
filter?.setDefaults()
filter?.setValue(ciClipboard, forKey:"inputImage")
filter?.setValue(radius, forKey:"inputRadius")

let outputImage = filter?.outputImage
let cropRect = CGRect(origin: CGPoint(x:0,y:0), size: ciClipboard!.extent.size)
let bmImg = NSBitmapImageRep(ciImage: outputImage!.cropped(to: cropRect))

if( pbCopy ){
    pb.clearContents();
    pb.setData(bmImg.tiffRepresentation!, forType: NSPasteboard.PasteboardType.tiff)
}

