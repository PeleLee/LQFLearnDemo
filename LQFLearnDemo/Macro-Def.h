//
//  Macro-Def.h
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/7/13.
//  Copyright © 2017年 LQF. All rights reserved.
//

#ifndef Macro_Def_h
#define Macro_Def_h

#define DEVICE_HEIGHT [UIScreen mainScreen].bounds.size.height
#define DEVICE_WIDTH [UIScreen mainScreen].bounds.size.width
#define WidthRadio  DEVICE_WIDTH/375
#define HeightRadio DEVICE_HEIGHT/667

#define PriceColor  [UIColor colorWithRed:46/255.0 green:107/255.0 blue:177/255.0 alpha:1.0]
#define RoseColor   [UIColor colorWithHexString:@"f05b72"]
#define DropColor  [UIColor colorWithHexString:@"7fb80e"]
#define ContentOffSet @"contentOffset"

#define ImageNamed(imageName)  [UIImage imageNamed:imageName]

#endif /* Macro_Def_h */
