//
//  LQFCalcuteTool.m
//  SelfStudyDemo
//
//  Created by liqunfei on 2017/7/10.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "LQFCalcuteTool.h"
#import "LQFCalcuteUntil.h"
#import "LQFCandleModel.h"
#import "LQFMacdModel.h"

LQFLineData *computeMAData(NSArray *items,int period) {
    NSMutableArray *arrCls = [[NSMutableArray alloc] init];
    for (NSUInteger index = 0; index < items.count; index++) {
        LQFCandleModel *item = [items objectAtIndex:items.count - 1 - index];
        [arrCls addObject:[NSString stringWithFormat:@"%f",item.close]];
    }
    
    double *inCls = malloc(sizeof(double) * items.count);
    NSArrayToCArray(arrCls, inCls);
    
    int outBegIdx = 0, outNBElement = 0;
    double *outReal = malloc(sizeof(double) * items.count);
    
    TA_RetCode ta_retCode = TA_MA(0,
                                  (int) (items.count - 1),
                                  inCls,
                                  period,
                                  TA_MAType_SMA,
                                  &outBegIdx,
                                  &outNBElement,
                                  outReal
                                  );
    
    NSMutableArray *maData = [[NSMutableArray alloc] init];
    
    if (TA_SUCCESS == ta_retCode) {
        NSArray *arr = MDCArrayToNSArray(outReal, (int) items.count, outBegIdx, outNBElement, items);
        
        for (NSInteger index = 0; index < arrCls.count; index++) {
            LQFCandleModel *item = [items objectAtIndex:items.count - 1 - index];
            [maData addObject:[[LQFLineUntil alloc] initWithValue:[[arr objectAtIndex:index] doubleValue] date:item.date]];
        }
    }
    LQFLineData *maline = [[LQFLineData alloc] init];
    if (5 == period) {
        maline.title = @"MA5";
        maline.color = [UIColor cyanColor];
    }
    
    else if (10 == period) {
        maline.title = @"MA10";
        maline.color = [UIColor magentaColor];
    }
    
    else if (25 == period) {
        maline.title = @"MA25";
        maline.color = [UIColor orangeColor];
    }
    
    maline.data = maData;
    return maline;
}

NSMutableArray *computeMACDData(NSArray * items) {
    NSMutableArray *arrCls = [[NSMutableArray alloc] init];
    for (NSUInteger index = 0; index < items.count; index++) {
        LQFCandleModel *item = [items objectAtIndex:items.count - 1 - index];
        [arrCls addObject:[NSString stringWithFormat:@"%f",item.close]];
    }
    double *inCls = malloc(sizeof(double) * items.count);
    NSArrayToCArray(arrCls, inCls);
    NSMutableArray *resultArray = [NSMutableArray array];
    int outBegIdx = 0, outNBElement = 0;
    double *outMACD = malloc(sizeof(double) * items.count);
    double *outMACDSignal = malloc(sizeof(double) * items.count);
    double *outMACDHist = malloc(sizeof(double) * items.count);
    
    TA_RetCode ta_retCode = TA_MACD(0,
                                    (int)(items.count - 1),
                                    inCls,
                                    12,
                                    26,
                                    9,
                                    &outBegIdx,
                                    &outNBElement,
                                    outMACD,
                                    outMACDSignal,
                                    outMACDHist);
    if (TA_SUCCESS == ta_retCode) {
        //  DEA
        NSArray *arrMACDSignal = MACDCArrayToNSArray(outMACDSignal, (int)items.count, outBegIdx, outNBElement, items, MACDParameterDEA);
        //  DIFF
        NSArray *arrMACD = MACDCArrayToNSArray(outMACD, (int)items.count, outBegIdx, outNBElement, items, MACDParameterDIFF);
        //  MACD
        NSArray *arrMACDHist = MACDCArrayToNSArray(outMACDHist, (int)items.count, outBegIdx, outNBElement, items, MACDParameterMACD);
        for (NSInteger index = 0; index < items.count; index++) {
            //  两倍表示MACD
            LQFCandleModel *item = [items objectAtIndex:items.count - 1 - index];
            if (index == 0 || index == 1) {
                LQFMacdModel *model = [[LQFMacdModel alloc] initWithDea:0.f diff:0.f macd:0.f date:item.date];
                [resultArray addObject:model];
            }
            else {
                LQFMacdModel *model = [[LQFMacdModel alloc] initWithDea:[(NSString *) [arrMACDSignal objectAtIndex:index] doubleValue] diff:[(NSString *)[arrMACD objectAtIndex:index] doubleValue] macd:[(NSString *)[arrMACDHist objectAtIndex:index] doubleValue] date:item.date];
                [resultArray addObject:model];
            }
        }
    }
    
    freeAndSetNULL(inCls);
    freeAndSetNULL(outMACD);
    freeAndSetNULL(outMACDSignal);
    freeAndSetNULL(outMACDHist);
    return resultArray;
}

