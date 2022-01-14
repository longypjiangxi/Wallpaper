//
//  ObjectAFNetWorking.h
//  BitAppFive
//
//  Created by 曾 on 2021/11/22.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"
NS_ASSUME_NONNULL_BEGIN

@interface ObjectAFNetWorking : NSObject
typedef void (^FinishBlock)(id dataString);
typedef void (^ErrorBlock)(NSError* error);

-(instancetype)init;

-(void)cancelRequest;   //取消请求

-(void)getUrlStr:(NSString*)urlStr finish:(FinishBlock)finish andError:(ErrorBlock)errors;

-(void)getPostUrlSte:(NSString*)urlStr andParameters:(NSMutableDictionary*)dic finish:(FinishBlock)finish andError:(ErrorBlock)errors;

-(void)getCookUrlStr:(NSString*)urlStr finish:(FinishBlock)finish andError:(ErrorBlock)errors;

@end

NS_ASSUME_NONNULL_END
