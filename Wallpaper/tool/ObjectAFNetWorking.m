//
//  ObjectAFNetWorking.m
//  PetMaster
//
//  Created by Xzuysq Ejiyjf on 2019-11-26.
//

#import "ObjectAFNetWorking.h"

@interface ObjectAFNetWorking()
{
    AFHTTPSessionManager* manager;
}
@end

@implementation ObjectAFNetWorking
-(instancetype)init
{
    self=[super init];
    if(self)
    {
        manager=[AFHTTPSessionManager manager];
        manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    }
    return self;
}
-(void)cancelRequest   //取消请求
{
    if([manager.tasks count]>0)
    {
        [manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    }
}
-(void)getUrlStr:(NSString*)urlStr finish:(FinishBlock)finish andError:(ErrorBlock)errors
{
    [manager GET:urlStr parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        finish(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errors(error);
    }];
}
-(void)getCookUrlStr:(NSString*)urlStr finish:(FinishBlock)finish andError:(ErrorBlock)errors
{
    NSDictionary *proxySettings = (__bridge NSDictionary *)(CFNetworkCopySystemProxySettings());
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    NSArray *proxies = (__bridge NSArray *)(CFNetworkCopyProxiesForURL((__bridge CFURLRef)(url),
                                                                       (__bridge CFDictionaryRef)(proxySettings)));
    if ([[proxies[0] objectForKey:(NSString *)kCFProxyTypeKey] isEqualToString:@"kCFProxyTypeNone"])
    {
    
        [manager GET:urlStr parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            finish(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            errors(error);
        }];
    }
}
-(void)getPostUrlSte:(NSString*)urlStr andParameters:(NSMutableDictionary*)dic finish:(FinishBlock)finish andError:(ErrorBlock)errors
{
      NSDictionary *proxySettings = (__bridge NSDictionary *)(CFNetworkCopySystemProxySettings());
      NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
      NSArray *proxies = (__bridge NSArray *)(CFNetworkCopyProxiesForURL((__bridge CFURLRef)(url),
                                                                         (__bridge CFDictionaryRef)(proxySettings)));
      if ([[proxies[0] objectForKey:(NSString *)kCFProxyTypeKey] isEqualToString:@"kCFProxyTypeNone"])
      {
          [manager POST:urlStr parameters:dic headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              finish(responseObject);
          } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              errors(error);
          }];
      }
}
@end
