# Тестовое приложение для подлючения фрэймворка SCKit.framework
Подключение фрэймворка:

1. Перетащить фрэймворк SCKit.framework в проект

2. В таргете на закладке Build Phases добавить фрэймворк в раздел Embed Framework

3. В настройках проекта выставить параметр "Embedded content contains swift code" в YES

4. В Info.plist проекта добавить разрешение на передачу по сети: 
~~~~
   NSAppTransportSecurity 
   NSAllowsArbitraryLoads
~~~~
5\. Если у приложения нет уникальной URL схемы, то ее нужно создать:
~~~~
   CFBundleURLTypes
   CFBundleURLName
   com.application.fabuzaExample
   CFBundleURLSchemes
   fabuzaExample
~~~~
6\. Поскольку фрэймворк собран универсальным и для симулятора и для телефона, то перед отправкой в аппстор из него нужно удалить архитектуру симулятора. Это делает нижеследующий скрипт, который нужно в настройках таргета, на закладке Build Phases добавить, как "New run script phase":
~~~~
    APP_PATH="${TARGET_BUILD_DIR}/${WRAPPER_NAME}"
    This script loops through the frameworks embedded in the application and removes unused architectures.
    find "$APP_PATH" -name '*.framework' -type d | while read -r FRAMEWORK
    do
    FRAMEWORK_EXECUTABLE_NAME=$(defaults read "$FRAMEWORK/Info.plist" CFBundleExecutable)
    FRAMEWORK_EXECUTABLE_PATH="$FRAMEWORK/$FRAMEWORK_EXECUTABLE_NAME"
    echo "Executable is $FRAMEWORK_EXECUTABLE_PATH"

    EXTRACTED_ARCHS=()

    for ARCH in $ARCHS
    do
    echo "Extracting $ARCH from $FRAMEWORK_EXECUTABLE_NAME"
    lipo -extract "$ARCH" "$FRAMEWORK_EXECUTABLE_PATH" -o "$FRAMEWORK_EXECUTABLE_PATH-$ARCH"
    EXTRACTED_ARCHS+=("$FRAMEWORK_EXECUTABLE_PATH-$ARCH")
    done

    echo "Merging extracted architectures: ${ARCHS}"
    lipo -o "$FRAMEWORK_EXECUTABLE_PATH-merged" -create "${EXTRACTED_ARCHS[@]}"
    rm "${EXTRACTED_ARCHS[@]}"

    echo "Replacing original executable with thinned version"
    rm "$FRAMEWORK_EXECUTABLE_PATH"
    mv "$FRAMEWORK_EXECUTABLE_PATH-merged" "$FRAMEWORK_EXECUTABLE_PATH"

    done
~~~~
7\. В AppDelegate.h вставить:
    ``#import``
и два свойства
~~~~
    @property (strong, nonatomic) FZTouchVisualizerWindow _window;_
    _@property (nonatomic) NSURL _externalUrl;
~~~~
8\. В AppDelegate.m вставить:
~~~~    @interface AppDelegate () 
    @property (nonatomic) FZTestEngine *testEngine;
    @end

    (FZTouchVisualizerWindow _)window {_
    _  static FZTouchVisualizerWindow _customWindow = nil;

    if (!customWindow) {

    customWindow = [[FZTouchVisualizerWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    }
    
    return customWindow;

    }

    //В iOS9 нужно использовать
    //- (BOOL)application:(UIApplication _)application openURL:(NSURL _)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation

    (BOOL)application:(UIApplication _)app openURL:(NSURL _)url options:(NSDictionary *)options {
    self.externalUrl = url;

    return YES;

    }

    (void)applicationDidBecomeActive:(UIApplication *)application {

    if (self.externalUrl) {

    [self initSCKit]; 

    } else {

    [self openFabuzaWithParams:@{@"bundleId" : [[NSBundle mainBundle] bundleIdentifier]}]; 

    }
    }

    (void)openFabuzaWithParams:(NSDictionary *)params {

    if (self.testEngine == nil) {
    self.testEngine = [FZTestEngine new];   self.testEngine.dataSource = self;   self.testEngine.delegate = self; 
    }
    [self.testEngine openFabuzaWithParams:params];
    }

    #pragma mark - SCKit initialization

    (void)initSCKit {
    self.testEngine = [FZTestEngine new];
    self.testEngine.dataSource = self;
    self.testEngine.delegate = self;
    [self.testEngine on];
    }

    #pragma mark - FZTestEngineDataSource

    (NSURL *)getExternalUrl {
    return self.externalUrl;
    }

    (NSUInteger)getVideoFilesSize {

    return self.window.videoSize;
    }

    #pragma mark - FZTestEngineDelegate

    (void)startRecordScreen:(BOOL)screenRecord andCamera:(BOOL)cameraRecord {
    //Для проектов использующих камеру, запись надо выключать andCamera:NO
    [self.window startRecordScreen:screenRecord andCamera:YES];
    }

    (void)stopRecordWithProgress:(void (^)(NSProgress _progress))progress_

    _success:(void (^)(NSString _pathToScreenFile, NSString _pathToCameraFile))success_
    _failure:(void (^)(NSError _error))failure {
    [self.window stopRecordWithProgress:progress success:success failure:failure];
    }

    (void)didEndProcess {

    NSDictionary *params = [self.testEngine parseExternalTestParamsFromUrl:self.externalUrl];
    [self openFabuzaWithParams:params];
    }
~~~~