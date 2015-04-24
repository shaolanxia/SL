//
//  SLInformationViewController.m
//  ShuLianWang
//
//  Created by 郝威斌 on 15/3/29.
//  Copyright (c) 2015年 XXX. All rights reserved.
//

#import "SLInformationViewController.h"
#import "SLEditPassWordViewController.h"
#import "AppDelegate.h"
#import "RootTAMViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "SLEditRealNameViewController.h"
@interface SLInformationViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,ASIHTTPRequestDelegate>
{
    NSArray *sectionArray1;
    NSArray *sectionArray2;
    NSArray *array;
    NSDictionary *dataDic;
    UIView *rightView;
    UIImageView *userPhotoImgView;
    
    UIImage *newImg; //裁剪后的图片
    
    NSString *strPath; //图片的路径
    UITextField *userNameFiled;
    NSString *strUserName; //昵称
    NSString *strQQ; //QQ号
    NSURL *imageDataUrl;
    NSString *strID; //用户ID
}
@end

@implementation SLInformationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"个人信息";
        UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];//allocate titleView
        titleView.backgroundColor = [UIColor clearColor];
        
        UILabel* titlelabel = [UnityLHClass initUILabel:@"个人信息" font:16.0 color:[UIColor whiteColor] rect:CGRectMake(0, 0, 200, 44)];
        [titleView addSubview:titlelabel];
        self.navigationItem.titleView = titleView;
        titlelabel.textAlignment=NSTextAlignmentCenter;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    strID = [user objectForKey:@"userId"];
}


- (void)addNavigationRightBtn
{
    UIButton *forwardButton = [UIButton buttonWithType:UIButtonTypeCustom];
    forwardButton.frame = CGRectMake(kScreenWidth-[UIImage imageNamed:@"点点"].size.width/2, 12,[UIImage imageNamed:@"点点"].size.width/2,[UIImage imageNamed:@"点点"].size.height/2);
    [forwardButton setBackgroundImage:[UIImage imageNamed:@"点点"] forState:UIControlStateNormal];
    forwardButton.titleLabel.text = @"1";
    [forwardButton addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:forwardButton];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavigationLeftButton];
    [self addNavigationRightBtn];
    // Do any additional setup after loading the view.
    sectionArray1 = [[NSArray alloc]initWithObjects:@"头像",@"昵称",@"邮箱",@"手机号",@"密码", nil];
    sectionArray2 = [[NSArray alloc]initWithObjects:@"联系方式",@"QQ号", nil];
    
    dataDic = [[NSDictionary alloc]initWithObjectsAndKeys:sectionArray1,@"one",sectionArray2,@"two", nil];
    
    array = [[NSArray alloc]initWithObjects:@"one",@"two", nil];
    
    [self initView];
    [self initRightView];
}

-(void)initRightView
{
    rightView = [[UIView alloc]initWithFrame:CGRectMake(220, 64, 100, 100)];
    rightView.backgroundColor = [UIColor whiteColor];
    rightView.hidden = YES;
    [self.view addSubview:rightView];
    
    UIImageView *lineImag = [[UIImageView alloc]initWithFrame:CGRectMake(0, 50, 100, 1)];
    lineImag.image = [UIImage imageNamed:@"02-01-line"];
    [rightView addSubview:lineImag];
    
    UIImage *leftImg = [UIImage imageNamed:@"搜索灰"];
    UIImage *leftImg1 = [UIImage imageNamed:@"首页"];
    
    UIImageView *leftImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, leftImg.size.width/2, leftImg.size.height/2)];
    leftImgView.image = leftImg;
    [rightView addSubview:leftImgView];
    
    UIButton *seachBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [seachBtn setFrame:CGRectMake(30, 15, 60, 20)];
    [seachBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [seachBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [seachBtn addTarget:self action:@selector(seachBtn) forControlEvents:UIControlEventTouchUpInside];
    [rightView addSubview:seachBtn];
    
    UIImageView *leftImgView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 55, leftImg1.size.width/2, leftImg1.size.height/2)];
    leftImgView1.image = leftImg1;
    [rightView addSubview:leftImgView1];
    
    
    UIButton *homeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [homeBtn setFrame:CGRectMake(30, 60, 60, 20)];
    [homeBtn setTitle:@"首页" forState:UIControlStateNormal];
    [homeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [homeBtn addTarget:self action:@selector(homeBtn) forControlEvents:UIControlEventTouchUpInside];
    [rightView addSubview:homeBtn];
}

#pragma mark == 右上方的按钮
-(void)rightAction:(UIButton *)sender
{
    NSLog(@"点击右边的按钮");
    if ([sender.titleLabel.text isEqualToString:@"0"]) {
        
        rightView.hidden = YES;
        sender.titleLabel.text=@"1";
        
    }else{
        rightView.hidden = NO;
        sender.titleLabel.text=@"0";
        
    }
    
}

