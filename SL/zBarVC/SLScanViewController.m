//
//  SLScanViewController.m
//  ShuLianWang
//
//  Created by 郝威斌 on 15/3/27.
//  Copyright (c) 2015年 XXX. All rights reserved.
//

#import "SLScanViewController.h"

@interface SLScanViewController ()

@end

@implementation SLScanViewController

- (void)addNavigationLeftButton
{
    UIImageView *imageView = [UnityLHClass initUIImageView:@"左箭头大" rect:CGRectMake(0, 12,[UIImage imageNamed:@"左箭头大"].size.width/2,[UIImage imageNamed:@"左箭头大"].size.height/2)];
    UIButton* leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0,0,44,44);
    //    [leftButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    [leftButton addSubview:imageView];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addNavigationLeftButton];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    
    UILabel * labIntroudction= [[UILabel alloc] initWithFrame:CGRectMake(0, 68, kScreenWidth, 50)];
    labIntroudction.backgroundColor = [UIColor clearColor];
    labIntroudction.textAlignment = NSTextAlignmentCenter;
    labIntroudction.textColor=[UIColor whiteColor];
    labIntroudction.text=@"对准二维码到框内即可扫描";
    [self.view addSubview:labIntroudction];
    
    
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 120, kScreenWidth-40, 300)];
    imageView.image = [UIImage imageNamed:@"pick_bg"];
    [self.view addSubview:imageView];
    
    upOrdown = NO;
    num =0;
    _line = [[UIView alloc] initWithFrame:CGRectMake(25, 140, kScreenWidth-50, 1)];
    _line.backgroundColor=[UIColor greenColor];;
    [self.view addSubview:_line];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(animation1) userInfo:nil repeats:YES];
    
    
}

-(void)scanBtn
{
    
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
-(void)leftAction
{
    
    [self dismissViewControllerAnimated:YES completion:^{
        [timer invalidate];
    }];
}
-(void)viewWillAppear:(BOOL)animated
{
    [self setupCamera];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self dismissViewControllerAnimated:YES completion:^{
            [timer invalidate];
        }];
    }
}

- (void)setupCamera
{
    // Device
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Input
    NSError * error;
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:&error];
    
    if (!_input) {
        NSLog(@"%@",[error localizedDescription]);
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:@"你的手机没有摄像头" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    
    // Output
    _output = [[AVCaptureMetadataOutput alloc]init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // Session
    _session = [[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:self.input])
    {
        [_session addInput:self.input];
    }
    
    if ([_session canAddOutput:self.output])
    {
        [_session addOutput:self.output];
    }
    
    
    
    
    // 条码类型 AVMetadataObjectTypeQRCode
    _output.metadataObjectTypes =@[AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code, AVMetadataObjectTypeQRCode];
    
    // Preview
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:self.session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _preview.frame =CGRectMake(20,140,kScreenWidth-40,280);
    [self.view.layer insertSublayer:self.preview atIndex:0];
    
    // Start
    [_session startRunning];
}
#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    NSLog(@"%@",connection);
    NSString *stringValue;
    
    if (metadataObjects != nil &&[metadataObjects count] >0)
    {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
    }
    
    [_session stopRunning];
    
    
    [timer invalidate];
    
    if ([self isPureInt:stringValue]) {
        NSLog(@"shuzi");
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"目前还不能扫描出商品的信息" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }else{
//        WangZhanViewController *wangVC = [[WangZhanViewController alloc]init];
//        UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:wangVC];
//        wangVC.strUrl = stringValue;
//        //    wangVC.strUrl =[NSString stringWithFormat:@"http://search.anccnet.com/searchResult2.aspx?keyword=%@",stringValue];
//        wangVC.chuanTag = 4;
//        [self presentViewController:navc animated:YES completion:nil];
    }
    
}

- (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
