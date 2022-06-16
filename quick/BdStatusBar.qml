import QtQuick 2.10
import QtQuick.Layouts 1.0

Rectangle
{
    color: "black"
    Layout.fillWidth: true; Layout.fillHeight: true

    property alias textDisplayData: textData
    property alias extDisplayData: extData
    property alias batteryData: battery


    GridLayout 
    {
        id: grid
        columns: 4; rows: 1
        columnSpacing: 4
        anchors.fill: parent

        Image { source: "brinc_white.png"; Layout.fillHeight: false; Layout.fillWidth: false ; Layout.preferredWidth: 100; Layout.preferredHeight: 100; fillMode: Image.PreserveAspectFit; Layout.leftMargin: 10; Layout.rightMargin: 20 }
        BdTextData{id: textData; Layout.fillWidth: true; Layout.fillHeight: true; width: 100}
        BdVelocity{id: extData; Layout.fillWidth: true; Layout.fillHeight: true; width: 100}
        GridLayout
        {
            columns: 1; rows: 2
            rowSpacing: 4
            Layout.leftMargin: 5; Layout.rightMargin: 5
            Layout.topMargin: 5; Layout.bottomMargin: 5        
            Row
            {
                Layout.leftMargin: 15; Layout.rightMargin: 15
                Layout.topMargin: 10; Layout.bottomMargin: 10    
                BdRssi{ id: rssi; width: 50; height: 25 }
            }
            Row
            {
                Layout.leftMargin: 15; Layout.rightMargin: 15
                Layout.topMargin: 10; Layout.bottomMargin: 10
                BdBatteryTest{ id: battery; width: 50; height: 25 }
            }
        }
    }
}