#pragma mark == 右上方的搜索按钮
-(void)seachBtn
{
    NSLog(@"点击了搜索按钮");
}

#pragma mark == 右上方的首页按钮
-(void)homeBtn
{
    NSLog(@"点击了首页按钮");
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    RootTAMViewController* rootVc = [[RootTAMViewController alloc] init];
    
    
    [appDelegate.window setBackgroundColor:[UIColor whiteColor]];
    [appDelegate.window makeKeyAndVisible];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:1.0/255.0 green:147.0/255.0 blue:236.0/255.0 alpha:1.0]];
    
    appDelegate.window.rootViewController = rootVc;
}


-(void)initView
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return array.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSString *string = [array objectAtIndex:section];
    NSArray *row = [dataDic objectForKey:string];
    return row.count;
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifiercell";
    UITableViewCell *cell =  [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        UILabel *rightLable = [UnityLHClass initUILabel:@"" font:15.0 color:[UIColor grayColor] rect:CGRectMake(kScreenWidth-180, 0, 150, 44)];
        rightLable.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:rightLable];
        
        
        
        
        if (indexPath.section == 0) {
            
            if (indexPath.row == 0) {
                userPhotoImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"moren.png"]];
                userPhotoImgView.frame = CGRectMake(kScreenWidth-100, 10, 60, 60);
                userPhotoImgView.layer.masksToBounds = YES;
                userPhotoImgView.layer.cornerRadius = 30;
                [cell.contentView addSubview:userPhotoImgView];
                
                if ([[self.userData objectForKey:@"avatarPic"] description] == nil) {
                    userPhotoImgView.image = [UIImage imageNamed:@"moren.png"];
                }else{
                    [userPhotoImgView sd_setImageWithURL:[NSURL URLWithString:[self.userData objectForKey:@"avatarPic"]] placeholderImage:[UIImage imageNamed:@"moren.png"]];
                }
                
                rightLable.hidden = YES;
                
            }else if (indexPath.row == 1){
                
                rightLable.hidden = NO;
                rightLable.text = [NSString stringWithFormat:@"%@",[self.userData objectForKey:@"realName"]];
                

                
            }else if (indexPath.row == 2){
                if ([[self.userData objectForKey:@"serviceMobile"] description] == nil) {
                    rightLable.text = @"未绑定";
                }else{
                    rightLable.text = [NSString stringWithFormat:@"%@",[self.userData objectForKey:@"email"]];
                }
                
            }else if (indexPath.row == 3){
                rightLable.text = @"未绑定";
            }else{
                
            }
        }else{
            if (indexPath.row == 0) {
                
                rightLable.text = [NSString stringWithFormat:@"%@",[self.userData objectForKey:@"serviceMobile"]];
                
            }else{
                
                
                rightLable.text = [NSString stringWithFormat:@"%@",[self.userData objectForKey:@"serviceQQ"]];
            }
 
        }
    }
    
    NSString *string = [array objectAtIndex:indexPath.section];
    NSArray *arrayy = [dataDic objectForKey:string];
    cell.textLabel.text = [arrayy objectAtIndex:indexPath.row];
    
    return cell;
}




-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    //    return [array objectAtIndex:section];
    return @"";
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else{
        return 1;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            [self editor];
            [self.tableView reloadData];
        }else if (indexPath.row == 1){
            SLEditRealNameViewController *editVC = [[SLEditRealNameViewController alloc]init];
            [self.navigationController pushViewController:editVC animated:YES];
        }else if (indexPath.row == 2){
            
        }else if (indexPath.row == 3){
            
        }else if (indexPath.row == 4){
            SLEditPassWordViewController *editVC = [[SLEditPassWordViewController alloc]init];
            [self.navigationController pushViewController:editVC animated:YES];
        }
        
    }else{
        if (indexPath.row == 0) {
            NSLog(@"0");
        }else {
            NSLog(@"1");
            
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            return 80;
        }
    }
    return 44;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField.tag == 1) {
        
    }else if (textField.tag == 2){
        
    }else{
        
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == 1) {
        strUserName = textField.text;
    }else if (textField.tag == 2){
        strQQ = textField.text;
    }else{
        
    }
}

-(void)editRelfNameRequest
{
//    http://i.duc.cn/setting/setUserInfo?userId=123123&realName=xxxx
}

