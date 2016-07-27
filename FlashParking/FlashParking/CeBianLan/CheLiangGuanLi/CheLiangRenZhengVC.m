//
//  CheLiangRenZhengVC.m
//  FlashParking
//
//  Created by 薄号 on 16/6/22.
//  Copyright © 2016年 LettingTechnology. All rights reserved.
//

#import "CheLiangRenZhengVC.h"

@interface CheLiangRenZhengVC ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate> {
    UIButton *_upLoadImage;
}

@end

static NSString *originUploadImage = nil;

@implementation CheLiangRenZhengVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setAttributeLeftItem:@"back.png" withMiddleItem:@"车辆认证" withRightItem:nil];
    
    [self pageLayout];
}

#pragma mark -- 导航按钮点击事件
- (void)leftButtonEvent:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rightButtonEvent:(UIButton *)sender {
    
}

#pragma mark -- 页面布局
- (void)pageLayout {
    //请上传Label
    UILabel *uploadZheng = [[UILabel alloc] init];
    uploadZheng.center = CGPointMake(ScreenW / 2, 84 * HEIGHTSCALE + 10);
    uploadZheng.bounds = CGRectMake(0, 0, 200, 20);
    uploadZheng.text = @"请上传车辆相关的行驶证";
    uploadZheng.textColor = LTColor(225, 88, 60);
    uploadZheng.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:uploadZheng];
    //车牌号
    NSString *carNum = [self.carDictionary valueForKeyPath:@"carPlate"];
    UILabel *carNumber = [[UILabel alloc] init];
    carNumber.center = CGPointMake(ScreenW / 2, 104 * HEIGHTSCALE + 20);
    carNumber.bounds = CGRectMake(0, 0, 200, 20);
    carNumber.text = [NSString stringWithFormat:@"车牌号:%@",carNum];
    carNumber.textAlignment = NSTextAlignmentCenter;
    carNumber.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:carNumber];
    //上分隔线
    UILabel *topLine = [[UILabel alloc] init];
    topLine.frame = CGRectMake(20, 110 * HEIGHTSCALE + 40, ScreenW - 40, 1);
    topLine.backgroundColor = LTColor(210, 211, 212);
    [self.view addSubview:topLine];
    //点击上传按钮
    UIButton *uploadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    uploadBtn.center = CGPointMake(ScreenW / 2, 130 * HEIGHTSCALE + 90);
    uploadBtn.bounds = CGRectMake(0, 0, 100, 100);
    [uploadBtn setBackgroundImage:[UIImage imageNamed:@"sc"] forState:UIControlStateNormal];
    [uploadBtn addTarget:self action:@selector(uploadBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:uploadBtn];
    _upLoadImage = uploadBtn;
    originUploadImage = [UIImageJPEGRepresentation([UIImage imageNamed:@"sc"], 0.1) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    //行驶证
    UILabel *xingShiZheng = [[UILabel alloc] init];
    xingShiZheng.center = CGPointMake(ScreenW / 2, 154 * HEIGHTSCALE + 140);
    xingShiZheng.bounds = CGRectMake(0, 0, 100, 20);
    xingShiZheng.text = @"行 驶 证";
    xingShiZheng.textAlignment = NSTextAlignmentCenter;
    xingShiZheng.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:xingShiZheng];
    //下分隔线
    UILabel *bottomLine = [[UILabel alloc] init];
    bottomLine.frame = CGRectMake(20, 170 * HEIGHTSCALE + 150, ScreenW - 40, 1);
    bottomLine.backgroundColor = LTColor(210, 211, 212);
    [self.view addSubview:bottomLine];
    //提示信息
    NSArray *promptArr = @[@"1.车辆信息和相关证件只供审核使用，不会公开。",@"2.审核中不能修改信息。",@"3.审核一般一个工作日。",@"4.如有问题请致电客服：12345678901"];
    for (NSInteger i = 0; i < 4; i++) {
        UILabel *prompt = [[UILabel alloc] init];
        prompt.frame = CGRectMake(20, 175 * HEIGHTSCALE + 150 + 18 * i, ScreenW - 40, 15);
        prompt.text = promptArr[i];
        prompt.textColor =[self colorWithHexColorString:@"#3293fa"];
        prompt.font = [UIFont systemFontOfSize:12];
        [self.view addSubview:prompt];
    }
    //认证提交按钮
    UIButton *tiJiaoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    tiJiaoBtn.center = CGPointMake(ScreenW / 2, 210 * HEIGHTSCALE + 222);
    tiJiaoBtn.bounds = CGRectMake(0, 0, ScreenW - 40, 40);
    [tiJiaoBtn  setBackgroundColor:[self colorWithHexColorString:@"#3293fa"]];
    
    [tiJiaoBtn setTitle:@"认证提交" forState:UIControlStateNormal];
    
//    [tiJiaoBtn setBackgroundImage:[UIImage imageNamed:@"rztijiao_w"] forState:UIControlStateNormal];
//    [tiJiaoBtn setBackgroundImage:[UIImage imageNamed:@"rztijiao_y"] forState:UIControlStateHighlighted];
    [tiJiaoBtn addTarget:self action:@selector(tiJiaoBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tiJiaoBtn];
}

#pragma mark -- 上传按钮点击事件
- (void)uploadBtnEvent:(UIButton *)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *photo = [UIAlertAction actionWithTitle:@"从相册中选择照片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.delegate = self;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }];
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"使用手机相机拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.delegate = self;
        imagePicker.mediaTypes = @[(NSString *)kUTTypeImage];
        imagePicker.showsCameraControls = YES;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:photo];
    [alertController addAction:camera];
    [alertController addAction:cancel];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark -- ImagePicker代理方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [_upLoadImage setBackgroundImage:[info valueForKeyPath:UIImagePickerControllerOriginalImage] forState:UIControlStateNormal];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -- 认证提交按钮点击事件
- (void)tiJiaoBtnEvent:(UIButton *)sender {
    static NSString *uploadImageString = nil;
    if (UIImageJPEGRepresentation(_upLoadImage.currentBackgroundImage, 0.1)) {
        uploadImageString = [UIImageJPEGRepresentation(_upLoadImage.currentBackgroundImage, 0.1) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    }else {
        uploadImageString = [UIImagePNGRepresentation(_upLoadImage.currentBackgroundImage) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    }
    
    if ([uploadImageString isEqualToString:originUploadImage]) {
        LTWXTS(@"请选择上传图片");
        return;
    }
    [LTHTTPManager postRequestWithURL:[NSString stringWithFormat:@"%@%@",kHttpDemo,KHttpVerify] withParameter:@{@"carId":[self.carDictionary valueForKeyPath:@"carId"],@"licensePic":uploadImageString} getData:^(NSMutableDictionary *dictionary, NSError *error) {
        NSLog(@"carID:%@",[self.carDictionary valueForKeyPath:@"carId"]);
        NSLog(@"%@",dictionary);
        if ([[dictionary valueForKeyPath:@"code"] isEqualToString:@"0"]) {
            LTWXTS([dictionary valueForKeyPath:@"message"]);
        }else {
            LTWXTS([dictionary valueForKeyPath:@"message"]);
        }
    }];
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
