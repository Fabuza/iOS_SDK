# SCKit (FABUZA SDK)

Фреймворк SCKIT предназначен для записи экрана мобильного приложения (с отображением жестов), а так же записи видео с фронтальной камеры и голоса с микрофона.

Фреймворк инициализируется и взаимодействует только с приложением FABUZA. Которое является приложением-менеджером для проведения юзабилити-теста. Оно передаёт в SCKIT все необходимые данные для старта записи взаимодействия (через параметры вызова url_schema). 

Приложение с SCKIT включает запись, устанавливает связь с сервером api.fabuza.ru и ждёт команду завершения шага теста. После получения команды, приложение сохраняет данные и отправляет их на сервер api.fabuza.ru, после чего вызывает приложение FABUZA (и передаёт управление ему).

Приложение с интегрированным SDK возможно распространять через appstore (SDK основан на официальном api), но гораздо проще и удобнее публиковать приложения предназначенные для юзабилити-тестов как in-house app через Enterprise Development Program. Получившиеся при сборке приложения файлы (IPA + PLIST) выкладываются по прямому URL, который используется в параметрах шага "мобильный тест" в сервисе "Фабрика Юзабилити".

Веб-сервер должен иметь правильную настройку mime type:
* plist -> application/xml
* ipa -> application/octet-stream

Подключение Фреймворка:
1. Перетащить Фреймворк SCKit.framework в проект
2. В target на закладке Build Phases добавить Фреймворк в раздел Embed Framework.
3. В настройках проекта выставить параметр "Always Embed Swift Standard Libraries" (в версии Xcode ниже 8 это параметр "Embedded content contains swift code") в YES.
4. В Info.plist проекта добавить разрешение на передачу по сети, на использование камеры, геолокации и микрофона:
```
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
```


5\. Если у приложения нет уникальной URL схемы, то ее нужно создать:

```
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
```


6\. Поскольку Фреймворк собран универсальным и для симулятора и для телефона, то перед отправкой в Appstore из него нужно удалить архитектуру симулятора. Это делает нижеследующий скрипт, который нужно в настройках target, на закладке Build Phases добавить, как "New run script phase":

```
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
```


7\. В AppDelegate.m вставить:

```
#import <SCKit/SCKit.h>

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[FZTestEngine instance] checkActiveTest];
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary *)options {
    [FZTestEngine instance].externalUrl = url;
    [[FZTestEngine instance] on:^{
    
    }];
    return YES;
}
```

8\. Для swift3 в AppDelegate.swift

```
import SCKit

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    FZTestEngine.instance().checkActiveTest()
    return true
}

func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
    FZTestEngine.instance().externalUrl = url
    FZTestEngine.instance().on {
    
    }
    return true
}
```

