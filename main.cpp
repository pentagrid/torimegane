/*! \file
 * Torimegane video WebRTC+MAVSDK integration demo.
 * \author david.perek@brincdrones.com
 * \copyright 2022 Brinc Drones Inc, all rights reserved
 */

#include <QtGui/QGuiApplication>
#include <QtQml/QQmlApplicationEngine>
#include <QtWebEngine/qtwebengineglobal.h>
#include "bd_backend.hpp"
 
int main(int argc, char *argv[])
{
    QCoreApplication::setOrganizationName("BrincDrones");
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QCoreApplication::setAttribute(Qt::AA_ShareOpenGLContexts);
    QGuiApplication app(argc, argv);
    
    qmlRegisterType<bdBackEnd>("com.brincdrones", 1, 0, "BdBackEnd");
    
    QQmlApplicationEngine engine;
    QtWebEngine::initialize();
    engine.load(QUrl::fromLocalFile("../quick/main.qml"));

  return app.exec();
}
