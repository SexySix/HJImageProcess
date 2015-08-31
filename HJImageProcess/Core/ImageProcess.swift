//
//  ImageProcess.swift
//  HJImageProcess
//
//  Created by JoeShao on 15/8/24.
//  Copyright (c) 2015年 JoeShao. All rights reserved.
//

import UIKit
import CoreImage

class ImageProcess: NSObject {
    var context: CIContext = {
        return CIContext(options: nil)
    }()
    var filter:CIFilter?
    var orginalImage :CIImage?
    func adjustImage(inputImage :UIImage)->UIImage {
        var input = CIImage(image: inputImage)
        let filters = input.autoAdjustmentFilters() as! [CIFilter]
        for filter: CIFilter in filters{
            println("\(filter)")
            filter.setValue(input, forKey: kCIInputImageKey)
            input = filter.outputImage
        }
        return getUIImage(input)
    }
    
    func changeImage(key:String,value:Float)->UIImage{
        filter!.setValue(value, forKey: key)
        return getUIImage(filter!.outputImage)
    }
    
    private func getUIImage(output:CIImage)->UIImage{
        let cgImage = context.createCGImage(output, fromRect: output.extent())
        return UIImage(CGImage: cgImage)!
    }
    
    
    class func fixOrientation(srcImg:UIImage)->UIImage{
        if srcImg.imageOrientation == UIImageOrientation.Up{
            return srcImg
        }
        var transform = CGAffineTransformIdentity
        switch srcImg.imageOrientation {
        case .Down,.DownMirrored:
            transform = CGAffineTransformTranslate(transform, srcImg.size.width, srcImg.size.height)
            transform = CGAffineTransformRotate(transform, CGFloat(M_PI))
        case .Left,.LeftMirrored:
            transform = CGAffineTransformTranslate(transform, srcImg.size.width, 0)
            transform = CGAffineTransformRotate(transform, CGFloat(M_PI_2))
        case .Right,.RightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, srcImg.size.height)
            transform = CGAffineTransformRotate(transform, CGFloat(-M_PI_2))
        case .Up,.UpMirrored:
            break
        }
        switch srcImg.imageOrientation {
        case .UpMirrored,.DownMirrored:
            transform = CGAffineTransformTranslate(transform, srcImg.size.width, 0)
            transform = CGAffineTransformScale(transform, -1, 1)
        case .LeftMirrored,.RightMirrored:
            transform = CGAffineTransformTranslate(transform, srcImg.size.height, 0)
            transform = CGAffineTransformScale(transform, -1, 1)
        case .Up,.Down,.Left,.Right:
            break
        }
        let ctx = CGBitmapContextCreate(nil, Int(srcImg.size.width), Int(srcImg.size.height), CGImageGetBitsPerComponent(srcImg.CGImage), 0, CGImageGetColorSpace(srcImg.CGImage), CGImageGetBitmapInfo(srcImg.CGImage))
        CGContextConcatCTM(ctx, transform)
        switch srcImg.imageOrientation{
        case .Left,.LeftMirrored,.Right,.RightMirrored:
            CGContextDrawImage(ctx, CGRect(x: 0, y: 0, width: srcImg.size.height, height: srcImg.size.width), srcImg.CGImage)
        default:
            CGContextDrawImage(ctx,CGRect(x: 0, y: 0, width: srcImg.size.width, height: srcImg.size.height), srcImg.CGImage)
        }
        let cgimg = CGBitmapContextCreateImage(ctx)
        let img = UIImage(CGImage: cgimg)
        return img!
    }
    
//    func processUsingCoreGraphics (input:UIImage)->UIImage{
//        var imageRect = CGRect(origin: CGPointZero, size: input.size)  //输入图片大小
//        var inputWidth =  CGRectGetWidth(imageRect) //输入图片宽度
//        var inputHeight = CGRectGetHeight(imageRect) //输入图片高度
//        
//        var ghostImage = UIImage(named: "ghost.png")  //获取幽灵图片
//        var ghostImageAspectRatio = ghostImage!.size.width / ghostImage!.size.height //获取幽灵图片比例
//        var targetGhostWidth = inputWidth * 0.25
//        var ghostSize = CGSize(width: targetGhostWidth, height: targetGhostWidth / ghostImageAspectRatio)
//        var ghostOrigin = CGPoint(x: inputWidth*0.5, y: inputHeight*0.2)
//        var ghostRect = CGRect(origin: ghostOrigin, size: ghostSize)
//        
//        UIGraphicsBeginImageContext(input.size)
//        var context = UIGraphicsGetCurrentContext()
//        var flip = CGAffineTransformMakeScale(1.0, -1.0)
//        var flipThenShift = CGAffineTransformTranslate(flip, 0, -inputHeight)
//        CGContextConcatCTM(context!, flipThenShift)  //将上下文从左上角坐标系转化为左下角坐标系
//        CGContextDrawImage(context!, imageRect, input.CGImage)
//        CGContextSetBlendMode(context!, kCGBlendModeSourceAtop)
//        CGContextSetAlpha(context!, 0.5)
//        var transformedGhostRect = CGRectApplyAffineTransform(ghostRect, flipThenShift)
//        CGContextDrawImage(context!, transformedGhostRect, ghostImage!.CGImage)
//        
//        var imageWithGhost = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        
//        var ghostPixels = calloc(0, sizeof(UInt32))
//        var colorSpace = CGColorSpaceCreateDeviceGray()
//        context = CGBitmapContextCreate(nil, Int(inputWidth), Int(inputHeight), 8, 0, colorSpace!, CGBitmapInfo(CGImageAlphaInfo.None.rawValue))
//        CGContextDrawImage(context, imageRect, imageWithGhost.CGImage)
//        var imageRef = CGBitmapContextCreateImage(context)
//        var finalImage = UIImage(CGImage: imageRef)
//        
//        return finalImage!
//    }
//    
//    func processUsingCoreImage (input:UIImage)->UIImage{
//        var inputCIImage = CIImage(image: input)
//        var grayFilter = CIFilter(name: "CIColorControls")
//        grayFilter.setValue(0, forKey: kCIInputSaturationKey)
//        
//        var ghostImage = UIImage(named: "ghost.png")
//        var ghostCIImage = CIImage(image: ghostImage)
//        
//        var alphaFilter = CIFilter(name: "CIColorMatrix")
//        var alphaVector = CIVector(x: 0, y: 0, z: 0.5, w: 0)
//        alphaFilter.setValue(alphaFilter, forKey: "inputAVector")
//        
//        var blendFilter = CIFilter(name: "CISourceAtopCompositing")
//        
//        alphaFilter.setValue(ghostCIImage, forKey: "inputImage")
//        ghostCIImage = alphaFilter.outputImage
//        blendFilter.setValue(ghostCIImage, forKey: "inputImage")
//        blendFilter.setValue(inputCIImage, forKey: "inputBackgroundImage")
//        var blendOutput = blendFilter.outputImage
//        grayFilter.setValue(blendOutput, forKey: "inputImage")
//        var outputCIImage = grayFilter.outputImage
//        
//        var context = CIContext(options: nil)
//        var outputCGImage = context.createCGImage(outputCIImage, fromRect: outputCIImage.extent())
//        var outputImage = UIImage(CGImage: outputCGImage)
//        
//        return outputImage!
//    }
}
