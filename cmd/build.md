```shell
#!/bin/bash

cd ..
flutter clean

#echo 'build web canvaskit'
#flutter build web --web-renderer canvaskit

echo 'build web'
flutter build web
#flutter build web --web-renderer html


```
```shell
#!/bin/bash

cd ..
flutter clean
echo 'build for arm64 macos'
flutter build macos
```

```shell
#!/bin/bash

cd ..
flutter clean
echo 'build for android'
flutter build apk 
```
