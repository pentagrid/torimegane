/*! \file bd_backend.hpp
 * \brief this file serves as a simple data backend interface for QtQuick
 *  for MAVSDK sources. It publishes all data streams via a QVariantMap 
 * via the getTelem() function.
 * 
 **/
#ifndef BDBACKEND_HPP
#define BDBACKEND_HPP

#include <QObject>
#include <QString>
#include <QDebug>
#include <qqml.h>
#include <iostream>
#include <memory>
#include "bd_backend.hpp"
#include "bd_telemetry.hpp"

class bdBackEnd : public QObject
{
    Q_OBJECT
public:
    /*! \brief Constructor which allows this class to be instatiated in QML*/
    explicit bdBackEnd(QObject *parent = nullptr);

    Q_INVOKABLE void connect(QString server);

    Q_INVOKABLE bool isConnected();    

    /*! \brief returns a qvariantmap with all pulled telemetry data */
    Q_INVOKABLE QVariantMap getTelem()
    { 
        QVariantMap map;
        float yaw, pitch, roll; 
        float x_m, y_m, z_m, vx, vy, vz;
        float voltage, percent;
        bool can_arm, pos_ok, sens_ok;
        telem->getEuler(yaw, pitch, roll); 
        //telem->getOdometry(x_m, y_m, z_m);
        telem->getNed(x_m, y_m, z_m, vx, vy, vz);
        telem->getHealthBattery(voltage, percent, can_arm, pos_ok, sens_ok);

        map.insert("yaw", yaw);
        map.insert("pitch", pitch);
        map.insert("roll", roll);
        map.insert("x_body", x_m);
        map.insert("y_body", y_m);
        map.insert("z_body", z_m);
        map.insert("x_speed", vx);
        map.insert("y_speed", vy);
        map.insert("z_speed", vz);
        map.insert("batt_voltage", voltage);
        map.insert("batt_percent", percent);
        map.insert("pos_ok", pos_ok);
        map.insert("can_arm", can_arm);
        map.insert("imu_ok", sens_ok);
        return map;
    }

private:
    std::unique_ptr<bdTelemetry> telem;
};

#endif // BDBACKEND_HPP
