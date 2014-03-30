//
//  ArticleCell.h
//  St Kilda App
//
//  Created by Okeito on 3/30/14.
//  Copyright (c) 2014 Okeito. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArticleCell : UICollectionViewCell

@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) UIImage *photo;

@property (nonatomic, weak) IBOutlet UILabel *title;

@end
