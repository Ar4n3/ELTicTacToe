//
//  ELTTTViewController.m
//  ELTicTacToe
//
//  Created by Enara Lopez Otaegi on 19/03/14.
//  Copyright (c) 2014 Enara Lopez Otaegi. All rights reserved.
//

#import "ELTTTViewController.h"

@interface ELTTTViewController ()

@end

@implementation ELTTTViewController

int buttonsLeft = 9;


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.myCross addTarget:self action:@selector(userIsCrossOrToe:) forControlEvents:UIControlEventTouchUpInside];
    [self.myToe addTarget:self action:@selector(userIsCrossOrToe:) forControlEvents:UIControlEventTouchUpInside];
    
    [self manageButtons];
    
}


#pragma mark - Game Logic

- (void)drawPCTurn {
    int found = 0;
    if (self.pcPlayer.myButtons.count >= 2) {
        for (UIButton *checkinButton in _myButtons) {
            if ([self checkWin:checkinButton withTurn:self.pcPlayer.myTurn]) {
                found = 1;
                break;
            }
        }
    }
    if (self.player1.myButtons.count >= 2) {
        for (UIButton *checkinButton in _myButtons) {
            if (checkinButton.isEnabled) {
                if ([self checkWin:checkinButton withTurn:self.player1.myTurn]) {
                    [checkinButton setBackgroundImage:self.pcPlayer.myTurn forState:UIControlStateNormal];
                    [checkinButton setEnabled:NO];
                    [self.pcPlayer.myButtons addObject:checkinButton];
                    buttonsLeft -= 1;
                    found = 1;
                    break;
                }
            }            
        }
    }    
    if (found == 0) {
        for (UIButton *positionButton in _myButtons) {
            if ([positionButton isEnabled]) {
                [positionButton setBackgroundImage:self.pcPlayer.myTurn forState:UIControlStateNormal];
                [positionButton setEnabled:NO];
                [self.pcPlayer.myButtons addObject:positionButton];
                buttonsLeft -= 1;
                break;
            }
        }
    }
}

- (void)drawMyTurn: (UIButton *)selectedButton {
    if (selectedButton.isEnabled && self.player1.myTurn != nil) {
        [selectedButton setBackgroundImage:self.player1.myTurn forState:UIControlStateNormal];
        [selectedButton setEnabled:NO];
        [self.player1.myButtons addObject:selectedButton];
        if ([self checkWin:selectedButton withTurn:self.player1.myTurn]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Congrats" message:@"You won!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [self restoreTableForPlay];
        } else {
        buttonsLeft -= 1;
            if (buttonsLeft > 0) {
                [self drawPCTurn];
            } else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Well" message:@"Nobody won this time." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                [self restoreTableForPlay];
            }
        }
    }
    
}



- (BOOL)willDrawPcTurn:(int)iCount toCompare:(int)jCount withTurn:(UIImage *)turn andSelectedButton:(UIButton *)selectedButton {
    if (turn == self.player1.myTurn) {
        for (UIButton *presentButton in self.player1.myButtons) {
            if (presentButton.tag == iCount || presentButton.tag == jCount) {
                int search;
                if (presentButton.tag == iCount) {
                    search = jCount;
                } else {
                    search = iCount;
                }
                for (UIButton *secondButton in self.player1.myButtons) {
                    if (secondButton.tag == search) {
                        return YES;
                    }
                }
            }
        }
    } else {
        if (selectedButton.isEnabled) {
            for (UIButton *presentButton in self.pcPlayer.myButtons) {
                if (presentButton.tag == iCount || presentButton.tag == jCount) {
                    int search;
                    if (presentButton.tag == iCount) {
                        search = jCount;
                    } else {
                        search = iCount;
                    }
                    for (UIButton *secondButton in self.pcPlayer.myButtons) {
                        if (secondButton.tag == search) {
                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"You lost." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                            [alert show];
                            [self restoreTableForPlay];
                            return YES;
                        }
                    }
                }
            }
        }        
        return NO;
    }
    
    return NO;
}

