#include "bd_backend.hpp"

bdBackEnd::bdBackEnd(QObject *parent) :
    QObject(parent) , telem(std::make_unique<bdTelemetry>()){}


void bdBackEnd::connect(QString server)
{
    telem->connect(server.toStdString());
}

bool bdBackEnd::isConnected()
{
    return telem->isConnected();
}