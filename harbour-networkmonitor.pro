# The name of your app.
# NOTICE: name defined in TARGET has a corresponding QML filename.
#         If name defined in TARGET is changed, following needs to be
#         done to match new name:
#         - corresponding QML filename must be changed
#         - desktop icon filename must be changed
#         - desktop filename must be changed
#         - icon definition filename in desktop file must be changed
TARGET = harbour-networkmonitor

CONFIG += sailfishapp

SOURCES += src/harbour-networkmonitor.cpp

OTHER_FILES += \
    qml/cover/CoverPage.qml \
    qml/pages/FirstPage.qml \
    qml/pages/About.qml \
    rpm/harbour-networkmonitor.spec \
    rpm/harbour-networkmonitor.yaml \
    harbour-networkmonitor.desktop \
    qml/pages/Xhr.js \
    qml/harbour-networkmonitor.qml

