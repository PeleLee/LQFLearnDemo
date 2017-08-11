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
#define DropColor   [UIColor colorWithHexString:@"7fb80e"]
#define MainColor   RGBA(248,248,248,1)
#define ClearColor  [UIColor clearColor]

#define ContentOffSet @"contentOffset"
#define RandomColor                    [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]
#define RGBA(r,g,b,a)                  [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define ImageNamed(imageName)  [UIImage imageNamed:imageName]

#endif /* Macro_Def_h */
