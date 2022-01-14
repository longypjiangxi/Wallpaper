//
//  WallpaperTool.m
//  Wallpaper
//
//  Created by 曾 on 2021/12/16.
//

#import "WallpaperTool.h"

@implementation WallpaperTool
/** 获取高度 */
+(CGFloat)getHeightForLabel:(NSString*)str andFont:(UIFont*)font andWidth:(CGFloat)width
{
    UILabel* label=[[UILabel alloc]initWithFrame:CGRectMake(0,0,width,wid(10))];
    label.lineBreakMode=NSLineBreakByCharWrapping;
    label.text=str;
    label.font=font;
    label.numberOfLines=0;
    [label sizeToFit];
    CGFloat height=label.frame.size.height;
    label=nil;
    return height;

}
/** 获取宽度  */
+(CGFloat)getWidthForLabel:(NSString*)str andFont:(UIFont*)font andHeight:(CGFloat)height
{
    UILabel* label=[[UILabel alloc]initWithFrame:CGRectMake(0,0,wid(10),height)];
    label.lineBreakMode=NSLineBreakByCharWrapping;
    if([str isEqual:[NSNull null]])
    {
        label.text=@"0";
    }else
    {
        label.text=str;
    }
    label.font=font;
    label.numberOfLines=1;
    [label sizeToFit];
    CGFloat width=label.frame.size.width;
    label=nil;
    return width;
}
+(NSString *)getTimeFromTimestamp:(NSString*)tiemStr{

    //将对象类型的时间转换为NSDate类型

    double time =[tiemStr doubleValue];

    NSDate * myDate=[NSDate dateWithTimeIntervalSince1970:time];

    //设置时间格式

    NSDateFormatter * formatter=[[NSDateFormatter alloc]init];

    [formatter setDateFormat:@"HH:mm:ss"];

    //将时间转换为字符串

    NSString *timeStr=[formatter stringFromDate:myDate];

    return timeStr;

}
+(void)startTishil:(NSString*)str
{
    UILabel* tishiLabel=[[WallpaperTool keyWindw] viewWithTag:20200];
    if(tishiLabel)
    {
        [tishiLabel.layer removeAllAnimations];
        [tishiLabel removeFromSuperview];
        tishiLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,0,100,100)];
        tishiLabel.font=[UIFont systemFontOfSize:FontSize(14)];
        tishiLabel.textAlignment=NSTextAlignmentCenter;
        tishiLabel.layer.masksToBounds=YES;
        tishiLabel.layer.cornerRadius=wid(10);
        tishiLabel.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.8f];
        tishiLabel.textColor=[UIColor blackColor];
        tishiLabel.alpha=1;
        tishiLabel.tag=20200;
        [[WallpaperTool keyWindw] addSubview:tishiLabel];    //添加
        tishiLabel.text=str;
        [tishiLabel sizeToFit];
    }else
    {
        tishiLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,0,100,100)];
        tishiLabel.font=[UIFont systemFontOfSize:FontSize(14)];
        tishiLabel.textAlignment=NSTextAlignmentCenter;
        tishiLabel.layer.masksToBounds=YES;
        tishiLabel.layer.cornerRadius=wid(10);
        tishiLabel.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.8f];

        tishiLabel.textColor=[UIColor blackColor];
        tishiLabel.alpha=1;
        tishiLabel.tag=20200;
        [[WallpaperTool keyWindw] addSubview:tishiLabel];    //添加
        tishiLabel.text=str;
        [tishiLabel sizeToFit];
    }
    tishiLabel.frame=CGRectMake((SCREEN_WIDTH-(tishiLabel.frame.size.width+wid(20)*2))/2.0, (SCREEN_HEIGHT-(tishiLabel.frame.size.height+wid(20)*2))/2.0,tishiLabel.frame.size.width+wid(20)*2,tishiLabel.frame.size.height+wid(20)*2);
    tishiLabel.alpha=1;
    [UIView animateWithDuration:3 animations:^{
       tishiLabel.alpha=0;
    }completion:^(BOOL finished) {
    }];
}
+(UIWindow*)keyWindw
{
    UIWindow* foundWindow=nil;
    NSArray* windows=[[UIApplication sharedApplication]windows];
    for(UIWindow *window in windows)
    {
        if(window.isKeyWindow)
        {
            foundWindow=window;
            break;;
        }
    }
    return  foundWindow;
}
+(NSString *)removeSpaceAndNewline:(NSString *)str
{
    NSString *temp = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return temp;
}
+(NSString *)getNowTimeTimestamp{

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;

    [formatter setDateStyle:NSDateFormatterMediumStyle];

    [formatter setTimeStyle:NSDateFormatterShortStyle];

    [formatter setDateFormat:@"HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制

    //设置时区,这个对于时间的处理有时很重要

    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];

    [formatter setTimeZone:timeZone];

    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式

    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];

    return timeSp;

}

+(UIWindow *)frontWindow
{
#if !defined(SV_APP_EXTENSIONS)
    NSEnumerator *frontToBackWindows = [UIApplication.sharedApplication.windows reverseObjectEnumerator];
    for (UIWindow *window in frontToBackWindows) {
        BOOL windowOnMainScreen = window.screen == UIScreen.mainScreen;
        BOOL windowIsVisible = !window.hidden && window.alpha > 0;
        BOOL windowLevelSupported = (window.windowLevel >= UIWindowLevelNormal && window.windowLevel <= 0);
        BOOL windowKeyWindow = window.isKeyWindow;
        if(windowOnMainScreen && windowIsVisible && windowLevelSupported && windowKeyWindow) {
            return window;
        }
    }
#endif
    return nil;
}

+(UIImage *)OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    [image drawInRect:CGRectMake(0,0, size.width, size.height)];
    UIImage *scaleImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaleImage;
}

@end