NSMutableArray *computeKDJData(NSArray *items) {
    NSMutableArray *arrHigval = [[NSMutableArray alloc] init];
    for (NSUInteger index = 0; index < items.count; index++) {
        LQFCandleModel *item = [items objectAtIndex:items.count - 1 - index];
        [arrHigval addObject:[NSString stringWithFormat:@"%f",item.high]];
    }
    double *inHigval = malloc(sizeof(double) * items.count);
    NSArrayToCArray(arrHigval, inHigval);
    
    NSMutableArray *arrLowval = [[NSMutableArray alloc] init];
    for (NSUInteger index = 0; index < items.count; index++) {
        LQFCandleModel *item = [items objectAtIndex:items.count - 1 - index];
        [arrLowval addObject:[NSString stringWithFormat:@"%f",item.low]];
    }
    double *inLowval = malloc(sizeof(double) * items.count);
    NSArrayToCArray(arrLowval, inLowval);
    
    NSMutableArray *arrCls = [[NSMutableArray alloc] init];
    for (NSUInteger index = 0; index < items.count; index++) {
        LQFCandleModel *item = [items objectAtIndex:items.count - 1 - index];
        [arrCls addObject:[NSString stringWithFormat:@"%f",item.close]];
    }
    double *inCls = malloc(sizeof(double) * items.count);
    NSArrayToCArray(arrCls, inCls);
    
    int outBegIdx = 0, outNBElement = 0;
    double *outSlowK = malloc(sizeof(double) * items.count);
    double *outSlowD = malloc(sizeof(double) * items.count);
    
    TA_RetCode ta_retCode = TA_STOCH(0,
                                     (int)(items.count - 1),
                                     inHigval,
                                     inLowval,
                                     inCls,
                                     9,
                                     3,
                                     TA_MAType_EMA,
                                     3,
                                     TA_MAType_EMA,
                                     &outBegIdx,
                                     &outNBElement,
                                     outSlowK,
                                     outSlowD);
    
    NSMutableArray *slowKLineData = [[NSMutableArray alloc] init];
    NSMutableArray *slowDLineData = [[NSMutableArray alloc] init];
    NSMutableArray *slow3K2DLineData = [[NSMutableArray alloc] init];
    
    if (TA_SUCCESS == ta_retCode) {
        NSArray *arrSlowK = KDJCArrayToNSArray(outSlowK, (int)items.count, outBegIdx, outNBElement);
        NSArray *arrSlowD = KDJCArrayToNSArray(outSlowD, (int)items.count, outBegIdx, outNBElement);
        
        for (NSInteger index = 0; index < arrCls.count; index++) {
            LQFCandleModel *item = [items objectAtIndex:items.count - 1 - index];
            [slowKLineData addObject:[[LQFLineUntil alloc] initWithValue:[[arrSlowK objectAtIndex:index] floatValue] date:item.date]];
            
            [slowDLineData addObject:[[LQFLineUntil alloc] initWithValue:[[arrSlowD objectAtIndex:index] doubleValue] date:item.date]];
            
            double slowKLine3k2d = 3 * [[arrSlowK objectAtIndex:index] doubleValue] - 2 * [[arrSlowD objectAtIndex:index] doubleValue];
            [slow3K2DLineData addObject:[[LQFLineUntil alloc] initWithValue:slowKLine3k2d date:item.date]];
        }
    }
    
    freeAndSetNULL(inHigval);
    freeAndSetNULL(inLowval);
    freeAndSetNULL(inCls);
    freeAndSetNULL(outSlowK);
    freeAndSetNULL(outSlowD);
    
    LQFLineData *slowKLine = [[LQFLineData alloc] init];
    slowKLine.data = slowKLineData;
    slowKLine.color = [UIColor redColor];
    slowKLine.title = @"K";
    
    LQFLineData *slowDLine = [[LQFLineData alloc] init];
    slowDLine.data = slowDLineData;
    slowDLine.color = [UIColor greenColor];
    slowDLine.title = @"D";
    
    LQFLineData *slow3K2DLine = [[LQFLineData alloc] init];
    slow3K2DLine.data = slow3K2DLineData;
    slow3K2DLine.color = [UIColor blueColor];
    slow3K2DLine.title = @"J";
    
    NSMutableArray *kdjData = [[NSMutableArray alloc] init];
    [kdjData addObject:slowKLine];
    [kdjData addObject:slowDLine];
    [kdjData addObject:slow3K2DLine];
    return kdjData;
}

