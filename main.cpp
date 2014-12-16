#include <QApplication>
#include <QQmlApplicationEngine>
#include <QTranslator>
#include <QSplashScreen>

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    //splash
    //QPixmap pixmap(":/splash.jpg");
    //QSplashScreen splash(pixmap);
    //splash.show();

    //translator
    QString locale = QLocale::system().name();
    QTranslator translator;
    translator.load(QString("simpleweather_") + locale, ":/");
    app.installTranslator(&translator);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    //splash.close();

    return app.exec();
}