-(void)editUserPhoto
{
    NSLog(@"strPath == %@",strPath);
    NSLog(@"strUserName == %@",strUserName);
    NSLog(@"strQQ == %@",strQQ);
    
    if (strPath == nil || strPath.length <= 0){
        
        [self showAlertWithTitle:@"提示" :@"请选择上传的图片" :@"OK" :nil];
        
    }
//    else if (strUserName == nil || strUserName.length <= 0){
//        
//        [self showAlertWithTitle:@"提示" :@"请输入用户名" :@"OK" :nil];
//        
//    }else if (strQQ == nil || strQQ.length <= 0){
//        
//        [self showAlertWithTitle:@"提示" :@"请输入您的QQ号" :@"OK" :nil];
//        
//    }
    else{

        ASIFormDataRequest *request = [[ASIFormDataRequest  alloc]initWithURL:[NSURL URLWithString:@"http://i.duc.cn/setting/setUserInfo?"]];
        request.delegate=self;

        [request addPostValue:strID forKey:@"userId"]; //用户名
        [request addFile:strPath forKey:@"file"]; // 路径
        
        [request startAsynchronous];
        
        
        
//
        
        
//        NSString *requestUrl = [NSString stringWithFormat:@"http://i.duc.cn/setting/setUserInfo?userId=%@",strID];
//        NSLog(@"uid == %@",requestUrl);
//        AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
//        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//        [manager POST:requestUrl parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//            NSError *error;
//            BOOL success = [formData appendPartWithFileURL:imageDataUrl name:@"realFormFile(FN_IMAGE_1)" error:&error];
//            if (!success){
//                NSLog(@"appendPartWithFileURL error: %@", error);
//            }else{
//                NSLog(@"==>error: %@", error);
//            }
//            
//            
//        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
//
//            
//            id myResult =[NSJSONSerialization JSONObjectWithData:responseObject  options:NSJSONReadingMutableContainers error:nil];
//            NSDictionary *dic=(NSDictionary*)myResult;
//            NSLog(@"%@",dic);
//            if ([[dic objectForKey:@"success"] boolValue] == 1) {
//                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"修改成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//                alert.tag = 3;
//                [alert show];
//            }else{
//                
//            }
//            
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            //
//            NSLog(@"error == %@", error);
//            [self showAlertWithTitle:@"提示" :@"请求失败" :@"确定" :nil];
//        }];
    }
    
    
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
    
    NSLog(@"-----%@",request.responseString);
    id myResult =[NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *dic=(NSDictionary*)myResult;
    NSLog(@"%@",dic);
    //    BOOL result=[[dic objectForKey:@"state"] boolValue];
    if ([[dic objectForKey:@"success"] boolValue] == 1) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"上传成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        alert.tag = 1;
        [alert show];
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:[dic objectForKey:@"errMsg"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        alert.tag = 2;
        [alert show];
        
    }
    
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1) {
        if (buttonIndex == 0) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else if (alertView.tag == 2) {
        if (buttonIndex == 0) {
        }
    }else if (alertView.tag == 3) {
        if (buttonIndex == 0) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else{
        
    }
}

- (void)editor
{
    
    UIActionSheet *chooseImageSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选取", nil];
    [chooseImageSheet showInView:self.view];
    
    
    
}

#pragma mark -照片功能
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0://拍照
        {
            [self takePhoto];
        }
            break;
        case 1://本地相册
        {
            [self LocalPhoto];
        }
            break;
        case 2:
        {
        }
            break;
        default:
            break;
    }
}




//从相册选择
-(void)LocalPhoto{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.allowsEditing = YES;
    //资源类型为图片库
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    picker.view.frame = CGRectMake(0, 0, kScreenWidth, 40);
    [self presentModalViewController:picker animated:YES];
}

//拍照
-(void)takePhoto{
    //资源类型为照相机
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    //判断是否有相机
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
        
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        //资源类型为照相机
        picker.sourceType = sourceType;
        [self presentModalViewController:picker animated:YES];
    }else {
        NSLog(@"该设备无摄像头");
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // 创建imdge 接收图片
    UIImage* image = [info valueForKey:UIImagePickerControllerOriginalImage];
    NSData *imageData = UIImageJPEGRepresentation(image, 0.1);
    image = [UIImage imageWithData:imageData];
    userPhotoImgView.image = image;
    UIImage *imageInfo = [info objectForKey:UIImagePickerControllerOriginalImage];
    UIImage* imageResult = [self imageWithImageSimple:image scaledToSize:CGSizeMake(imageInfo.size.width, 320)];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone systemTimeZone]];
    [formatter setDateFormat:@"yyyy-MM-dd-hh:mm:ss"];
    NSString *dateString = [formatter stringFromDate:[NSDate date]];
    NSString *imageName = [NSString stringWithFormat:@"%@.png",dateString];
    [self saveImage:imageResult WithName:imageName];
    
    
    // 关闭picker
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    [self editUserPhoto];
    
}
#pragma mark -保存图片的路径
- (void)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName
{
    NSLog(@"%@",imageName);
    NSData *imageData = UIImageJPEGRepresentation(tempImage, 0.1);
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    NSString* fullPathToFile = [documentsDirectory stringByAppendingPathComponent:imageName];
    NSURL *url = [NSURL fileURLWithPath:fullPathToFile];
    imageDataUrl = url;
    strPath = fullPathToFile;
    
    [imageData writeToFile:fullPathToFile atomically:NO];
    
    
}



- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    // End the context
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;
}





-(void)leftAction
{
    [self.navigationController popViewControllerAnimated:YES];
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
