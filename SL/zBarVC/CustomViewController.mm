//
//  CustomViewController.m
//  ZXingDemo
//
//  Created by zhangcheng on 13-3-27.
//  Copyright (c) 2013年 zhangcheng All rights reserved.
//

#import "CustomViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "SLProductDetailViewController.h"
@interface CustomViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    AVCaptureDevice *inputDevice;
    UIButton *flashlightButton;
    BOOL flashlightOn;
    UIImageView *flashImgView;
    UILabel *flashLable;
}
@property(nonatomic,retain)AVCaptureSession * AVSession;
@end

#define  kScreenWidth  [[UIScreen mainScreen] bounds].size.width
#define  kScreenHeight  [[UIScreen mainScreen] bounds].size.height
@implementation CustomViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//        self.title = @"扫描二维码";
        UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];//allocate titleView
        titleView.backgroundColor = [UIColor clearColor];
        //    [UIColor colorWithRed:1.0/255.0 green:147.0/255.0 blue:236.0/255.0 alpha:1.0];
        //        UILabel *titlelabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
       UILabel* titlelabel = [UnityLHClass initUILabel:@"扫描二维码" font:16.0 color:[UIColor whiteColor] rect:CGRectMake(0, 0, 200, 44)];
        [titleView addSubview:titlelabel];
        titlelabel.textAlignment=NSTextAlignmentCenter;
        self.navigationItem.titleView = titleView;
    }
    return self;
}
-(id)initWithBlock:(void(^)(NSString*,BOOL))a{
    if (self=[super init]) {
        self.ScanResult=a;
        
    }

    return self;
}

-(void)addLfetBtn
{
    UIImageView *imageView = [UnityLHClass initUIImageView:@"左箭头大" rect:CGRectMake(-5, 10,[UIImage imageNamed:@"左箭头大"].size.width/2,[UIImage imageNamed:@"左箭头大"].size.height/2)];
    UIButton* leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0,0,44,44);
    //    [leftButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    [leftButton addSubview:imageView];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
}

-(void)viewWillAppear:(BOOL)animated
{
    
    self.isScanning = YES;
    [self.captureSession startRunning];
}

-(void)initView
{
    BOOL Custom= [UIImagePickerController
                  isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];//判断摄像头是否能用
    if (Custom) {
        [self initCapture];//启动摄像头
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您的设备没有摄像头" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    NSLog(@"%d",Custom);
    
    /////////////////////////////////////////////////////////////////////////////////
    UIImage *flashImg = [UIImage imageNamed:@"闪光灯.png"];
    
    flashImgView = [[UIImageView alloc]initWithImage:flashImg];
    [flashImgView setFrame:CGRectMake(10, self.view.frame.size.height - 40, flashImg.size.width/2, flashImg.size.height/2)];
    flashImgView.userInteractionEnabled = YES;
    [self.view addSubview:flashImgView];
    
    flashLable = [[UILabel alloc]initWithFrame:CGRectMake(40,self.view.frame.size.height - 40, 80, flashImg.size.height/2)];
    flashLable.text = @"打开闪光灯";
    flashLable.font = [UIFont systemFontOfSize:15.0];
    flashLable.textColor = [UIColor whiteColor];
    [self.view addSubview:flashLable];
    
    
    flashlightButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [flashlightButton setFrame:CGRectMake(10, self.view.frame.size.height - 40.f, 105, flashImg.size.height/2)];
    [flashlightButton setBackgroundColor:[UIColor clearColor]];
    [flashlightButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:flashlightButton];
    
    /////////////////////////////////////////////////////////////////////////////////
    
    
  //////////////////////////////////////////////////////////////////////////////////
    
    UIImage *cermaImg = [UIImage imageNamed:@"相册.png"];
    
    UIImageView *cermaImgView = [[UIImageView alloc]initWithImage:cermaImg];
    [cermaImgView setFrame:CGRectMake(kScreenWidth-120, self.view.frame.size.height - 40, cermaImg.size.width/2, cermaImg.size.height/2)];
    cermaImgView.userInteractionEnabled = YES;
    [self.view addSubview:cermaImgView];
    
    UILabel *cermaLable = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-90,self.view.frame.size.height - 40, 100, cermaImg.size.height/2)];
    cermaLable.text = @"从相册找";
    cermaLable.font = [UIFont systemFontOfSize:15.0];
    cermaLable.textColor = [UIColor whiteColor];
    [self.view addSubview:cermaLable];
    
    UIButton *cremaButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [cremaButton setFrame:CGRectMake(kScreenWidth-120, self.view.frame.size.height - 40.f, kScreenWidth-150, cermaImg.size.height/2)];
    [cremaButton setBackgroundColor:[UIColor clearColor]];
    [cremaButton addTarget:self action:@selector(pressPhotoLibraryButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cremaButton];
    
    /////////////////////////////////////////////////////////////////////////////////
    
   
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   self.view.backgroundColor = [UIColor blackColor];
    [self addLfetBtn];
   [self initView];
    [super viewDidLoad];
}


