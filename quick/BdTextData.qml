import QtQuick 2.10
import QtQuick.Layouts 1.0

Rectangle
{
    color: "black"
    Layout.fillWidth: true; Layout.fillHeight: true

    property alias yaw: yawDisplayText.text
    property alias pitch: pitchDisplayText.text
    property alias roll: rollDisplayText.text
    property alias ekusu: ekusuDisplayText.text
    property alias wai: waiDisplayText.text
    property alias zetto: zettoDisplayText.text


    GridLayout 
    {
        id: grid
        columns: 4; rows: 3
        columnSpacing: 4; rowSpacing: 1
        anchors.fill: parent

        property var textColor: "white"

        Text { text: "Yaw  "; font.bold: true; color: grid.textColor }
        Text { id: yawDisplayText; text: "0.000"; font.bold: false; color: grid.textColor }
        Text { text: "X    "; font.bold: true; color: grid.textColor }
        Text { id: ekusuDisplayText; text: "0.000"; font.bold: false; color: grid.textColor }
        Text { text: "Pitch"; font.bold: true; color: grid.textColor }
        Text { id: pitchDisplayText; text: "0.000"; font.bold: false; color: grid.textColor }
        Text { text: "Y"; font.bold: true; color: grid.textColor }
        Text { id: waiDisplayText; text: "0.000"; font.bold: false; color: grid.textColor }        
        Text { text: "Roll"; font.bold: true; color: grid.textColor }
        Text { id: rollDisplayText; text: "0.000"; font.bold: false; color: grid.textColor }
        Text { text: "Z"; font.bold: true; color: grid.textColor }
        Text { id: zettoDisplayText; text: "0.000"; font.bold: false; color: grid.textColor }        
    }
}
