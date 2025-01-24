QT += quick sql testlib
CONFIG += c++17

# Имя и версия приложения
TARGET = restaurant
VERSION = 1.0.0

SOURCES += \
    src/main.cpp \
    src/databasemanager.cpp \
    src/customermodel.cpp \
    src/menuitemmodel.cpp \
    src/ordermodel.cpp \
    tests/tst_database.cpp

HEADERS += \
    src/databasemanager.h \
    src/customermodel.h \
    src/menuitemmodel.h \
    src/ordermodel.h

# Добавляем все QML файлы в ресурсы
RESOURCES += qml.qrc

# Устанавливаем директорию для сборки
CONFIG(debug, debug|release) {
    DESTDIR = debug
} else {
    DESTDIR = release
}

# Правила установки
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

# Копирование QML файлов в директорию сборки
win32 {
    CONFIG(debug, debug|release) {
        QMAKE_POST_LINK += $(COPY_DIR) $$shell_path($$PWD/qml) $$shell_path($$OUT_PWD/debug)
    } else {
        QMAKE_POST_LINK += $(COPY_DIR) $$shell_path($$PWD/qml) $$shell_path($$OUT_PWD/release)
    }
} else {
    CONFIG(debug, debug|release) {
        QMAKE_POST_LINK += $(MKDIR) $$OUT_PWD/debug/qml && cp -r $$PWD/qml/* $$OUT_PWD/debug/qml/
    } else {
        QMAKE_POST_LINK += $(MKDIR) $$OUT_PWD/release/qml && cp -r $$PWD/qml/* $$OUT_PWD/release/qml/
    }
}

# Дополнительные определения для сборки
DEFINES += QT_DEPRECATED_WARNINGS
DEFINES += APP_VERSION=\\\"$$VERSION\\\"

# Включаем отладочную информацию в Debug сборке
CONFIG(debug, debug|release) {
    DEFINES += DEBUG
    QMAKE_CXXFLAGS_DEBUG += -g3 -O0
}
