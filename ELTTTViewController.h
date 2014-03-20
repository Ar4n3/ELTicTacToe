//
//  ELTTTViewController.h
//  ELTicTacToe
//
//  Created by Enara Lopez Otaegi on 19/03/14.
//  Copyright (c) 2014 Enara Lopez Otaegi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ELPlayer.h"

@interface ELTTTViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *myLabel11;
@property (weak, nonatomic) IBOutlet UIButton *myLabel12;
@property (weak, nonatomic) IBOutlet UIButton *myLabel13;
@property (weak, nonatomic) IBOutlet UIButton *myLabel21;
@property (weak, nonatomic) IBOutlet UIButton *myLabel22;
@property (weak, nonatomic) IBOutlet UIButton *myLabel23;
@property (weak, nonatomic) IBOutlet UIButton *myLabel31;
@property (weak, nonatomic) IBOutlet UIButton *myLabel32;
@property (weak, nonatomic) IBOutlet UIButton *myLabel33;

@property (weak, nonatomic) IBOutlet UIButton *myToe;
@property (weak, nonatomic) IBOutlet UIButton *myCross;

@property (nonatomic, strong) ELPlayer *player1;
@property (nonatomic, strong) ELPlayer *pcPlayer;

@property (nonatomic, strong) NSArray *myButtons;

- (void)manageButtons;
- (void)userIsCrossOrToe: (UIButton *)chip;
- (void)drawMyTurn: (UIButton *)selectedButton;
- (BOOL)checkWin: (UIButton *)selectedButton withTurn:(UIImage *)turn;
- (void)restoreTableForPlay;
- (BOOL)willDrawPcTurn:(int)iCount toCompare:(int)jCount withTurn:(UIImage *)turn andSelectedButton:(UIButton *)selectedButton;
- (void)drawPCTurn;


@end
