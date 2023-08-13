#!/bin/bash

cd ../..

flutter packages pub get
flutter gen-l10n --arb-dir=lib/l10n/language --template-arb-file=app_en.arb --output-dir=lib/l10n/generated --no-synthetic-package
