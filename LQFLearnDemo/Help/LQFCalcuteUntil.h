//
//  LQFCalcuteUntil.h
//  SelfStudyDemo
//
//  Created by liqunfei on 2017/7/10.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, MACDParameter) {
    MACDParameterDIFF,
    MACDParameterMACD,
    MACDParameterDEA
};

void NSArrayToCArray(NSArray *array,double outCArray[]);

NSArray *CArrayToNSArray(const double inCArray[], int length, int outBegIdx, int outNBElement);

NSArray *CArrayToNSArrayWithParameter(const double inCarray[], int length, int outBegIdx, int outNBElement, double parmeter);

//KDJ
NSArray *KDJCArrayToNSArray(const double inCarray[], int length, int outBegIdx, int outNBElement);

//MACD类型
NSArray *MACDCArrayToNSArray(const double inCArray[], int length, int outBegIdx, int outNBElement, NSArray *items, MACDParameter parameter);

NSArray *MDCArrayToNSArray(const double inCArray[], int length, int outBegIdx, int outNBElement, NSArray *items);

void freeAndSetNULL(void *ptr);

CGFloat customComputeMA(NSArray *items, NSInteger days);
