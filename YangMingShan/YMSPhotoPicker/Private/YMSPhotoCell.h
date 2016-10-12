//
//  YMSPhotoCell.h
//  YangMingShan
//
//  Copyright 2016 Yahoo Inc.
//  Licensed under the terms of the BSD license. Please see LICENSE file in the project root for terms.
//
//  Part of this code was derived from code authored by David Robles

#import <Photos/Photos.h>
#import <UIKit/UIKit.h>

/**
 * This is the customized UICollectionViewCell for photo picker to display single photo.
 */
@interface YMSPhotoCell : UICollectionViewCell

/**
 * @brief It is the identifier for photo picker to display single photo in current album.
 *
 */
@property (nonatomic, strong) NSString *representedAssetIdentifier;

/**
 * @brief It is the identifier for photo picker to display single photo in current album.
 *
 */
@property (nonatomic, assign) PHAssetMediaType mediaType;

/**
 * @brief Set target method to this to recognize long press gesture.
 *
 */
@property (nonatomic, strong) UILongPressGestureRecognizer *longPressGestureRecognizer;

/**
 * @brief Load the photo from photo library and display it on cell.
 *
 * @param manager Reuse current image manager from photo picker.
 * @param asset The photo image asset.
 * @param size The target photo size.
 */
- (void)loadPhotoWithManager:(PHImageManager *)manager forAsset:(PHAsset *)asset targetSize:(CGSize)size;

@end
