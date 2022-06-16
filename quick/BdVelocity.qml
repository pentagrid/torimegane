import QtQuick 2.10
import QtQuick.Layouts 1.0

Rectangle
{
    color: "black"
    Layout.fillWidth: true; Layout.fillHeight: true

    property alias vx: xVel.text
    property alias vy: yVel.text
    property alias vz: zVel.text
    property alias voltage: voltageDisplayText.text
    property alias can_arm: canArmDisplay.text
    property alias imu_good: sensorHealthDisplay.text


    GridLayout 
    {
        id: grid
        columns: 4; rows: 3
        columnSpacing: 4; rowSpacing: 1
        anchors.fill: parent

        property var textColor: "white"

        Text { text: "speed X"; font.bold: true; color: grid.textColor }
        Text { id: xVel; text: "0.000"; font.bold: false; color: grid.textColor }
        Text { text: "Voltage"; font.bold: true; color: grid.textColor }
        Text { id: voltageDisplayText; text: "0.000"; font.bold: false; color: grid.textColor }
        Text { text: "speed Y"; font.bold: true; color: grid.textColor }
        Text { id: yVel; text: "0.000"; font.bold: false; color: grid.textColor }
        Text { text: "armable"; font.bold: true; color: grid.textColor }
        Text { id: canArmDisplay; text: "0.000"; font.bold: false; color: grid.textColor }        
        Text { text: "speed Z"; font.bold: true; color: grid.textColor }
        Text { id: zVel; text: "0.000"; font.bold: false; color: grid.textColor }
        Text { text: "imu good"; font.bold: true; color: grid.textColor }
        Text { id: sensorHealthDisplay; text: "0.000"; font.bold: false; color: grid.textColor }        
    }
}