- (BOOL)checkWin:(UIButton *)selectedButton withTurn:(UIImage *)turn {
    if (turn != nil) {
        switch (selectedButton.tag) {
            case 0:
                if ([self willDrawPcTurn:1 toCompare:2 withTurn:turn andSelectedButton:selectedButton]) {
                    return YES;
                    break;
                } else if ([self willDrawPcTurn:3 toCompare:6 withTurn:turn andSelectedButton:selectedButton]) {
                    return YES;
                    break;
                } else if ([self willDrawPcTurn:4 toCompare:8 withTurn:turn andSelectedButton:selectedButton]) {
                    return YES;
                    break;
                }
                
                break;
            
            case 1:
                if ([self willDrawPcTurn:0 toCompare:2 withTurn:turn andSelectedButton:selectedButton]) {
                    return YES;
                    break;
                } else if ([self willDrawPcTurn:4 toCompare:7 withTurn:turn andSelectedButton:selectedButton]) {
                    return YES;
                    break;
                }
                
                break;
            
            case 2:
                if ([self willDrawPcTurn:0 toCompare:1 withTurn:turn andSelectedButton:selectedButton]) {
                    return YES;
                    break;
                } else if ([self willDrawPcTurn:4 toCompare:6 withTurn:turn andSelectedButton:selectedButton]) {
                    return YES;
                    break;
                } else if ([self willDrawPcTurn:5 toCompare:8 withTurn:turn andSelectedButton:selectedButton]) {
                    return YES;
                    break;
                }
                
                break;
            
            case 3:
                if ([self willDrawPcTurn:0 toCompare:6 withTurn:turn andSelectedButton:selectedButton]) {
                    return YES;
                    break;
                } else if ([self willDrawPcTurn:4 toCompare:5 withTurn:turn andSelectedButton:selectedButton]) {
                    return YES;
                    break;
                }
                
                break;
                
            case 4:
                if ([self willDrawPcTurn:1 toCompare:7 withTurn:turn andSelectedButton:selectedButton]) {
                    return YES;
                    break;
                } else if ([self willDrawPcTurn:2 toCompare:6 withTurn:turn andSelectedButton:selectedButton]) {
                    return YES;
                    break;
                } else if ([self willDrawPcTurn:3 toCompare:5 withTurn:turn andSelectedButton:selectedButton]) {
                    return YES;
                    break;
                } else if ([self willDrawPcTurn:0 toCompare:8 withTurn:turn andSelectedButton:selectedButton]) {
                    return YES;
                    break;
                }
                
                break;
            
            case 5:
                if ([self willDrawPcTurn:2 toCompare:8 withTurn:turn andSelectedButton:selectedButton]) {
                    return YES;
                    break;
                } else if ([self willDrawPcTurn:3 toCompare:4 withTurn:turn andSelectedButton:selectedButton]) {
                    return YES;
                    break;
                }
                
                break;
            
            case 6:
                if ([self willDrawPcTurn:0 toCompare:3 withTurn:turn andSelectedButton:selectedButton]) {
                    return YES;
                    break;
                } else if ([self willDrawPcTurn:2 toCompare:4 withTurn:turn andSelectedButton:selectedButton]) {
                    return YES;
                    break;
                } else if ([self willDrawPcTurn:7 toCompare:8 withTurn:turn andSelectedButton:selectedButton]) {
                    return YES;
                    break;
                }
                
                break;
                
            case 7:
                if ([self willDrawPcTurn:6 toCompare:8 withTurn:turn andSelectedButton:selectedButton]) {
                    return YES;
                    break;
                } else if ([self willDrawPcTurn:1 toCompare:4 withTurn:turn andSelectedButton:selectedButton]) {
                    return YES;
                    break;
                }
                
                break;
                
            case 8:
                if ([self willDrawPcTurn:2 toCompare:5 withTurn:turn andSelectedButton:selectedButton]) {
                    return YES;
                    break;
                } else if ([self willDrawPcTurn:0 toCompare:4 withTurn:turn andSelectedButton:selectedButton]) {
                    return YES;
                    break;
                } else if ([self willDrawPcTurn:6 toCompare:7 withTurn:turn andSelectedButton:selectedButton]) {
                    return YES;
                    break;
                }
                
                break;
                
            default:
                break;
        }
        
    }
    return NO;
}


#pragma mark - restoration

- (void)restoreTableForPlay {
    buttonsLeft = 9;
    for (UIButton *presentButton in _myButtons) {
        [presentButton setBackgroundImage:nil forState:UIControlStateNormal];
        [presentButton setEnabled:YES];
    }
    [self.myCross setEnabled:YES];
    [self.myToe setEnabled:YES];
    
    self.player1 = [[ELPlayer alloc] init];
    self.pcPlayer = [[ELPlayer alloc] init];
    
    self.player1.myButtons = [[NSMutableArray alloc] initWithCapacity:8];
    self.pcPlayer.myButtons = [[NSMutableArray alloc] initWithCapacity:8];
}


#pragma mark - initialize game

- (void) userIsCrossOrToe: (UIButton *)chip {
    NSLog(@"%@", chip.imageView.image);
    self.player1.myTurn = chip.imageView.image;
    if (chip.tag == -1) {
        self.pcPlayer.myTurn = self.myCross.imageView.image;
    } else {
        self.pcPlayer.myTurn = self.myToe.imageView.image;
    }
    [self.myCross setEnabled:NO];
    [self.myToe setEnabled:NO];
}

- (void)manageButtons {
    
    _myButtons = @[self.myLabel11, self.myLabel12, self.myLabel13, self.myLabel21, self.myLabel22, self.myLabel23, self.myLabel31, self.myLabel32, self.myLabel33];
    for (UIButton *presentButton in _myButtons) {
        [presentButton addTarget:self action:@selector(drawMyTurn:) forControlEvents:UIControlEventTouchUpInside];
    }
    self.player1 = [[ELPlayer alloc] init];
    self.pcPlayer = [[ELPlayer alloc] init];
    
    self.player1.myButtons = [[NSMutableArray alloc] initWithCapacity:8];
    self.pcPlayer.myButtons = [[NSMutableArray alloc] initWithCapacity:8];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
