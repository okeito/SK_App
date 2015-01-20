//
//  NewsViewController.h
//  St Kilda App
//
//  Created by Okeito on 3/26/14.
//  Copyright (c) 2014 Okeito. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GAITrackedViewController.h"

extern NSString * const WEB_LINK;

@interface NewsViewController : GAITrackedViewController
{    
   // IBOutlet UITableView *feedTable;
   // IBOutlet UIProgressView *threadProgressView;
    
    IBOutlet UICollectionView *collectionView;
    UIProgressView *progressView;
    NSMutableData *receivedData;
   // UILabel *progressLabel;
    int totalfilesize;
    int filesizereceived;
    float filepercentage;
}


@end



