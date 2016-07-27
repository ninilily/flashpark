//
//  AppDelegate.m
//  FlashParking
//
//  Created by 薄号 on 16/6/13.
//  Copyright © 2016年 LettingTechnology. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "MainViewController.h"
#import "LTHTTPManager.h"
#import "LoginVC.h"


#define BAIDUAPPKEY @"lXjQ9U185K1sVf0Cxem4BngFMLv4sCvD"

@interface AppDelegate () {
    BMKMapManager* _mapManager;
    NSString *_token;
    
}


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //引导页首次启动
    //获取版本的key
    NSString *key=(NSString *)kCFBundleVersionKey;
    //获取当前的版本
    NSString *version=[NSBundle mainBundle].infoDictionary[key];
    //获取原来的版本
    NSString *oldVersion=[[NSUserDefaults standardUserDefaults]objectForKey:@"firstlaunch"];
    if([version isEqualToString:oldVersion])
    {
        [self starApp];
        
    }
    else
    {
        ViewController *view=[[ViewController alloc]init];
        view.callback=^{
            [self starApp];
            [[NSUserDefaults standardUserDefaults]setObject:version forKey:@"firstlaunch"];
            [[NSUserDefaults standardUserDefaults]synchronize];
        };
        self.window.rootViewController=view;
    }
    
    //初始化百度地图
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:BAIDUAPPKEY  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    [self connectWithToken];
    
    //融云
    [self rongCloudPush];
    
    application.applicationIconBadgeNumber = 0;
    return YES;
}
- (void)starApp
{
    MainViewController  *main=[[MainViewController alloc]init];
    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:main];
    self.window.rootViewController=nav;
    nav.navigationBarHidden=YES;

}
#pragma Mark --获取token 
- (void)connectWithToken
{
    [self internet];
    //获取token调试
    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"userUid"];
    NSString *userName =[[NSUserDefaults standardUserDefaults] objectForKey:@"nickName"];
    if (userName && userId) {
        [LTHTTPManager postRequestWithURL:[NSString stringWithFormat:@"%@%@",kHttpDemo,KHttpToken] withParameter:@{@"userId":[[NSUserDefaults standardUserDefaults] objectForKey:@"userUid"],@"userName":[[NSUserDefaults standardUserDefaults] objectForKey:@"nickName"]} getData:^(NSMutableDictionary *dictionary, NSError *error) {
            NSLog(@"%@",dictionary);
            if ([[dictionary valueForKeyPath:@"code"] isEqualToString:@"0"])
            {
                _token = [dictionary valueForKey:@"token"];
                //NSLog(@"%@",_token);
                //连接服务器
                [[RCIM sharedRCIM]connectWithToken:_token success:^(NSString *userId){
                    [[NSUserDefaults standardUserDefaults] setObject:userId forKey:@"user"];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                    
                    NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
                } error:^(RCConnectErrorCode status) {
                    NSLog(@"登陆的错误码为:%d", status);
                } tokenIncorrect:^{
                    NSLog(@"token错误");
                    
                }];
            }
        }];

    }
    else
    {
        LTWLTS(@"请先登录");
        
        
    }
    
    
}
#pragma mark -- 融云推送
- (void)rongCloudPush {
    //初始化融云
    [[RCIM sharedRCIM] initWithAppKey:@"bmdehs6pdpxfs"];
//    [[RCIM sharedRCIM] connectWithToken:@"wEuYgWt/an4CWqCXufRlOZuB8RYGYbwAR2jX7gAsGtXqHbcskJaR4Hp/YsJnerTw+S/ZGR+R2ST8xt3yjBddqGPEKycjNMZS" success:^(NSString *userId) {
//        
//        NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
//        
//    } error:^(RCConnectErrorCode status) {
//        NSLog(@"登陆的错误码为:%d", status);
//    } tokenIncorrect:^{
//        //token过期或者不正确。
//        //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
//        //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
//        NSLog(@"token错误");
//    }];
    
    
    /**
     * 推送处理1
     */
    if ([[UIApplication sharedApplication]
         respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        //注册推送, 用于iOS8以及iOS8之后的系统
        UIUserNotificationSettings *settings = [UIUserNotificationSettings
                                                settingsForTypes:(UIUserNotificationTypeBadge |
                                                                  UIUserNotificationTypeSound |
                                                                  UIUserNotificationTypeAlert)
                                                categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    } else {
        //注册推送，用于iOS8之前的系统
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge |
        UIRemoteNotificationTypeAlert |
        UIRemoteNotificationTypeSound;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
    }
}
/**
 * 推送处理2
 */
//注册用户通知设置
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    // register to receive notifications
    [application registerForRemoteNotifications];
}
/**
 * 推送处理3
 */
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *token =
    [[[[deviceToken description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    [[RCIMClient sharedRCIMClient] setDeviceToken:token];
}

#pragma mark -- 网络监控
- (void)internet {
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"NetworkState"];
        // 当网络状态发生改变的时候调用这个block
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWiFi: {
            NSLog(@"WIFI");
                
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWWAN: {
            NSLog(@"自带网络");
                break;
            }
            case AFNetworkReachabilityStatusNotReachable: {
           NSLog(@"没有网络");
                [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"NetworkState"];
                LTWLTS(@"请检查网络连接")
                break;
            }
            case AFNetworkReachabilityStatusUnknown: {
            NSLog(@"未知网络");
                break;
            }
            default:
                break;
        }
        
    }];
    // 开始监控
    [mgr startMonitoring];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    application.applicationIconBadgeNumber = 0;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
