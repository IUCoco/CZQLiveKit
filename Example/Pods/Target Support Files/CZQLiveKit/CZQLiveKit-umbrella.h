#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "XMGAudienceViewController.h"
#import "XMGBroadcasterViewController.h"
#import "XMGLiveChatViewController.h"
#import "XMGLiveGiftViewController.h"
#import "XMGLiveOverlayViewController.h"
#import "XMGUpVoteViewController.h"
#import "XMGGiftItem.h"
#import "XMGMessageItem.h"
#import "XMGRoomItem.h"
#import "XMGUserItem.h"
#import "XMGGiftAnimView.h"
#import "XMGGiftButton.h"
#import "XMGLiveListViewController.h"
#import "XMGCreatorItem.h"
#import "XMGLiveItem.h"
#import "XMGLiveCell.h"
#import "SocketIOClient+XMGSocket.h"

FOUNDATION_EXPORT double CZQLiveKitVersionNumber;
FOUNDATION_EXPORT const unsigned char CZQLiveKitVersionString[];