- (void)buttonPressed:(UIButton *)button
{
    if (button == flashlightButton)
    {
        if (flashlightOn == NO)
        {
            flashlightOn = YES;
            [inputDevice lockForConfiguration:nil];
            [inputDevice setTorchMode: AVCaptureTorchModeOn];
            [inputDevice unlockForConfiguration];
            flashImgView.image = [UIImage imageNamed:@"关闭闪光灯"];
            flashLable.text = @"关闭闪光灯";
        }
        else
        {
            flashlightOn = NO;
            [inputDevice lockForConfiguration:nil];
            [inputDevice setTorchMode: AVCaptureTorchModeOff];
            [inputDevice unlockForConfiguration];
            
            flashImgView.image = [UIImage imageNamed:@"闪光灯"];
            flashLable.text = @"打开闪光灯";
        }
        
        
        
    }
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1) {
        
    }else if (alertView.tag == 2){
        
    }else{
        if (buttonIndex == 0) {
            self.isScanning = NO;
            [self.captureSession stopRunning];
            
            self.ScanResult(nil,NO);
            
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
    
}


-(void)leftAction
{
    self.isScanning = NO;
    [self.captureSession stopRunning];
    
    self.ScanResult(nil,NO);
    
    [self dismissViewControllerAnimated:YES completion:^{
        [timer invalidate];
    }];
}


- (void)pressPhotoLibraryButton:(UIButton *)button
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.allowsEditing = YES;
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:^{
        self.isScanning = NO;
        [self.captureSession stopRunning];
    }];
}

-(void)animation1
{
    if (upOrdown == NO) {
        num ++;
        _line.frame = CGRectMake(25, 140+1*num, kScreenWidth-50, 1);
        if (1*num == 270) {
            upOrdown = YES;
        }
    }
    else {
        num --;
        _line.frame = CGRectMake(25, 140+1*num, kScreenWidth-50, 1);
        if (num == 0) {
            upOrdown = NO;
        }
    }
    
}

