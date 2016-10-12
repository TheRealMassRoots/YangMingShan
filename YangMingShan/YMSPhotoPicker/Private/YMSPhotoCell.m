//
//  YMSPhotoCell.m
//  YangMingShan
//
//  Copyright 2016 Yahoo Inc.
//  Licensed under the terms of the BSD license. Please see LICENSE file in the project root for terms.
//
//  Part of this code was derived from code authored by David Robles
//  This code includes sample code from the following StackOverflow posting: http://stackoverflow.com/questions/10497397/from-catransform3d-to-cgaffinetransform

#import "YMSPhotoCell.h"

#import "YMSPhotoPickerTheme.h"

@interface YMSPhotoCell()

@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) PHImageManager *imageManager;
@property (nonatomic, assign) PHImageRequestID imageRequestID;
@property (nonatomic, assign) BOOL animateSelection;
@property (nonatomic, assign, getter=isAnimatingHighlight) BOOL animateHighlight;
@property (nonatomic, strong) UIImage *thumbnailImage;

- (void)cancelImageRequest;

@end

@implementation YMSPhotoCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] init];
    [self addGestureRecognizer:self.longPressGestureRecognizer];

    [self prepareForReuse];
}

- (void)prepareForReuse {
    [super prepareForReuse];

    [self cancelImageRequest];

    self.imageView.image = nil;
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
}

- (void)dealloc {
    [self cancelImageRequest];
}

#pragma mark - Publics

- (void)loadPhotoWithManager:(PHImageManager *)manager forAsset:(PHAsset *)asset targetSize:(CGSize)size {
    self.imageManager = manager;
    self.imageRequestID = [self.imageManager requestImageForAsset:asset
                                                       targetSize:size
                                                      contentMode:PHImageContentModeAspectFill
                                                          options:nil
                                                    resultHandler:^(UIImage *result, NSDictionary *info) {
                                                        // Set the cell's thumbnail image if it's still showing the same asset.
                                                        if ([self.representedAssetIdentifier isEqualToString:asset.localIdentifier]) {
                                                            self.thumbnailImage = result;
                                                        }
                                                    }];
}

#pragma mark - Privates

- (void)setThumbnailImage:(UIImage *)thumbnailImage {
    _thumbnailImage = thumbnailImage;
    self.imageView.image = thumbnailImage;
}

- (void)cancelImageRequest {
    if (self.imageRequestID != PHInvalidImageRequestID) {
        [self.imageManager cancelImageRequest:self.imageRequestID];
        self.imageRequestID = PHInvalidImageRequestID;
    }
}

@end
