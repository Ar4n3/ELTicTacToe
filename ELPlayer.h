//
//  ELPlayer.h
//  ELTicTacToe
//
//  Created by Enara Lopez Otaegi on 20/03/14.
//  Copyright (c) 2014 Enara Lopez Otaegi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ELPlayer : NSObject

@property (nonatomic, strong) UIImage *myTurn;
@property (nonatomic) NSMutableArray *myButtons;

@end