- (void)initCapture
{
    self.captureSession = [[AVCaptureSession alloc] init];
    
    inputDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    AVCaptureDeviceInput *captureInput = [AVCaptureDeviceInput deviceInputWithDevice:inputDevice error:nil];
    [self.captureSession addInput:captureInput];
    
    AVCaptureVideoDataOutput *captureOutput = [[AVCaptureVideoDataOutput alloc] init];
    captureOutput.alwaysDiscardsLateVideoFrames = YES;
    
    
    
    if (IOS7) {
        AVCaptureMetadataOutput*_output=[[AVCaptureMetadataOutput alloc]init];
 [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        [self.captureSession setSessionPreset:AVCaptureSessionPresetHigh];
        [self.captureSession addOutput:_output];
         _output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode];
        
        if (!self.captureVideoPreviewLayer) {
            self.captureVideoPreviewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.captureSession];
        }
        // NSLog(@"prev %p %@", self.prevLayer, self.prevLayer);
        self.captureVideoPreviewLayer.frame = CGRectMake(20,140,kScreenWidth-40,280);
        self.captureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        [self.view.layer addSublayer: self.captureVideoPreviewLayer];
        
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 130, kScreenWidth-30, 300)];
        imageView.image = [UIImage imageNamed:@"pick_bg@2x"];
        [self.view addSubview:imageView];
        
        upOrdown = NO;
        num =0;
        _line = [[UIView alloc] initWithFrame:CGRectMake(25, 140, kScreenWidth-50, 1)];
        _line.backgroundColor = [UIColor colorWithRed:58.0/255.0f green:135.0/255.0f blue:215.0/255.0f alpha:1];
//        [UIColor greenColor];
//        [UIColor colorWithRed:1.0/255.0 green:147.0/255.0 blue:236.0/255.0 alpha:1.0];
        [self.view addSubview:_line];
        
        timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(animation1) userInfo:nil repeats:YES];
        
        
        
        self.isScanning = YES;
        [self.captureSession startRunning];
        
        
    }else{
    [captureOutput setSampleBufferDelegate:self queue:dispatch_get_main_queue()];
        
        NSString* key = (NSString *)kCVPixelBufferPixelFormatTypeKey;
        NSNumber* value = [NSNumber numberWithUnsignedInt:kCVPixelFormatType_32BGRA];
        NSDictionary *videoSettings = [NSDictionary dictionaryWithObject:value forKey:key];
        [captureOutput setVideoSettings:videoSettings];
        [self.captureSession addOutput:captureOutput];
        
        NSString* preset = 0;
        if (NSClassFromString(@"NSOrderedSet") && // Proxy for "is this iOS 5" ...
            [UIScreen mainScreen].scale > 1 &&
            [inputDevice
             supportsAVCaptureSessionPreset:AVCaptureSessionPresetiFrame960x540]) {
                // NSLog(@"960");
                preset = AVCaptureSessionPresetiFrame960x540;
            }
        if (!preset) {
            // NSLog(@"MED");
            preset = AVCaptureSessionPresetMedium;
        }
        self.captureSession.sessionPreset = preset;
        
        if (!self.captureVideoPreviewLayer) {
            self.captureVideoPreviewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.captureSession];
        }
        // NSLog(@"prev %p %@", self.prevLayer, self.prevLayer);
        self.captureVideoPreviewLayer.frame = self.view.bounds;
        self.captureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        [self.view.layer addSublayer: self.captureVideoPreviewLayer];
        
        self.isScanning = YES;
        [self.captureSession startRunning];
        
        
    }
    
   
}

- (UIImage *) imageFromSampleBuffer:(CMSampleBufferRef) sampleBuffer
{
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    // Lock the base address of the pixel buffer
    CVPixelBufferLockBaseAddress(imageBuffer,0);
    
    // Get the number of bytes per row for the pixel buffer
    size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer);
    // Get the pixel buffer width and height
    size_t width = CVPixelBufferGetWidth(imageBuffer);
    size_t height = CVPixelBufferGetHeight(imageBuffer);
    
    // Create a device-dependent RGB color space
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    if (!colorSpace)
    {
        NSLog(@"CGColorSpaceCreateDeviceRGB failure");
        return nil;
    }
    
    // Get the base address of the pixel buffer
    void *baseAddress = CVPixelBufferGetBaseAddress(imageBuffer);
    // Get the data size for contiguous planes of the pixel buffer.
    size_t bufferSize = CVPixelBufferGetDataSize(imageBuffer);
    
    // Create a Quartz direct-access data provider that uses data we supply
    CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, baseAddress, bufferSize,
                                                              NULL);
    // Create a bitmap image from data supplied by our data provider
    CGImageRef cgImage =
    CGImageCreate(width,
                  height,
                  8,
                  32,
                  bytesPerRow,
                  colorSpace,
                  kCGImageAlphaNoneSkipFirst | kCGBitmapByteOrder32Little,
                  provider,
                  NULL,
                  true,
                  kCGRenderingIntentDefault);
    CGDataProviderRelease(provider);
    CGColorSpaceRelease(colorSpace);
    
    // Create and return an image object representing the specified Quartz image
    UIImage *image = [UIImage imageWithCGImage:cgImage];
    
       
    return image;
}

