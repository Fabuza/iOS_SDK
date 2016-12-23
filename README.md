# SCKit

Фрэймворк для записи жестов с экрана и видео с фронтальной камеры

Подключение фрэймворка:

1/ Перетащить фрэймворк SCKit.framework в проект

2/ В таргете на закладке Build Phases добавить фрэймворк в раздел Embed Framework

3/ В настройках проекта выставить параметр "Always Embed Swift Standard Libraries" (в версии xcode ниже 8 это параметр "Embedded content contains swift code") в YES 

4/ В Info.plist проекта добавить разрешение на передачу по сети, на использование камеры, геолокации и микрофона:
~~~~
    <key>NSAppTransportSecurity</key>
    <dict>
        <key>NSAllowsArbitraryLoads</key>
        <true/>
    </dict>

    <key>NSCameraUsageDescription</key>
    <string>Need Camera</string>
    <key>NSLocationUsageDescription</key>
    <string>Need Location</string>
    <key>NSLocationWhenInUseUsageDescription</key>
    <string>Геолокация используется только когда приложение запущено</string>
    <key>NSMicrophoneUsageDescription</key>
    <string>Need Microphone</string>
~~~~

5/ Если у приложения нет уникальной URL схемы, то ее нужно создать:
~~~~
<key>CFBundleURLTypes</key>
<array>
    <dict>
    <key>CFBundleURLName</key>
    <string>com.application.fabuzaExample</string>
    <key>CFBundleURLSchemes</key>
    <array>
        <string>fabuzaExample</string>
    </array>
    </dict>
</array>
~~~~

6/ Поскольку фрэймворк собран универсальным и для симулятора и для телефона, то перед отправкой в аппстор из него нужно удалить архитектуру симулятора. Это делает нижеследующий скрипт, который нужно в настройках таргета, на закладке Build Phases добавить, как "New run script phase":
~~~~
APP_PATH="${TARGET_BUILD_DIR}/${WRAPPER_NAME}"

# This script loops through the frameworks embedded in the application and
# removes unused architectures.
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

7/ В AppDelegate.m вставить:
~~~~
#import <SCKit/SCKit.h>

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[FZTestEngine instance] on];
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary *)options {
    [FZTestEngine instance].externalUrl = url;
    return YES;
}
~~~~

8/ Для swift3 в AppDelegate.swift
~~~~
import SCKit

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    FZTestEngine.instance().on()
    return true
}

func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
    FZTestEngine.instance().externalUrl = url
    return true
}
~~~~