NSMutableArray *computeWRData(NSArray *items,int period) {
    NSMutableArray *arrHigval = [[NSMutableArray alloc] init];
    for (NSUInteger index = 0; index < items.count; index++) {
        LQFCandleModel *item = [items objectAtIndex:items.count - 1 - index];
        [arrHigval addObject:[NSString stringWithFormat:@"%f",item.high]];
    }
    double *inHigval = malloc(sizeof(double) * items.count);
    NSArrayToCArray(arrHigval, inHigval);
    
    NSMutableArray *arrLowval = [[NSMutableArray alloc] init];
    for (NSUInteger index = 0; index < items.count; index++) {
        LQFCandleModel *item = [items objectAtIndex:items.count - 1 - index];
        [arrLowval addObject:[NSString stringWithFormat:@"%f",item.low]];
    }
    double *inLowval = malloc(sizeof(double) * items.count);
    NSArrayToCArray(arrLowval, inLowval);
    
    NSMutableArray *arrCls = [[NSMutableArray alloc] init];
    for (NSUInteger index = 0; index < items.count; index++) {
        LQFCandleModel *item = [items objectAtIndex:items.count - 1 - index];
        [arrCls addObject:[NSString stringWithFormat:@"%f",item.close]];
    }
    double *inCls = malloc(sizeof(double) * items.count);
    NSArrayToCArray(arrCls, inCls);
    
    int outBegIdx = 0, outNBElement = 0;
    double *outReal = malloc(sizeof(double) * items.count);
    
    TA_RetCode ta_retCode = TA_WILLR(0,
                                     (int)(items.count - 1),
                                     inHigval,
                                     inLowval,
                                     inCls,
                                     period,
                                     &outBegIdx,
                                     &outNBElement,
                                     outReal
                                     );
    
    NSMutableArray *wrLineData = [[NSMutableArray alloc] init];
    
    if (TA_SUCCESS == ta_retCode) {
        NSArray *arrWR = CArrayToNSArrayWithParameter(outReal, (int) items.count, outBegIdx, outNBElement, -101);
        
        for (NSInteger index = 0; index < arrCls.count; index++) {
            LQFCandleModel *item = [items objectAtIndex:items.count - 1 - index];
            [wrLineData addObject:[[LQFLineUntil alloc] initWithValue:-([[arrWR objectAtIndex:index] doubleValue]) date:item.date]];
        }
    }
    
    freeAndSetNULL(inHigval);
    freeAndSetNULL(inLowval);
    freeAndSetNULL(inCls);
    freeAndSetNULL(outReal);
    
    LQFLineData *wrLine = [[LQFLineData alloc] init];
    wrLine.data = wrLineData;
    wrLine.color = [UIColor redColor];
    wrLine.title = @"WR";
    
    NSMutableArray *wrData = [[NSMutableArray alloc] init];
    [wrData addObject:wrLine];
    return wrData;
}