- (void)decodeImage:(UIImage *)image
{//进行解码
    
     self.isScanning = NO;
    ZBarSymbol *symbol = nil;
    
    ZBarReaderController* read = [ZBarReaderController new];
    read.readerDelegate = self;
    
    CGImageRef cgImageRef = image.CGImage;
    
    for(symbol in [read scanImage:cgImageRef])break;
    // 将获得到条形码显示到我们的界面上
 //   NSLog(@"Zbar---%@",symbol.data);
//     NSLog(@"%@",result.text);
    
    if (symbol!=nil) {

        self.ScanResult(symbol.data,YES);
        [self.captureSession stopRunning];
        
        if ([symbol.data rangeOfString:@"weixin.qq.com"].location != NSNotFound){
            NSLog(@"包含");
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"暂不支持微信二维码扫描" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            alert.tag = 2;
            [alert show];
        }else{
            NSLog(@"不包含");
            SLProductDetailViewController *productVC = [[SLProductDetailViewController alloc]init];
            productVC.productUrl = symbol.data;
            [self.navigationController pushViewController:productVC animated:YES];
        }
        
        
//        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
    
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"没有发现二维码" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    }
    
 
    
}

#pragma mark - AVCaptureVideoDataOutputSampleBufferDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
    UIImage *image = [self imageFromSampleBuffer:sampleBuffer];

    [self decodeImage:image];
}
#pragma mark AVCaptureMetadataOutputObjectsDelegate//IOS7下触发
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    
   
    if (metadataObjects.count>0)
    {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
         self.ScanResult(metadataObject.stringValue,YES);
        NSLog(@"%@",metadataObject.stringValue);
        
        if ([metadataObject.stringValue rangeOfString:@"weixin.qq.com"].location != NSNotFound){
            NSLog(@"包含");
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"暂不支持微信二维码扫描" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            alert.tag = 1;
            [alert show];
        }else{
            NSLog(@"不包含");
            SLProductDetailViewController *productVC = [[SLProductDetailViewController alloc]init];
            productVC.productUrl = metadataObject.stringValue;
            [self.navigationController pushViewController:productVC animated:YES];
        }
        
        
        
    }
    
    [self.captureSession stopRunning];
    
    
    
//    [self dismissViewControllerAnimated:YES completion:nil];
  
   
}



#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    [self dismissViewControllerAnimated:YES completion:^{
        [self decodeImage:image];
    }];
    
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{
        self.isScanning = YES;
        [self.captureSession startRunning];
    }];
}

#pragma mark - DecoderDelegate



+(NSString*)zhengze:(NSString*)str
{
    
    NSError *error;
    //http+:[^\\s]* 这是检测网址的正则表达式
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"http+:[^\\s]*" options:0 error:&error];//筛选
    
    if (regex != nil) {
        NSTextCheckingResult *firstMatch = [regex firstMatchInString:str options:0 range:NSMakeRange(0, [str length])];
        
        if (firstMatch) {
            NSRange resultRange = [firstMatch rangeAtIndex:0];
            //从urlString中截取数据
            NSString *result1 = [str substringWithRange:resultRange];
             NSLog(@"正则表达后的结果%@",result1);
            return result1;
           
        }
    }
    return nil;


}
#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    self.isScanning = YES;
    [self.captureSession startRunning];
    
}




#pragma mark - 打开闪关灯



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
