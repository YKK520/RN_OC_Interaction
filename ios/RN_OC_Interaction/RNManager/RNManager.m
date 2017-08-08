//
//  RNManager.m
//  RN_OC_Interaction
//
//  Created by RN on 2017/8/8.
//  Copyright © 2017年 Facebook. All rights reserved.
//

#import "RNManager.h"

@implementation RNManager
/***
  1.协议
  2.字符串
  3.字符串+字典
  4.字符串+日期
  5.RN调原生+回调
  6. Promises
  7.定义的数据（RN调
  8.清理缓存
  9.计算缓存
 */




#pragma -1.协议
/*
 实现该协议,需要含有一个宏
 */
RCT_EXPORT_MODULE();


#pragma - 2.字符串

/*
 接收传过来的 NSString
 RN:CalendarManager.addEventOne('str');
 */
RCT_EXPORT_METHOD(passStr:(NSString *)str)
{
  NSLog(@"传递字符串: %@", str);
}


#pragma - 3.字符串+字典

/*
 接收传过来的 str + dic
 RN: CalendarManager.addEventTwo('str',dic);
 */
RCT_EXPORT_METHOD(passDic:(NSString *)str dic:(NSDictionary *)dic)
{
  RCTLogInfo(@"接受str和dic: str= %@   dic = %@", str, dic);
}

#pragma - 4.字符串+日期

/*
 接收传过来的 NSString + date日期
 RN CalendarManager.addEventThree('str',20171020);
 */
RCT_EXPORT_METHOD(passStrAndDate:(NSString *)str date:(NSDate *)date)
{
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
  [formatter setDateFormat:@"yyyy-MM-dd"];
  RCTLogInfo(@"接收str+date: str = %@  date = %@", str, [formatter stringFromDate:date]);
}
#pragma - 5.RN调原生+回调
/*
 对外提供调用方法,演示Callback
 
 */
RCT_EXPORT_METHOD(passStrCallBack:(NSString *)str callback:(RCTResponseSenderBlock)callback)
{
  NSLog(@"%@",str);
  NSArray *events=@[@"A", @"B", @"C"]; //准回调数据
  callback(@[[NSNull null],events]);
}
#pragma - 6. Promises
/*
 对外提供调用方法,演示Promise使用
 */
RCT_REMAP_METHOD(promiseNativeCallBack,
                 success:(RCTPromiseResolveBlock)success
                 failure:(RCTPromiseRejectBlock)failure)
{
  NSArray *events =@[@"A", @"B", @"C"]; //准回调数据
  if (events) {
    success(events);
  } else {
    NSError *error=[NSError errorWithDomain:@"Promise回调错误信息..."
                                       code:101
                                   userInfo:nil];
    failure(@"no_events", @"There were no events", error);
  }
}
#pragma - 7.定义的数据（RN调）
- (NSDictionary *)constantsToExport
{
  return @{ @"value": @"RN调原生数据" };
}

#pragma -  8.清理缓存
/*清理缓存
 
 感觉没必要返回  还是OC计算，清理。 清了就清理了，只要error不存在，就是0  粘贴oc代码 http://www.jianshu.com/p/a7e25a508185
 */
RCT_EXPORT_METHOD(cleanCache:(RCTResponseSenderBlock)callback)
{
  NSURLCache *httpCache = [NSURLCache sharedURLCache];
  [httpCache removeAllCachedResponses];

  NSUInteger cache = [httpCache currentDiskUsage];
  callback(@[[NSNull null],@(cache)]);
}
#pragma -   9.计算缓存


RCT_EXPORT_METHOD(calculateCacheSize:(RCTResponseSenderBlock)callback)
{
  NSURLCache *httpCache = [NSURLCache sharedURLCache];
  NSUInteger cache = [httpCache currentDiskUsage];
  //其他 等等 粘贴代码 http://www.jianshu.com/p/a7e25a508185
  
  
  
  callback(@[[NSNull null],@(cache)]);
}
@end
