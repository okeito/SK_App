//
//  DealCell.h
//  St Kilda App
//
//  Created by Okeito on 4/19/14.
//  Copyright (c) 2014 Okeito. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DealCell : UICollectionViewCell



@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) UIImage *photo;

@property (nonatomic, weak) IBOutlet UILabel *title;
@property (nonatomic, weak) IBOutlet UILabel *price;

@end
