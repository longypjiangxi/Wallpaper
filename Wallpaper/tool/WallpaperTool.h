//
//  WallpaperTool.h
//  Wallpaper
//
//  Created by 曾 on 2021/12/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WallpaperTool : NSObject
+(CGFloat)getHeightForLabel:(NSString*)str andFont:(UIFont*)font andWidth:(CGFloat)width;
/** 获取宽度  */
+(CGFloat)getWidthForLabel:(NSString*)str andFont:(UIFont*)font andHeight:(CGFloat)height;
+(NSString *)getTimeFromTimestamp:(NSString*)tiemStr;
+(NSString *)removeSpaceAndNewline:(NSString *)str;
+(NSString *)getNowTimeTimestamp;
+(UIWindow *)frontWindow;
+(void)startTishil:(NSString*)str;
+(UIImage *)OriginImage:(UIImage *)image scaleToSize:(CGSize)size;
@end

NS_ASSUME_NONNULL_END
